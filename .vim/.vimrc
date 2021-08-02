"let mapleader = "§"
let mapleader = "`"

let g:dont_use_global_plug=1

call plug#begin('$VIM_CONFIG_PATH/plugged')
  " Navigation. config file: .navigation.vimrc
  Plug 'preservim/nerdtree'
  Plug 'szw/vim-maximizer'

  " Search
  Plug 'kien/ctrlp.vim'
  Plug 'dyng/ctrlsf.vim'

  " Edit
  " h visual-multi
  " h vm-mappings
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " Syntax. config file: .syntax.vimrc
  Plug 'vim-syntastic/syntastic'
  Plug 'nvie/vim-flake8'

  " Git. config file: .git.vimrc
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim'

  " Coc Langauge Server. config file: .coc.vimrc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets' " for coc-snippets extension

  " Debugging. config file .debug.vimrc
  Plug 'puremourning/vimspector'

  " Git. config file: .git.vimrc
  Plug 'tpope/vim-fugitive'

  " Tests. config file: .tests.vimrc
  Plug 'vim-test/vim-test'

  " Themes. config file: .themes.vimrc
  Plug 'jnurmine/Zenburn'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

call plug#end()

" General Configuration

set encoding=utf-8 
set foldmethod=indent
set foldlevel=99
set relativenumber
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
set tabstop=4 shiftwidth=4 expandtab
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" General Key Mappings
nnoremap <space> za

source ${VIM_CONFIG_PATH}/.navigation.vimrc
source ${VIM_CONFIG_PATH}/.coc.vimrc
source ${VIM_CONFIG_PATH}/.git.vimrc
source ${VIM_CONFIG_PATH}/.syntax.vimrc
source ${VIM_CONFIG_PATH}/.theme.vimrc
source ${VIM_CONFIG_PATH}/.debug.vimrc
source ${VIM_CONFIG_PATH}/.tests.vimrc
source ${VIM_CONFIG_PATH}/.search.vimrc
source ${VIM_CONFIG_PATH}/.edit.vimrc

source ${VIM_CONFIG_PATH}/.python.vimrc
