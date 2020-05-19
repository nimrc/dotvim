set number
set cursorline
set showcmd
set showmode
set wildmenu
set wrap
" search
set hlsearch
set incsearch
set ignorecase
set smartcase

set list
set listchars=tab:▸\ ,trail:▫
set autochdir

set autoindent                "自动缩排
set ruler                     "可显示最后一行的状态
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smartindent
set guioptions-=e
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set nocompatible               " 设置 vim 为不兼容 vi 模式
set guifont=Monaco:h12

" jump to search and set to middle
noremap = nzz
noremap - Nzz

exec "nohlsearch"

" notes "
" <operation> <motion> d 3 l / y 3 l

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
set mouse-=a
set nowritebackup
set nobackup
set noswapfile
set noeb

let mapleader=","
vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader><space> :nohlsearch<cr>

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set fileformat=unix

filetype plugin on

let g:neocomplcache_enable_at_startup = 1

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on


call plug#begin('~/.vim/plugged')

" Auto Complete
Plug 'Valloric/YouCompleteMe'

Plug 'vim-scripts/taglist.vim'

Plug 'junegunn/goyo.vim'

Plug 'kshenoy/vim-signature'

Plug 'connorholyday/vim-snazzy'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'gosukiwi/vim-atom-dark' " 主题
Plug 'terryma/vim-multiple-cursors' " 多行选取
Plug 'shougo/neocomplete.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'w0rp/ale' " 实时动态检查

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()


" ---
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC <CR>

map tu :tabe<CR>
map tn :-tabnext<CR>
map ti :+tabnext<CR>

map si :set splitright<CR>:vsplit<CR>
map sn :set nosplitright<CR>:vsplit<CR>
map su :set nosplitbelow<CR>:split<CR>
map se :set splitbelow<CR>:split<CR>

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

syntax on

" ===
" === Goyo
" ===
map <Leader>z :Goyo<CR>
let g:goyo_width = 120
let g:goyo_linenr = 0

"" golang
" Note: Turn on auto typeinfo and K mapping if floating window is not supported
" FIXME: remove this block after neovim stable version 4.0 comes
" if !exists('*nvim_open_win')
  " let g:go_auto_type_info = 1         " auto show the type info of cusor
  " let g:go_doc_keywordprg_enabled = 1 " map K to :GoDoc, use coc-action-doHover instead
" else
  " let g:go_auto_type_info = 0         " auto show the type info of cusor
  " let g:go_doc_keywordprg_enabled = 0 " map K to :GoDoc, use coc-action-doHover instead
" endif
"
"
let g:go_doc_popup_window = 1

autocmd FileType go noremap <buffer> <silent> <leader>ga :GoAlternate<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gi :GoInfo<cr>
autocmd FileType go noremap <buffer> <silent> <leader>bt :GoDecls<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gt :GoDeclsDir<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gb :GoBuild<cr>
autocmd FileType go noremap <buffer> <silent> <leader>r :GoRun<cr>
autocmd FileType go noremap <buffer> <silent> <leader>d :GoDef<cr>


" --------------vim-javascript---------------
let g:javascript_plugin_jsdoc = 1
let g:jsx_pragma_required = 0

" -------------airline settings---------------
set laststatus=2
let g:airline_powerline_fonts=1
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '|', 'right': '|' },
      \ 'subseparator': { 'left': '<', 'right': '>' }
      \ }
let g:airline_symbols = {}

" -------------fzf and ag-settings---------------------
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" search lines in files
cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>
nmap <C-p> :FZF<CR>

map <C-a> :w !sudo tee %<CR>

" -------------config for nerdtree ----------------------
map <Leader>t :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

color atom-dark-256

""""""""""

" ===
" === You Complete ME
" ===
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_use_clangd = 0
let g:ycm_python_interpreter_path = "/usr/local/bin/python3"
let g:ycm_python_binary_path = "/usr/local/bin/python3"


" Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
"
" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_add_class_extensions = ['spl']

let g:phpcomplete_mappings = {
   \ 'jump_to_def': '<C-]>',
   \ 'jump_to_def_split': '<C-W><C-]>',
   \ 'jump_to_def_vsplit': '<C-W><C-\>',
   \}

autocmd BufNewFile,BufReadPre *.java nmap <leader>rn :!javac %<cr>:!java %:r<cr>

""" ale {
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

""" }
