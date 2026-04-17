local M = {}

local vim = vim
local output = require('go.output')
local util = require('go.util')

M.options = {
	test_env = {},
}

local function get_test_func_name()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local bufnr = vim.api.nvim_get_current_buf()
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(),
		position = { line = cursor_pos[1] - 1, character = cursor_pos[2] - 1 },
	}

	local resp = vim.lsp.buf_request_sync(bufnr, 'textDocument/documentSymbol', params, 1000)
	local line = cursor_pos[1] - 1

	-- 在 symbols 中查找包含光标的函数，返回 { class_name, func_name }
	local function find_func(symbols)
		for _, symbol in ipairs(symbols) do
			-- kind 5 = Class: 检查类内部的方法
			if symbol.kind == 5
				and symbol.range.start.line <= line
				and symbol.range['end'].line >= line
				and symbol.children then
				for _, child in ipairs(symbol.children) do
					if (child.kind == 12 or child.kind == 6)
						and child.range.start.line <= line
						and child.range['end'].line >= line then
						return symbol.name .. '::' .. child.name
					end
				end
			end
			-- kind 12 = Function: 顶层函数
			if symbol.kind == 12
				and symbol.range.start.line <= line
				and symbol.range['end'].line >= line then
				return symbol.name
			end
		end
		return nil
	end

	for _, result in pairs(resp or {}) do
		local symbols = result.result or {}
		local name = find_func(symbols)
		if name then
			return name
		end
	end
	return nil
end

local function valid_func_name(name)
	if not name then
		return false
	end
	-- 顶层 test_ 函数，或 Class::test_ 方法
	if vim.startswith(name, 'test_') then
		return true
	end
	if string.find(name, '::test_') then
		return true
	end
	return false
end

local function do_test(prefix, cmd)
	local pos = output.calc_popup_size()
	local func_name = cmd.func_name

	local function on_event(_, data, event)
		if not util.empty_output(data) then
			-- 检查是否通过
			for _, line in ipairs(data) do
				if func_name and string.find(line, 'PASSED') then
					require('notify').notify('PASSED: ' .. func_name, 'info', { title = 'PyTest' })
				end
			end
			return output.popup_job_result(data, {
				title = prefix,
				pos = pos,
			})
		end
	end

	local cwd = cmd.cwd or vim.fn.expand('%:p:h')
	local opts = {
		on_exit = function(_, code, _)
			if code ~= 0 then
				output.show_warning(prefix, string.format('error code: %d', code))
			end
		end,
		cwd = cwd,
		on_stdout = on_event,
		on_stderr = on_event,
		stdout_buffered = true,
		stderr_buffered = true,
	}

	local env = M.options.test_env
	if env ~= nil and next(env) ~= nil then
		opts['env'] = env
	end

	vim.fn.jobstart(cmd.args, opts)
end

function M.test_func()
	if not util.binary_exists('pytest') then
		return
	end

	local prefix = 'PyTestFunc'
	local func_name = get_test_func_name()
	if not valid_func_name(func_name) then
		output.show_error(prefix, string.format('Invalid test func: %s', func_name or 'nil'))
		return
	end

	local file = vim.fn.expand('%:p')
	-- pytest node id: file::Class::method 或 file::func
	local node_id = file .. '::' .. func_name
	do_test(prefix, {
		args = string.format('pytest -xvs --color=no %s 2>&1', vim.fn.shellescape(node_id)),
		func_name = func_name,
	})
end

function M.test_file()
	if not util.binary_exists('pytest') then
		return
	end

	local file = vim.fn.expand('%:p')
	do_test('PyTestFile', {
		args = string.format('pytest -xvs --color=no %s 2>&1', vim.fn.shellescape(file)),
	})
end

return M
