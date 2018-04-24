" -----------------------------------------------------------------------------
" Vim Plug
" -----------------------------------------------------------------------------
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"Plug 'tweekmonster/startuptime.vim'
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
set hidden                      " you can change buffers without saving
set mouse=a                     " use mouse everywhere
set backspace=indent,eol,start  " make backspace a more flexible
set clipboard=unnamedplus       " share windows clipboard
set colorcolumn=80              " Visible right margin indicator
set number                      " turn on line numbers
set smartcase                   " if there are caps, go case-sensitive
set smartindent                 " smart autoindenting when starting a new line
set shiftwidth=4                " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=4               " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=4                   " real tabs should be 8, and they will show with set list on
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set encoding=UTF-8              " enable Nerd Fonts icons
set noshowmode                  " Hide mode in command line
set expandtab                   " no real tabs please!
set ignorecase                  " case insensitive by default
set infercase                   " case inferred by default
set termguicolors               " use 24-bit colors
set wildmenu                    " See suggestion list
set laststatus=2                " Always show statusline

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
"let g:workspace_powerline_separators = 1
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
    let &ro = &ro
    if ale#engine#IsCheckingBuffer(bufnr(''))
        return " \uf110 "
    endif

    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    if l:counts.total == 0
        return " \uf00c "
    elseif l:all_non_errors == 0
        return " \uf05e " . l:all_errors
    elseif l:all_errors == 0
        return " \uf071 " . l:all_non_errors
    else
        return " \uf05e " . l:all_errors . ' ' . " \uf071 " . l:all_non_errors
    endif
endfunction

function! ModeStatus() abort
    let l:mode_map = {
                \ 'n' : 'NORMAL',
                \ 'i' : 'INSERT',
                \ 'R' : 'REPLACE',
                \ 'v' : 'VISUAL',
                \ 'V' : 'V-LINE',
                \ "\<C-v>": 'V-BLOCK',
                \ 'c' : 'COMMAND',
                \ 's' : 'SELECT',
                \ 'S' : 'S-LINE',
                \ "\<C-s>": 'S-BLOCK',
                \ 't': 'TERMINAL',
                \ }

    let l:color_map = {
                \ 'n' : 'hi Mode cterm=bold ctermfg=000 ctermbg=022 gui=bold guifg=#000000 guibg=#005f00',
                \ 'i' : 'hi Mode cterm=bold ctermfg=000 ctermbg=009 gui=bold guifg=#000000 guibg=#ff0000',
                \ 'R' : 'hi Mode cterm=bold ctermfg=000 ctermbg=166 gui=bold guifg=#000000 guibg=#d75f00',
                \ 'v' : 'hi Mode cterm=bold ctermfg=000 ctermbg=027 gui=bold guifg=#000000 guibg=#005fff',
                \ 'V' : 'hi Mode cterm=bold ctermfg=000 ctermbg=033 gui=bold guifg=#000000 guibg=#0087ff',
                \ "\<C-v>": 'hi Mode cterm=bold ctermfg=000 ctermbg=057 gui=bold guifg=#000000 guibg=#5f00ff',
                \ 'c' : 'hi Mode cterm=bold ctermfg=000 ctermbg=011 gui=bold guifg=#000000 guibg=#ffff00',
                \ 's' : 'hi Mode cterm=bold ctermfg=000 ctermbg=020 gui=bold guifg=#000000 guibg=#0000d7',
                \ 'S' : 'hi Mode cterm=bold ctermfg=000 ctermbg=033 gui=bold guifg=#000000 guibg=#0087ff',
                \ "\<C-s>": 'hi Mode cterm=bold ctermfg=000 ctermbg=057 gui=bold guifg=#000000 guibg=#5f00ff',
                \ 't': 'TERMINAL',
                \ }

    exec l:color_map[mode()]

    return l:mode_map[mode()]
endfunction

function! Fugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? " \ue0a0 " . branch . ' ' : ''
    endif
    return ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? '  ' . &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : ' no ft ') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (' ' . &fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! Readonly()
    return &readonly ? " \uf023 " : ''
endfunction

function! Modified()
    return &modified ? "  \uf067 " : ''
endfunction

function! Lineinfo()
    return "\ue0a1"
endfunction

hi FilePath     ctermfg=015 ctermbg=088 guifg=#ffffff guibg=#870000
hi GitStatus    ctermfg=015 ctermbg=018 guifg=#ffffff guibg=#000087
hi FileType     ctermfg=015 ctermbg=232 guifg=#ffffff guibg=#080808
hi Encoding     ctermfg=000 ctermbg=228 guifg=#000000 guibg=#ffff87
hi FileFormat   ctermfg=000 ctermbg=119 guifg=#000000 guibg=#87ff5f
hi Row          ctermfg=015 ctermbg=033 guifg=#ffffff guibg=#0087ff
hi ReadOnly     ctermfg=015 ctermbg=089 guifg=#ffffff guibg=#87005f
hi Status       ctermfg=015 ctermbg=021 guifg=#ffffff guibg=#0000ff
hi Linter       ctermfg=000 ctermbg=036 guifg=#000000 guibg=#00af87
hi GutenTags    ctermfg=000 ctermbg=047 guifg=#000000 guibg=#00ff5f
hi Modified     ctermfg=000 ctermbg=208 guifg=#000000 guibg=#ff8700

set statusline=
set statusline+=%#Mode#\ %{ModeStatus()}\                         "Mode
set statusline+=%#FilePath#\ %<%F\                                "File+path
set statusline+=%#GitStatus#%{Fugitive()}                         "Git Branch
set statusline+=%#Modified#%{Modified()}                          "Modified
set statusline+=%#ReadOnly#%{Readonly()}                          "Read Only
set statusline+=%#FileType#%=%{MyFiletype()}                      "FileType
set statusline+=%#Encoding#\ %{''.(&fenc!=''?&fenc:&enc).''}\     "Encoding
set statusline+=%#FileFormat#%{MyFileformat()}                    "FileFormat (dos/unix..)
set statusline+=%#Status#\ %p%%\                                  "Percentage of file
set statusline+=%#Row#\ %{Lineinfo()}%3l:%-2v\                    "Row/Column
set statusline+=%#Linter#\ %{LinterStatus()}\                     "Linter Status
set statusline+=%#GutenTags#%{gutentags#statusline()}             "GutenTag Status

augroup YourGroup
    autocmd!
    autocmd User ALELintPre  call LinterStatus()
    autocmd User ALELintPost call LinterStatus()

    autocmd User ALEFixPre   call LinterStatus()
    autocmd User ALEFixPost  call LinterStatus()
augroup END

