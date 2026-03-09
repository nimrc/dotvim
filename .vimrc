set nocompatible

" ====================
" Basic
" ====================
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,latin1
set fileformat=unix
scriptencoding utf-8

syntax on
filetype plugin indent on

let mapleader="," 
let maplocalleader="," 

set number
set relativenumber
set cursorline
set showcmd
set showmode
set ruler
set wildmenu
set wildmode=longest:full,full
set hidden
set history=1000
set autoread
set confirm
set visualbell
set t_vb=
set mouse=a
set ttyfast
set lazyredraw
set updatetime=300
set timeoutlen=500

" ====================
" UI / Editing
" ====================
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set shiftround

set nowrap
set linebreak
set textwidth=0
set colorcolumn=100
set scrolloff=5
set sidescrolloff=8
set signcolumn=yes

set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set splitbelow
set splitright

set hlsearch
set incsearch
set ignorecase
set smartcase

set backspace=indent,eol,start
set clipboard=unnamed
set completeopt=menuone,noinsert,noselect

set nobackup
set nowritebackup
set noswapfile
set undofile
if has('persistent_undo')
  let s:undo_dir = expand('~/.vim/undodir')
  if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p')
  endif
  let &undodir = s:undo_dir
endif

" ====================
" GUI only
" ====================
if has('gui_running')
  set guifont=Monaco:h12
  set guioptions-=e
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=m
  set guioptions-=T
endif

" ====================
" Plugins
" ====================
call plug#begin('~/.vim/plugged')

" UI / Navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'

" Editing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'

" Lint / format
Plug 'dense-analysis/ale'

" Completion / LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Theme
Plug 'tomasiser/vim-code-dark'

call plug#end()

" ====================
" General mappings
" ====================
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><space> :nohlsearch<CR>

nnoremap = nzz
nnoremap - Nzz

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>sh :split<CR>
nnoremap <leader>svv :vsplit<CR>

nnoremap <Up> :resize +3<CR>
nnoremap <Down> :resize -3<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tl :tabnext<CR>

vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <C-s> :w<CR>
noremap <C-a> :w !sudo tee % >/dev/null<CR>

" ====================
" NERDTree
" ====================
nnoremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', 'node_modules$', '\.DS_Store$']
let g:NERDTreeWinSize = 35

augroup nerdtree_startup
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

" ====================
" FZF
" ====================
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader>fh :History<CR>

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
elseif executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
endif

" ====================
" Lightline
" ====================
set laststatus=2
function! LightlineGitBranch() abort
  return exists('*FugitiveHead') ? FugitiveHead() : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitBranch'
      \ },
      \ }

" ====================
" Goyo
" ====================
nnoremap <leader>z :Goyo<CR>
let g:goyo_width = 120

" ====================
" ALE
" ====================
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_echo_delay = 20
let g:ale_lint_delay = 300
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'go': ['gofmt'],
\   'python': ['black'],
\   'sh': ['shfmt']
\}

nnoremap <leader>an :ALENext<CR>
nnoremap <leader>ap :ALEPrevious<CR>
nnoremap <leader>af :ALEFix<CR>

" ====================
" CoC
" ====================
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
nnoremap <silent> <leader>ca  <Plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>cf  <Plug>(coc-format)
nnoremap <silent> <leader>cd  :CocDiagnostics<CR>
nnoremap <silent> <leader>e   :CocCommand explorer<CR>

" ====================
" Go
" ====================
let g:go_doc_popup_window = 1
let g:go_fmt_command = 'goimports'
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

augroup go_config
  autocmd!
  autocmd FileType go nnoremap <buffer> <silent> <leader>ga :GoAlternate<CR>
  autocmd FileType go nnoremap <buffer> <silent> <leader>gb :GoBuild<CR>
  autocmd FileType go nnoremap <buffer> <silent> <leader>gr :GoRun<CR>
  autocmd FileType go nnoremap <buffer> <silent> <leader>gt :GoTest<CR>
  autocmd FileType go nnoremap <buffer> <silent> <leader>gi :GoInfo<CR>
augroup END

" ====================
" Filetype tweaks
" ====================
augroup my_filetypes
  autocmd!
  autocmd FileType markdown,text setlocal wrap linebreak nolist
  autocmd FileType json,yaml setlocal ts=2 sts=2 sw=2
  autocmd FileType javascript,typescript,typescriptreact,json setlocal ts=2 sts=2 sw=2
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

colorscheme codedark
