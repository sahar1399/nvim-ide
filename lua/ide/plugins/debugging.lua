local opts = { noremap = true, silent = true }

return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require("dap.ext.vscode").load_launchjs()
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⭕", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "❓", texthl = "red", linehl = "", numhl = "" })
    end,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("nvim-dap-virtual-text").setup({
            enabled = true,                  -- enable this plugin (the default)
            enabled_commands = true,         -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true,         -- show stop reason when stopped for exceptions
            commented = false,               -- prefix virtual text with comment string
            only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
            all_references = false,          -- show virtual text on all all references of the variable (not only definitions)
            filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
            -- experimental features:
            virt_text_pos = "eol",           -- position of virtual text, see `:h nvim_buf_set_extmark()`
            all_frames = false,              -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,              -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil,         -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
          })
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          local dapui = require("dapui")

          dapui.setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },
            mappings = {
              -- Use a table to apply multiple mappings
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
              -- Example:
              -- stacks = {
              --   open = "<CR>",
              --   expand = "o",
              -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
              {
                elements = {
                  -- Elements can be strings or table with id and size keys.
                  { id = "scopes",  size = 0.5 },
                  -- "breakpoints",
                  { id = "stacks",  size = 0.3 },
                  { id = "watches", size = 0.2 },
                },
                size = 0.4, -- 40 columns
                position = "left",
              },
              {
                elements = {
                  { id = "repl",    size = 0.7 },
                  { id = "console", size = 0.3 },
                },
                size = 0.5, -- 25% of total lines
                position = "bottom",
              },
            },
            controls = {
              -- Requires Neovim nightly (or 0.8 when released)
              enabled = true,
              -- Display controls in this element
              element = "repl",
              icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
              },
            },
            floating = {
              max_height = nil, -- These can be integers or a float between 0 and 1.
              max_width = nil, -- Floats will be treated as percentage of your screen.
              border = "single", -- Border style. Can be "single", "double" or "rounded"
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil, -- Can be integer or nil.
              max_value_lines = 100, -- Can be integer or nil.
            },
          })

          vim.cmd([[
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType dapui* set number
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType dapui* set relativenumber
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType \[dap-* set number
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType \[dap-* set relativenumber
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType DAP* set number
            autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,FileType DAP* set relativenumber
          ]])

          -- local dap = require("dap")
          -- dap.listeners.after.event_initialized["dapui_config"] = function()
          -- 	dapui.open()
          -- end
          -- dap.listeners.before.event_terminated["dapui_config"] = function()
          -- 	dapui.close()
          -- end
          -- dap.listeners.before.event_exited["dapui_config"] = function()
          -- 	dapui.close()
          -- end
          -- local debug_win = nil
          local debug_tab = nil
          local debug_tabnr = nil

          local function open_in_tab()
            if debug_win and vim.api.nvim_win_is_valid(debug_win) then
              vim.api.nvim_set_current_win(debug_win)
              return
            end

            vim.cmd("tabedit %")
            debug_win = vim.fn.win_getid()
            debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
            debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

            dapui.open({ reset = true })
          end

          local function close_tab()
            dapui.close()

            if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
              vim.api.nvim_exec("tabclose " .. debug_tabnr, false)
            end

            debug_win = nil
            debug_tab = nil
            debug_tabnr = nil
          end

          -- Attach DAP UI to DAP events
          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            open_in_tab()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            close_tab()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            close_tab()
          end
        end,
      },
    },
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        opts,
        mode = "n",
        desc = "Continue (Debug)",
      },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        opts,
        mode = "n",
        desc = "Step Over (Debug)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        opts,
        mode = "n",
        desc = "Step Into (Debug)",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        opts,
        mode = "n",
        desc = "Step Out (Debug)",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        opts,
        mode = "n",
        desc = "Open REPL (Debug)",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        opts,
        mode = "n",
        desc = "Run Last (Debug)",
      },
    },
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    lazy = true,
    event = "BufRead *",
    keys = {
      {
        "<leader>db",
        "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
        opts,
        mode = "n",
        desc = "Toggle Breakpoint",
      },
    },
    config = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufRead *Post" },
      })
    end,
  },
}
