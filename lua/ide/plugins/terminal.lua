local opts = { silent = true }

local trim_spaces = false

local set_opfunc = vim.fn[vim.api.nvim_exec(
	[[
  func s:set_opfunc(val)
    let &opfunc = a:val
  endfunc
  echon get(function('s:set_opfunc'), 'name')
]],
	true
)]

return {
	{
		"akinsho/toggleterm.nvim",
		enabled = not vim.g.non_modified,
		keys = {
			{
				"<C-t>",
				"<cmd>:ToggleTerm<cr>",
				opts,
				mode = "n",
				desc = "Toogle Terminal",
			},
			{
				"<leader>ts",
				function()
					set_opfunc(function(motion_type)
						require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
					end)
					vim.api.nvim_feedkeys("g@", "n", false)
				end,
				opts,
				mode = "n",
				desc = "Send Line To Terminal",
			},
			{
				"<leader>ts",
				function()
          local selection_type = ""
          if vim.fn.mode() == "V" then
            selection_type="visual_lines"
          else
            selection_type="visual_selection"
          end

					require("toggleterm").send_lines_to_terminal(
						selection_type,
						trim_spaces,
						{ args = vim.v.count }
					)
				end,
				opts,
				mode = "x",
				desc = "Send Line To Terminal",
			},
		},
		opts = function()
			require("toggleterm").setup()
		end,
	},
}
