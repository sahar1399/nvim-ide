return {
  {
    "gabrielpoca/replacer.nvim",
    lazy = false,
    ft = "qf",
    opts = { rename_files = true, save_on_write = true },
    keys = {
      {
        "<leader>h",
        function()
          require("replacer").run()
        end,
        desc = "run replacer.nvim",
        mode = "n",
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },
    config = function()
      vim.cmd([[
          if exists('b:current_syntax')
              finish
          endif

          syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
          syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
          syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
          syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
          syn match qfError / E .*$/ contained
          syn match qfWarning / W .*$/ contained
          syn match qfInfo / I .*$/ contained
          syn match qfNote / [NH] .*$/ contained

          hi def link qfFileName Directory
          hi def link qfSeparatorLeft Delimiter
          hi def link qfSeparatorRight Delimiter
          hi def link qfLineNr LineNr
          hi def link qfError DiagnosticError
          hi def link qfWarning DiagnosticWarn
          hi def link qfInfo DiagnosticInfo
          hi def link qfNote DiagnosticHint

          let b:current_syntax = 'qf'
      ]])

      -- local fn = vim.fn
      --
      -- function _G.qftf(info)
      -- 	local items
      -- 	local ret = {}
      -- 	-- The name of item in list is based on the directory of quickfix window.
      -- 	-- Change the directory for quickfix window make the name of item shorter.
      -- 	-- It's a good opportunity to change current directory in quickfixtextfunc :)
      -- 	--
      -- 	-- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
      -- 	-- local root = getRootByAlterBufnr(alterBufnr)
      -- 	-- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
      -- 	--
      -- 	if info.quickfix == 1 then
      -- 		items = fn.getqflist({ id = info.id, items = 0 }).items
      -- 	else
      -- 		items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
      -- 	end
      -- 	local limit = 31
      -- 	local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
      -- 	local validFmt = "%s │%5d:%-3d│%s %s"
      -- 	for i = info.start_idx, info.end_idx do
      -- 		local e = items[i]
      -- 		local fname = ""
      -- 		local str
      -- 		if e.valid == 1 then
      -- 			if e.bufnr > 0 then
      -- 				fname = fn.bufname(e.bufnr)
      -- 				if fname == "" then
      -- 					fname = "[No Name]"
      -- 				else
      -- 					fname = fname:gsub("^" .. vim.env.HOME, "~")
      -- 				end
      -- 				-- char in fname may occur more than 1 width, ignore this issue in order to keep performance
      -- 				if #fname <= limit then
      -- 					fname = fnameFmt1:format(fname)
      -- 				else
      -- 					fname = fnameFmt2:format(fname:sub(1 - limit))
      -- 				end
      -- 			end
      -- 			local lnum = e.lnum > 99999 and -1 or e.lnum
      -- 			local col = e.col > 999 and -1 or e.col
      -- 			local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      -- 			str = validFmt:format(fname, lnum, col, qtype, e.text)
      -- 		else
      -- 			str = e.text
      -- 		end
      -- 		table.insert(ret, str)
      -- 	end
      -- 	return ret
      -- end
      --
      -- vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

      vim.cmd([[
          hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
          hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
          hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
          hi link BqfPreviewRange Search
      ]])
      -- Adapt fzf's delimiter in nvim-bqf
      require("bqf").setup({
        auto_enable = true,
        magic_window = true,
        auto_resize_height = true,
        previous_winid_ft_skip = {},
        preview = {
          auto_preview = true,
          border = "rounded",
          show_title = true,
          show_scroll_bar = true,
          delay_syntax = 50,
          winblend = 12,
          win_height = 15,
          win_vheight = 15,
          wrap = false,
          buf_label = true,
          should_preview_cb = nil,
        },
        func_map = {
          open = "<CR>",
          openc = "o",
          drop = "O",
          split = "<C-x>",
          vsplit = "<C-v>",
          tab = "t",
          tabb = "T",
          tabc = "<C-t>",
          tabdrop = "",
          ptogglemode = "zp",
          ptoggleitem = "p",
          ptoggleauto = "P",
          pscrollup = "<C-b>",
          pscrolldown = "<C-f>",
          pscrollorig = "zo",
          prevfile = "<C-p>",
          nextfile = "<C-n>",
          prevhist = "<",
          nexthist = ">",
          lastleave = [['"]],
          stoggleup = "<S-Tab>",
          stoggledown = "<Tab>",
          stogglevm = "<Tab>",
          stogglebuf = [['<Tab>]],
          sclear = "z<Tab>",
          filter = "zn",
          filterr = "zN",
          fzffilter = "zf",
        },
        filter = {
          action_for = {
            ["ctrl-t"] = "tabedit",
            ["ctrl-v"] = "vsplit",
            ["ctrl-x"] = "split",
            ["ctrl-q"] = "signtoggle",
            ["ctrl-c"] = "closeall",
          },
          fzf = {
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
          },
        },
      })

      -- vim.cmd([[let &errorformat ..= ',%f|%l col %c| %m']])
      -- require("bqf").setup()
    end,
  },
}
