local M = {}

local vim = vim
local config = require('go.config')
local util = require('go.util')
local output = require('go.output')

local function build_args(args)
	local test_timeout = config.options.test_timeout
	if test_timeout then
		table.insert(args, string.format('-timeout=%s', test_timeout))
	end
	local test_flags = config.options.test_flags
	if test_flags then
		for _, f in ipairs(test_flags) do
			table.insert(args, f)
		end
	end
	-- redirect stderr to stdout so neovim won't crash
	table.insert(args, '2>&1')

	return table.concat(args, ' ')
end

local function valid_func_name(func_name)
	if not func_name then
		return false
	end
	if
		vim.startswith(func_name, 'Test')
		or vim.startswith(func_name, 'Example')
	then
		return true
	end

	return false
end

local function split_file_name(str)
	return vim.fn.split(vim.fn.split(str, ' ')[2], '(')[1]
end

local function valid_buf()
	local buf_nr = vim.api.nvim_get_current_buf()
	if
		vim.api.nvim_buf_is_valid(buf_nr)
		and vim.api.nvim_buf_get_option(buf_nr, 'buflisted')
	then
		return true
	end

	return false
end

function printTable(tbl, indent)
    indent = indent or 0
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(string.rep("  ", indent) .. k .. ":")
            printTable(v, indent + 1)
        else
            print(string.rep("  ", indent) .. k .. ": " .. v)
        end
    end
end

local function do_test(prefix, cmd, extra)
	if not valid_buf() then
		return
	end
	-- calc popup window size here
	local pos = output.calc_popup_size()
	local function on_event(_, data, event)
		if config.options.test_popup and not util.empty_output(data) then
			-- print("=======", vim.inspect(data[#data-3]))
			if string.find(data[#data-3], 'PASS: ' .. extra.func) then
				require("notify").notify('PASS: ' .. extra.func, "info", {title = "Test passed", message = extra.func})
				-- return
			end
			return output.popup_job_result(data, {
				title = prefix,
				pos = pos,
			})
		else
			local outputs = {}
			for _, v in ipairs(data) do
				if string.len(v) > 0 then
					table.insert(outputs, v)
				end
			end
			if #outputs > 0 then
				local msg = table.concat(output, '\n')
				if event == 'stdout' then
					output.show_info(prefix, msg)
				elseif event == 'stderr' then
					output.show_error(prefix, msg)
				end
			end
		end
	end

	local cwd = vim.fn.expand('%:p:h')
	local env = config.options.test_env
	local opts = {
		on_exit = function(_, code, _)
			if code ~= 0 then
				output.show_warning(
					prefix,
					string.format('error code: %d', code)
				)
			end
		end,
		cwd = cwd,
		on_stdout = on_event,
		on_stderr = on_event,
		stdout_buffered = true,
		stderr_buffered = true,
	}
	-- print("========2", vim.inspect(env))
	if env ~= nil and next(env) ~= nil then
		opts['env'] = env
	end
	vim.fn.jobstart(cmd, opts)
end

function M.test()
	if not util.binary_exists('go') then
		return
	end

	local prefix = 'GoTest'
	local cmd = { 'go', 'test' }
	do_test(prefix, build_args(cmd))
end

function M.test_all()
	if not util.binary_exists('go') then
		return
	end

	local prefix = 'GoTestAll'
	local cmd = { 'go', 'test', './...' }
	do_test(prefix, build_args(cmd))
end

function GetFunctionNameByLSP()
	-- Get the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	-- Get the current buffer and language server client
	local bufnr = vim.api.nvim_get_current_buf()
	local client_id = vim.lsp.get_active_clients()[1].id

	-- Define the request parameters
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(),
		position = { line = cursor_pos[1] - 1, character = cursor_pos[2] - 1 }
	}

	resp = vim.lsp.buf_request_sync(bufnr, 'textDocument/documentSymbol', params, 100) 

	-- Search for the nearest function symbol above the current line
	local function_symbol
	for _, xsymbol in pairs(resp or {}) do
		for _, ysymbol in pairs(xsymbol or {}) do
			for _, symbol in pairs(ysymbol or {}) do
				-- print(vim.inspect(symbol.range["end"]))
				if symbol.kind == 12 and symbol.range.start.line < cursor_pos[1] and symbol.range["end"].line >= cursor_pos[1]  then
					return symbol.name
				end
			end
		end
	end
	-- print(vim.inspect(resp))
	print(function_symbol)
end

function M.test_func(opt)
	if not util.binary_exists('go') then
		return
	end

	local prefix = 'GoTestFunc'
	-- local func_name = ''
	local func_name = GetFunctionNameByLSP() 
	-- this is not available now actually
	-- if opt and opt.func then
	-- 	func_name = opt.func
	-- else
	-- 	local line = vim.fn.search([[func \(Test\|Example\)]], 'bcnW')
	-- 	if line == 0 then
	-- 		output.show_error(
	-- 			prefix,
	-- 			string.format('Test func not found: %s', func_name)
	-- 		)
	-- 		return
	-- 	end
	-- 	local cur_line = util.current_line()
	-- 	func_name = split_file_name(cur_line)
	-- end
	if not valid_func_name(func_name) then
		output.show_error(
			'GoTestFunc',
			string.format('Invalid test func: %s', func_name)
		)
		return
	end
	local cmd = {
		'go',
		'test',
		'-gcflags=-l',
		'-run',
		vim.fn.shellescape(string.format('^%s$', func_name)),
	}
	do_test(prefix, build_args(cmd), { func = func_name })
end

function M.test_file()
	if not util.binary_exists('go') then
		return
	end

	local prefix = 'GoTestFile'
	local pattern = vim.regex('^func [Test|Example]')
	local lines = vim.api.nvim_buf_get_lines(
		vim.api.nvim_get_current_buf(),
		1,
		-1,
		false
	)
	local func_names = {}
	if #lines == 0 then
		return
	end
	for _, line in ipairs(lines) do
		local col_from, _ = pattern:match_str(line)
		if col_from then
			local fn = split_file_name(line)
			if valid_func_name(fn) then
				table.insert(func_names, fn)
			end
		end
	end
	local cmd = {
		'go',
		'test',
		'-run',
		vim.fn.shellescape(string.format('^%s$', table.concat(func_names, '|'))),
	}
	do_test(prefix, build_args(cmd))
end

local function valid_file(fn)
	if vim.endswith(fn, '_test.go') then
		return 1
	elseif vim.endswith(fn, '.go') then
		return 0
	end

	return -1
end

function M.test_open(cmd)
	local buf_nr = vim.api.nvim_get_current_buf()
	local file_path = vim.api.nvim_buf_get_name(buf_nr)
	local new_fn
	local vf = valid_file(file_path)
	if vf == 1 then
		new_fn = file_path:gsub('_test.go$', '.go')
	elseif vf == 0 then
		new_fn = file_path:gsub('.go$', '_test.go')
	else
		output.show_error('GoTestOpen', 'not a `.go` file')
		return
	end

	if cmd == nil or cmd == '' then
		cmd = config.options.test_open_cmd
	end
	vim.api.nvim_command(string.format('%s %s', cmd, new_fn))
end

-- export for testing
M._valid_file = valid_file
M._valid_func_name = valid_func_name
M._split_file_name = split_file_name
M._build_args = build_args

return M
