return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	lazy = false,
	opts = {},
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		{
			"<leader>vs",
			"<cmd>:VenvSelect<cr>",
			mode = "n",
			desc = "Select Venv",
		},
		{
			"<leader>vc",
			"<cmd>:VenvSelectCached<cr>",
			mode = "n",
			desc = "Select Cacched Venv",
		},
	},
	config = function()
		local cwd = vim.fn.getcwd()
		local venv_selector = require("venv-selector")

    local venv_search_path = nil

    if vim.fn.findfile("pyproject.toml", cwd .. ";") ~= '' then
      venv_search_path = cwd
    else
      if vim.g.wenrix_workdir and vim.fn.findfile("pyproject.toml", vim.g.wenrix_workdir .. ";") ~= '' then
        venv_search_path = vim.g.wenrix_workdir
      end
    end

		venv_selector.setup({
			dap_enabled = true,
			auto_refresh = true,
			name = { "venv", ".venv" },
			path = venv_search_path, -- venv_search_path,
			changed_venv_hooks = { venv_selector.hooks.pyright },
			parents = 0,
		})

		vim.api.nvim_create_autocmd("VimEnter", {
			desc = "Auto select virtualenv Nvim open",
			pattern = "*",
			callback = function()
				local path = venv_search_path or vim.fn.getcwd()
				local venv = vim.fn.findfile("pyproject.toml", path .. ";")
				if venv ~= "" then
					venv_selector.retrieve_from_cache()
				end

				local src_venv = vim.fn.findfile("src/pyproject.toml", path .. ";")
				if src_venv ~= "" then
					venv_selector.retrieve_from_cache()
				end
			end,
			once = true,
		})
	end,
}
