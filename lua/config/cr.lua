require("git").setup({
	-- GitLab settings
	gitlab = {
		auth_token = vim.env.GITLAB_TOKEN,
		url = vim.env.GITLAB_URL or "https://gitlab.com",
	},

	-- CR mode settings
	cr_mode = {
		highlights = {
			added = { bg = "#1a4d1a", fg = nil },
			deleted = { bg = "#4d1a1a", fg = nil },
			modified = { bg = "#4d4d1a", fg = nil },
			comment_marker = { fg = "#ff9900", bold = true },
		},
		virtual_text = {
			enabled = true,
			comment_icon = "💬",
			show_author = true,
			max_length = 80,
		},
		signs = {
			enabled = true,
			added = "+",
			deleted = "-",
			modified = "~",
			comment = "●",
		},
	},

	-- Keymaps
	keymaps = {
		enabled = true,
		toggle_cr_mode = "<leader>cr",
		add_comment = "<leader>cc",
		view_comments = "<leader>co",
		sync_comments = "<leader>cg",
		next_change = "]c",
		prev_change = "[c",
	},
})
