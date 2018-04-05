" -----------------------------------------------------------------------------
" Vim Plug
" -----------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'freeo/vim-kalisi'
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

" -----------------------------------------------------------------------------
" BufTabLine Plugin
" -----------------------------------------------------------------------------
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
" Fast switching between buffers
nnoremap <Leader>n  :bnext<CR>
nnoremap <Leader>p  :bprevious<CR>

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
let g:workspace_use_devicons = 1
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
map   <C-x> :bd <CR>
imap  <C-x> <ESC> :bd <CR>

" backspace in Visual mode deletes selection
vnoremap <BS> d

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
" Makefile use tab instead of spaces
autocmd FileType make setlocal noexpandtab

" -----------------------------------------------------------------------------
" Set statusline
" -----------------------------------------------------------------------------
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

hi FilePath     ctermfg=015 ctermbg=088
hi GitStatus    ctermfg=015 ctermbg=018
hi FileType     ctermfg=000 ctermbg=208
hi Encoding     ctermfg=000 ctermbg=228
hi FileFormat   ctermfg=000 ctermbg=119
hi Row          ctermfg=015 ctermbg=033
hi Column       ctermfg=015 ctermbg=089
hi Status       ctermfg=015 ctermbg=021
hi Linter       ctermfg=000 ctermbg=036
hi GutenTags	ctermfg=000 ctermbg=047

set statusline=
set statusline+=%#FilePath#\ %<%F\                                "File+path
set statusline+=%#GitStatus#%{fugitive#statusline()}              "Git Branch
set statusline+=%#FileType#\ %y\                                  "FileType
set statusline+=%#Encoding#\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%#Encoding#\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%#FileFormat#\ %{&ff}\                            "FileFormat (dos/unix..) 
set statusline+=%#Row#\ %=\ row:%l/%L\                            "Rownumber/total
set statusline+=%#Column#\ col:%03c\                              "Colnr
set statusline+=%#Status#\ \ %m%r%w\ %P\ \                        "Modified? Readonly? Top/bot.
set statusline+=%#Linter#\ %{LinterStatus()}\                     "Linter Status
set statusline+=%#GutenTags#%{gutentags#statusline()}    		  "GutenTag Status
