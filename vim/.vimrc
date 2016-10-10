" Set shell
    set shell=/bin/bash

" Initialize pathogen
    execute pathogen#infect()
    execute pathogen#helptags()

" Basics
    let mapleader = ","         " Change leader
    set nocompatible            " explicitly get out of vi-compatible mode
    set noexrc                  " don't use local version of .(g)vimrc, .exrc
    set background=dark         " we plan to use a dark background
    set fenc=utf-8              " UTF-8
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor between joined lines
    "             |||||||+-- When a new match is created (showmatch) pause for .5
    "             ||||||+-- Set buffer options when entering the buffer
    "             |||||+-- :write command updates current file name automatically add <CR> to the last line when using :@r
    "             |||+-- Searching continues at the end of the match at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on                   " syntax highlighting on

" Newish
    set history=9999            " big old history
    set timeoutlen=300          " super low delay (works for me)
    set formatoptions+=n        " Recognize numbered lists
    set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s*
    set viminfo+=!              " Store upper-case registers in viminfo
    set nomore                  " Short nomore

" General
    source $VIMRUNTIME/mswin.vim
    filetype plugin indent on       " load filetype plugins/indent settings
    set backspace=indent,eol,start  " make backspace a more flexible
    set clipboard+=unnamed          " share windows clipboard
    set fileformats=unix,dos,mac    " support all three, in this order
    set hidden                      " you can change buffers without saving
    set mouse=a                     " use mouse everywhere
    set noerrorbells                " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu                    " turn on command line completion wild style
    set wildignore=*.bak,*.o,*.e,*~ " ignore these list file extensions
    set wildmode=list:longest       " turn on wild mode huge list

" Vim UI
    set incsearch                   " BUT do highlight as you type you search phrase
    set autoread                    " read open files again when changed outside Vim
    set autowrite                   " write a modified buffer on each :next , ...
    set laststatus=2                " always show the status line
    set lazyredraw                  " do not redraw while running macros
    set linespace=0                 " don't insert any extra pixel lines betweens rows
    set list                        " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:>-,trail:-    " show tabs and trailing
    set matchtime=5                 " how many tenths of a second to blink matching brackets for
    set hlsearch                    " do not highlight searched for phrases
    set nostartofline               " leave my cursor where it was
    set novisualbell                " don't blink
    set number                      " turn on line numbers
    set numberwidth=5               " We are good up to 99999 lines
    set ruler                       " Always show current positions along the bottom
    set scrolloff=10                " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT             " shortens messages to avoid 'press a key' prompt
    set showcmd                     " show the command being typed
    set showmatch                   " show matching brackets
    set sidescrolloff=10            " Keep 5 lines at the size
    set noshowmode                  " Hide mode in command line
    set colorcolumn=80              " Visible right margin indicator

" Text Formatting/Layout
    set completeopt=menuone         " don't use a pop up menu for completions
    set expandtab                   " no real tabs please!
    set formatoptions=rq            " Automatically insert comment leader on return, and let gq format comments
    set ignorecase                  " case insensitive by default
    set infercase                   " case inferred by default
    set nowrap                      " do not wrap line
    set shiftround                  " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase                   " if there are caps, go case-sensitive
    set smartindent                 " smart autoindenting when starting a new line
    set shiftwidth=2                " auto-indent amount when using cindent, >>, << and stuff like that
    set softtabstop=2               " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=2                   " real tabs should be 8, and they will show with set list on

" Folding
    set foldenable                  " Turn on folding
    set foldmethod=indent           " Fold on the indent (damn you python)
    set foldlevel=100               " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText()   " Custom fold text function (cleaner than default)

" Plugin Settings
    "Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_enable_perl_checker = 1

    "Lightline
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

    function! LightLineModified()
      if &filetype == "help"
        return ""
      elseif &modified
        return "+"
      elseif &modifiable
        return ""
      else
        return "-"
      endif
    endfunction

    function! LightLineReadonly()
      if &filetype == "help"
        return ""
      elseif &readonly
        return "x"
      else
        return ""
      endif
    endfunction

    function! LightLineFugitive()
      return exists('*fugitive#head') ? fugitive#head() : ''
    endfunction

    " Tagbar
    nmap <F8> :TagbarToggle<CR>

    " neocomplete
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Mappings
    " Allow us to use Ctrl-s and Ctrl-q as keybinds
    silent !stty -ixon

    " Fix mswin mode
    "vnoremap <Tab> >gv
    "vnoremap <S-Tab> <gv

    " Close current buffer
    map <C-w> :bd <CR>

    " Fast switching between buffers
    nnoremap <Tab> :bnext<CR>
    nnoremap <S-Tab> :bprevious<CR>
    inoremap <C-Tab> <C-o>:bnext<CR>
    inoremap <C-S-Tab> <C-o>:bprevious<CR>

    " Go to end/beginning of line
    inoremap [8~ <C-o>$
    inoremap [7~ <C-o>0

    "Indent whole file
    map <F7> mzgg=G`z

    " Make
    map <F5> :make!<CR>
    imap <F5> <ESC>:make!<CR>

    " Open header/source file
    nnoremap <Leader>c :e %<.c<CR>
    nnoremap <Leader>C :e %<.cpp<CR>
    nnoremap <Leader>h :e %<.h<CR>

    " Change : with ;
    nnoremap ; :

    " Select text between {}, [] and ()
    :map <S-t> vat
    :map <S-T> vit
    :map <S-{> vi{
    :map <S-(> vi(
    :map <S-[> vi[

    " Comment/Uncomment block selection
    noremap + :s/^/#/<CR> :nohl<CR>
    noremap - :s/^#//<CR> :nohl<CR>

" Autocommands
    if has("autocmd")
      autocmd BufNewFile,BufRead,BufEnter * silent! lchdir %:p:h
      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
      au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
    endif " has("autocmd")

" Set color
    set term=xterm-256
    set t_Co=256
    colorscheme kalisi

" Set cursor
    if has("gui_running")
      " GVim Settings
      highlight Cursor guifg=white guibg=green
      highlight iCursor guifg=white guibg=red
      highlight vCursor guifg=white guibg=royalblue
      highlight rCursor guifg=white guibg=purple
      set guicursor=n-v-c:block-Cursor
      set guicursor+=i-ci:ver25-iCursor
      set guicursor+=v:ver35-vCursor
      set guicursor+=r-cr:hor20-rCursor
    else
      " Terminal Settings
      " use an red cursor in insert mode
      let &t_SI = "\<Esc>]12;red\x7"
      " use a green cursor otherwise
      let &t_EI = "\<Esc>]12;green\x7"
      silent !echo -ne "\033]12;green\007"
      " reset cursor when vim exits
      autocmd VimLeave * silent !echo -ne "\033]12;white\007"
    endif
