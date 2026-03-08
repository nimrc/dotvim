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
set listchars=tab:>\ ,trail:-
set autochdir

set autoindent                "自动缩排
set ruler                     "可显示最后一行的状态
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartindent

" GUI Options cleanup
set guioptions-=e
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T
set mouse-=a

set nocompatible
set guifont=Monaco:h12

" jump to search and set to middle
noremap = nzz
noremap - Nzz

" Remove startup highlight
exec "nohlsearch"

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

filetype plugin indent on

call plug#begin('~/.vim/plugged')

" Core & UI
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors' " 多行选取
Plug 'w0rp/ale' " 实时动态检查

" Languages
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'shawncplus/phpcomplete.vim'

" Completion (Legacy)
Plug 'shougo/neocomplete.vim'

" Themes
Plug 'connorholyday/vim-snazzy'
Plug 'gosukiwi/vim-atom-dark'
Plug 'tomasiser/vim-code-dark'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()


" --- Mappings ---
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

" === Goyo ===
map <Leader>z :Goyo<CR>
let g:goyo_width = 120
let g:goyo_linenr = 0

" === Golang ===
let g:go_doc_popup_window = 1
autocmd FileType go noremap <buffer> <silent> <leader>ga :GoAlternate<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gi :GoInfo<cr>
autocmd FileType go noremap <buffer> <silent> <leader>bt :GoDecls<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gt :GoDeclsDir<cr>
autocmd FileType go noremap <buffer> <silent> <leader>gb :GoBuild<cr>
autocmd FileType go noremap <buffer> <silent> <leader>r :GoRun<cr>
autocmd FileType go noremap <buffer> <silent> <leader>d :GoDef<cr>

" === JavaScript ===
let g:javascript_plugin_jsdoc = 1
let g:jsx_pragma_required = 0

" === Status Line ===
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

" === Search (Ack/FZF) ===
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>
nmap <C-p> :FZF<CR>

" Sudo write
map <C-a> :w !sudo tee %<CR>

" === NERDTree ===
map <Leader>t :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

color codedark

" === NeoComplete ===
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Mappings
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Omni Completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" PHP Complete
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_add_class_extensions = ['spl']
let g:phpcomplete_mappings = {
   \ 'jump_to_def': '<C-]>',
   \ 'jump_to_def_split': '<C-W><C-]>',
   \ 'jump_to_def_vsplit': '<C-W><C-\>',
   \}

" Java
autocmd BufNewFile,BufReadPre *.java nmap <leader>rn :!javac %<cr>:!java %:r<cr>

" === ALE ===
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
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
