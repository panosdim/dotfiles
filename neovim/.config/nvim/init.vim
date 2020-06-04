" -----------------------------------------------------------------------------
" Vim Plug
" -----------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'kshenoy/vim-signature'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'ajmwagar/vim-deus'
Plug 'mengelbrecht/lightline-bufferline'

" Initialize plugin system
call plug#end()

" -----------------------------------------------------------------------------
" Set colors
" -----------------------------------------------------------------------------
set t_Co=256
colorscheme deus
set background=dark

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
set hidden                      " you can change buffers without saving
set mouse=a                     " use mouse everywhere
set backspace=indent,eol,start  " make backspace a more flexible
set clipboard+=unnamedplus      " share windows clipboard
set colorcolumn=80              " Visible right margin indicator
set number                      " turn on line numbers
set smartcase                   " if there are caps, go case-sensitive
set smartindent                 " smart autoindenting when starting a new line
set shiftwidth=4                " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=4               " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=4                   " real tabs should be 8, and they will show with set list on
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set updatetime=100              " Update time
set noshowmode                  " Do not show mode
set showtabline=2               " Always show tabline

" -----------------------------------------------------------------------------
" Folding settings
" -----------------------------------------------------------------------------
set nofoldenable                " Don't enable by default use zi
set foldmethod=indent           " Fold on the indent (damn you python)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
hi Folded ctermfg=015 ctermbg=013 guibg=#ff00ff guifg=#ffffff

" -----------------------------------------------------------------------------
" Omni Completion Settings
" -----------------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" -----------------------------------------------------------------------------
" Lightline Plugin
" -----------------------------------------------------------------------------
let g:lightline = {
			\ 'colorscheme': 'deus',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'gitbranch#name'
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
" CtrlP Plugin
" -----------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" -----------------------------------------------------------------------------
" Mappings
" -----------------------------------------------------------------------------
" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Go to end/beginning of line
inoremap [8~ <C-o>$
inoremap [7~ <C-o>0

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

" Use CTRL-S for saving, also in Insert mode
noremap   <C-S> :update<CR>
vnoremap  <C-S> <C-C>:update<CR>
inoremap  <C-S> <C-O>:update<CR>

" Use CTRL-X to close a buffer
map   <C-x> :bd <CR>
imap  <C-x> <ESC> :bd <CR>

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Save file as root
command! -nargs=0 Sw w !sudo tee % > /dev/null

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
" Makefile use tab instead of spaces
autocmd FileType make setlocal noexpandtab
