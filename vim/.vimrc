" -----------------------------------------------------------------------------
" Vim Plug
" -----------------------------------------------------------------------------
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"Plug 'tweekmonster/startuptime.vim'
Plug 'panosdim/vim-colorstatus'
Plug 'freeo/vim-kalisi'
Plug 'w0rp/ale'
Plug 'kshenoy/vim-signature'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'derekwyatt/vim-fswitch'
Plug 'Chiel92/vim-autoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'bagrat/vim-workspace'

" Initialize plugin system
call plug#end()

" -----------------------------------------------------------------------------
" Set colors
" -----------------------------------------------------------------------------
set t_Co=256
colorscheme kalisi
set background=dark

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
set nocompatible                " Disable vi compatibility
set hidden                      " You can change buffers without saving
set mouse=a                     " Use mouse everywhere
set backspace=indent,eol,start  " Make backspace a more flexible
set clipboard=unnamedplus       " Share windows clipboard
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
set termguicolors               " Use 24-bit colors
set wildmenu                    " See suggestion list
set laststatus=2                " Always show statusline
set hlsearch                    " Highlight searches
set incsearch                   " Show the `best match so far' astyped
set updatetime=100              " Faster updates
set cursorline                  " Highlight current line


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
" Colorstatus Plugin
" -----------------------------------------------------------------------------
let g:colorstatus#vimdevicons = 1
let g:colorstatus#nerdfont = 1

" -----------------------------------------------------------------------------
" FSwitch Plugin
" -----------------------------------------------------------------------------
nmap <silent> <Leader>h :FSHere<cr>

" -----------------------------------------------------------------------------
" GutenTag Plugin
" -----------------------------------------------------------------------------
let g:gutentags_ctags_tagfile = '.tags'

" -----------------------------------------------------------------------------
" vim-autoformat Plugin
" -----------------------------------------------------------------------------
noremap <Leader>f :Autoformat<CR>

" -----------------------------------------------------------------------------
" ALE Plugin
" -----------------------------------------------------------------------------
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" -----------------------------------------------------------------------------
" VIM Workspace Plugin
" -----------------------------------------------------------------------------
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"
noremap <Tab> :WSNext<CR>
noremap <S-Tab> :WSPrev<CR>
noremap <Leader><Tab> :WSClose<CR>
noremap <Leader><S-Tab> :WSClose!<CR>
noremap <C-t> :WSTabNew<CR>
cabbrev bonly WSBufOnly

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
map   <C-q> :bd <CR>
imap  <C-q> <ESC> :bd <CR>

" backspace in Visual mode deletes selection
vnoremap <BS> d

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
" Makefile use tab instead of spaces
autocmd FileType make setlocal noexpandtab


