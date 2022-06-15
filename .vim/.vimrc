"let mapleader = "§"
let mapleader = "`"

let g:dont_use_global_plug=1

call plug#begin('$VIM_CONFIG_PATH/plugged')
  " Navigation. config file: .navigation.vimrc
  Plug 'preservim/nerdtree'
  Plug 'chentoast/marks.nvim'

  " Search
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  "Plug 'kien/ctrlp.vim'
  Plug 'dyng/ctrlsf.vim'

  " Edit
  " h visual-multi
  " h vm-mappings
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'junegunn/vim-easy-align'
  Plug 'dhruvasagar/vim-table-mode'
 
  " Git. config file: .git.vimrc
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'lewis6991/gitsigns.nvim'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  
  " completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  " Snippets engine
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'windwp/nvim-autopairs'
  " LSP Installer
  Plug 'williamboman/nvim-lsp-installer'
  " Refactoring
  Plug 'ThePrimeagen/refactoring.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'smjonas/inc-rename.nvim'
  " Formatting
  Plug 'lukas-reineke/lsp-format.nvim'

  Plug 'b0o/schemastore.nvim'
  " Debugging. config file .debug.vimrc
  Plug 'puremourning/vimspector'

  " Tests. config file: .tests.vimrc
  Plug 'vim-test/vim-test'
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'nvim-neotest/neotest'
  Plug 'nvim-neotest/neotest-python'
  Plug 'nvim-neotest/neotest-plenary'
  Plug 'nvim-neotest/neotest-vim-test'

  " Themes. config file: .themes.vimrc
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'Mofiqul/vscode.nvim'
  "Plug 'jnurmine/Zenburn'

  " C++
  " for clangd semantic highlight (see :CocConfig)
  Plug 'jackguo380/vim-lsp-cxx-highlight'

  " Plantuml
  Plug 'tyru/open-browser.vim'
  Plug 'weirongxu/plantuml-previewer.vim'
  Plug 'aklt/plantuml-syntax'

  " Markdown 
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  " Status line
  Plug 'feline-nvim/feline.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'SmiteshP/nvim-gps'
  "Plug 'vim-airline/vim-airline'
  "Plug 'vim-airline/vim-airline-themes'
  
  " Help
  Plug 'folke/which-key.nvim'

  " NOrg
  Plug 'nvim-neorg/neorg'
  Plug 'nvim-neorg/neorg-telescope'
  Plug 'max397574/neorg-kanban'
  Plug 'max397574/neorg-contexts'
  Plug 'esquires/neorg-gtd-project-tags'

call plug#end()

" General Configuration

set encoding=utf-8 
set foldmethod=indent
set foldlevel=99
set relativenumber
set number
set wrap!
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.
set noerrorbells                " No beeps
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set autoindent
"set tabstop=4 shiftwidth=4 expandtab
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" General Key Mappings
nnoremap <space> za

source ${VIM_CONFIG_PATH}/.navigation.vimrc
source ${VIM_CONFIG_PATH}/.git.vimrc
source ${VIM_CONFIG_PATH}/.syntax.vimrc
source ${VIM_CONFIG_PATH}/.theme.vimrc
source ${VIM_CONFIG_PATH}/.debug.vimrc
source ${VIM_CONFIG_PATH}/.tests.vimrc
source ${VIM_CONFIG_PATH}/.search.vimrc
source ${VIM_CONFIG_PATH}/.edit.vimrc
source ${VIM_CONFIG_PATH}/.planning.vimrc
source ${VIM_CONFIG_PATH}/.statusline.vimrc
source ${VIM_CONFIG_PATH}/.help.vimrc

source ${VIM_CONFIG_PATH}/.lsp.vimrc

source ${VIM_CONFIG_PATH}/.cpp.vimrc
source ${VIM_CONFIG_PATH}/.python.vimrc
source ${VIM_CONFIG_PATH}/.markdown.vimrc

source ${VIM_CONFIG_PATH}/.neorg.vimrc

function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction

source .vimrc
