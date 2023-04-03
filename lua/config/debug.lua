require("config.keybinding")

local dapp = require('dap-go')
dapp.setup {
	-- Additional dap configurations can be added.
	-- dap_configurations accepts a list of tables where each entry
	-- represents a dap configuration. For more details do:
	-- :help dap-configuration
	dap_configurations = {
		{
			-- Must be "go" or it will be ignored by the plugin
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	-- delve configurations
	delve = {
		-- time to wait for delve to initialize the debug session.
		-- default to 20 seconds
		initialize_timeout_sec = 20,
		-- a string that defines the port to start delve debugger.
		-- default to string "${port}" which instructs nvim-dap
		-- to start the process in a random available port
		port = "${port}"
	},
}

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = {'dap', '-l', '127.0.0.1:${port}'},
	}
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
		args = { "server", "--internal"},
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	-- works with go.mod packages and sub packages 
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}"
	},
}



