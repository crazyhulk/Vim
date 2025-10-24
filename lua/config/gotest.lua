-- 获取 git path
local gitRootPath = vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]")
local config = require('go.config')
local appid = 'comic.comic.sniper-service'
config.options.test_env = {
	-- HTTP_PROXY = 'http://127.0.0.1:8888',
	-- http_proxy = 'http://127.0.0.1:8888',
	APP_ID = appid,
	ENV = 'uat',
	GOARCH = 'amd64',
	CONF_PATH = gitRootPath,
	-- CONF_PATH = '/Users/bilibili/workspace/go/sniper',
	MYSQL_ROOT_PASSWORD = 'root',
	ZONE = 'sh001',
	DEPLOY_ENV = 'uat',
}

