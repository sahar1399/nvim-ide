return {
  {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>i", "<cmd>IconPickerNormal<cr>", opts)
    end,
  },
  {
    "Pocco81/HighStr.nvim",
    config = function()
      local high_str = require("high-str")

      high_str.setup({
        verbosity = 0,
        saving_path = "/tmp/highstr/",
        highlight_colors = {
          -- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
          color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
          color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
          color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
          color_3 = { "#8A2BE2", "smart" }, -- Proton purple
          color_4 = { "#FF4500", "smart" }, -- Orange red
          color_5 = { "#008000", "smart" }, -- Office green
          color_6 = { "#0000FF", "smart" }, -- Just blue
          color_7 = { "#FFC0CB", "smart" }, -- Blush pink
          color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
          color_9 = { "#7d5c34", "smart" }, -- Fallow brown
        },
      })

      vim.api.nvim_set_keymap("v", "<leader>h", ":<c-u>HSHighlight 1<CR>", {
        noremap = true,
        silent = true,
      })

      vim.api.nvim_set_keymap("v", "<leader>H", ":<c-u>HSRmHighlight<CR>", {
        noremap = true,
        silent = true,
      })
    end,
  },
}
