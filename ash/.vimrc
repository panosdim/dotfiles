" -----------------------------------------------------------------------------
" Vim Plug
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sheerun/vim-wombat-scheme'

" Initialize plugin system
call plug#end()

" -----------------------------------------------------------------------------
" Set colors
" -----------------------------------------------------------------------------
set t_Co=256
colorscheme wombat
set background=dark

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
set nocompatible                " Disable vi compatibility
set hidden                      " You can change buffers without saving
set mouse=a                     " Use mouse everywhere
set backspace=indent,eol,start  " Make backspace a more flexible
set clipboard+=unnamedplus      " Share windows clipboard
set colorcolumn=80              " Visible right margin indicator
set number                      " Turn on line numbers
set smartcase                   " If there are caps, go case-sensitive
set smartindent                 " Smart autoindenting when starting a new line
set shiftwidth=4                " Auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=4               " When hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=4                   " Real tabs should be 4, and they will show with set list on
set autoread                    " Read open files again when changed outside Vim
set autowrite                   " Write a modified buffer on each :next , ...
set encoding=UTF-8              " Enable Nerd Fonts icons
set noshowmode                  " Hide mode in command line
set expandtab                   " No real tabs please!
set ignorecase                  " Case insensitive by default
set infercase                   " Case inferred by default
set wildmenu                    " See suggestion list
set laststatus=2                " Always show statusline
set hlsearch                    " Highlight searches
set incsearch                   " Show the `best match so far' astyped
set updatetime=100              " Faster updates
set cursorline                  " Highlight current line
set showtabline=2               " Always show tab line

" -----------------------------------------------------------------------------
" Lightline Plugin
" -----------------------------------------------------------------------------
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'tabline': {
            \   'left': [ ['buffers'] ],
            \   'right': [ ['close'] ]
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ }
            \ }
let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 1
            \ }

" -----------------------------------------------------------------------------
" Lightline Bufferline Plugin
" -----------------------------------------------------------------------------
let g:lightline#bufferline#show_number=2

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>

" -----------------------------------------------------------------------------
" Mappings
" -----------------------------------------------------------------------------

" Indent whole file
nnoremap <Leader>i mzgg=G`zmz

" Change : with ;
nnoremap ; :

" CTRL-A is Select all
inoremap   <C-A> <ESC>ggVG
noremap   <C-A> ggVG

" CTRL-Z is Undo; not in cmdline though
noremap   <C-Z> u
inoremap  <C-Z> <C-O>u

" backspace in Visual mode deletes selection
vnoremap <BS> d

