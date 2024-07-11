vim.g.mapleader = "`"

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	splitkeep = "screen",
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 3, -- so that `` is visible in markdown files
	-- fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = false, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldlevel = 99,

	signcolumn = "yes:2", -- always show the sign column, otherwise it would shift the text each time
	wrap = vim.api.nvim_win_get_option(0, "diff") or false, -- display lines as one long line
	linebreak = true, -- companion to wrap, don't split words
	scrolloff = 15, -- minimal number of screen lines to keep above and below the cursor
	sidescrolloff = 15, -- minimal number of screen columns either side of cursor if wrap is `false`
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
	-- spelllang = "en_us",
	-- spell = false,
	-- spelloptions = "camel",
	diffopt = "filler,context:5,linematch:500,followwrap,indent-heuristic,algorithm:patience",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess = "Iilmnrx" -- flags to shorten vim messages, see :help 'shortmess'
--vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
--vim.opt.shortmess:append("I") -- don't open new buffer on startup
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.fillchars:append("eob: ")

vim.cmd([[ packadd cfilter ]])
vim.cmd([[ nmap cp :let @+ = "{/ " .. expand("%:p")..":"..line(".") .. "}"<cr> ]])
vim.cmd([[
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
]])

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

vim.cmd([[
function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction

nnoremap <silent> ,C :call CleanNoNameEmptyBuffers()<CR>
]])

vim.cmd([[
nnoremap <silent> <leader>rr :bufdo e<CR>
"nnoremap <silent> <leader>bc :%bdelete|edit #|normal<CR>
]])

if vim.g.non_modified then
	vim.cmd([[
      set noshowmode
      set noruler
      set laststatus=0
      set noshowcmd
      set cmdheight=0
]])
	vim.opt.shortmess = "cFWI"
	vim.opt.signcolumn = "no"
else
	vim.cmd([[
    " autocmd FileType markdown setlocal spell spelllang=en spelloptions=camel
    " autocmd FileType norg setlocal spell spelllang=en spelloptions=camel

    augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END
  ]])
end

-- vim.g.root_spec = { "lsp", { ".git", "lua", "pyproject.toml", "Makefile", "src" }, "cwd" }
vim.g.root_spec = { "cwd" }
