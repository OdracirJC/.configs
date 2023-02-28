"Disable compatibility with vi
set nocompatible
"Attempt file type detection
filetype on
filetype plugin on
filetype indent on

syntax on
set number
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set hlsearch

set wildmenu
set wildmode=list:longest

" PLUGINS ------------------ {{{
call plug#begin('~/.vim/plugged')

    Plug 'scrooloose/syntastic' " Synatx Checking
    Plug 'dense-analysis/ale'   " SOme shit
    Plug 'vim-airline/vim-airline' " Status Bar
    Plug 'preservim/nerdtree' " nerd tree
    Plug 'valloric/youcompleteme' " code-completion engine for Vim
    Plug 'nathanaelkane/vim-indent-guides' " Indentation Guides
    Plug 'pangloss/vim-javascript' " Javascript bundle for syntax highlighting
    Plug 'digitaltoad/vim-jade' " Plugin for Jade
    Plug 'tpope/vim-surround' "brackets
    Plug 'tpope/vim-fugitive' "Plugin for Git






call plug#end()
" }}}

"MAPPINGS ------------------ {{{
"WINDOW ----{{

nnoremap <space>wj <c-w>j
nnoremap <space>wk <c-w>k
nnoremap <space>wl <c-w>l
nnoremap <space>wh <c-w>h
nnoremap <space>wd <c-w>c
nnoremap <space>ws <c-w>s
nnoremap <space>wv <c-w>v

"}}
"BUFFER ---{{

nnoremap <space>bn :bn<CR>
nnoremap <space>bl :bl<CR>
nnoremap <space>bd :bd<CR>


"}}
nnoremap <F3> :NERDTreeToggle<cr>
"}}}

"VIMSCRIPT ----------------- {{{
"Allow folding
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
	
"}}}

"STATUS LINE --------------  {{{
"
"Status Bar Code
" Clear status line when vimrc is reloaded.

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
"}}}
