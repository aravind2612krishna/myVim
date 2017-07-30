" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'myusuf3/numbers.vim'
Plug 'enricobacis/vim-airline-clock'
Plug 'lambdalisue/vim-fullscreen'
Plug 'nfvs/vim-perforce'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'jremmen/vim-ripgrep'
Plug '5t111111/alt-gtags.vim'
Plug 'tpope/vim-commentary'
"Plug 'mhinz/vim-signify'
Plug 'yssl/QFEnter'
Plug 'w0rp/ale'
Plug 'yssl/QFEnter'

" Autocomplete
" Plug 'roxma/nvim-completion-manager'
" Plug 'roxma/clang_complete'
" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ResponSySS/vim-gamp'
" Plug 'vim-scripts/clang_pro.vim'
" Plug 'vim-ctrlspace/vim-ctrlspace'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'
" let g:echodoc_enable_at_startup = 1
" Plug 'zchee/deoplete-clang', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" Basic stuff {{{
set history=500
set noautoread
let mapleader = ","
let g:mapleader = ","
set laststatus=2
filetype plugin on
filetype indent on
set wildmenu
set ruler
set cmdheight=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set smartcase
set hlsearch
set incsearch 
set lazyredraw 
set foldcolumn=1
set background=dark
if has("gui_running")
    " set guioptions-=T
    " set guioptions-=e
    set t_Co=
    " set guitablabel=%M\ %t
endif
set encoding=utf-8
set ffs=unix,dos,mac
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines

" jj to escape
inoremap jj <Esc>

" visual selection search
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab navigation
map <leader>l :tabnext<cr>
map <leader>k :tabprevious<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Toggle paste mode on and off
map <leader>o :setlocal paste!<cr>

" Helper function
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" }}}

" Font {{{
set guifont=consolas:h11:cANSI "}}}

" Colorscheme {{{
colorscheme codedark " }}}

"{{{ Airline stuff
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" unicode symbols"{{{
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
"}}}

" airline symbols"{{{
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"}}}

"}}}

" Profiling {{{
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DP :exe ":profile pause"<cr>
nnoremap <silent> <leader>DC :exe ":profile continue"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr> " }}}

" HyperWorks stuff {{{
function! GetP4Client()
    return $P4CLIENT
endfunction

function! SetHwRootDir()
    let l:fullPath = split(expand('%:p'), '\')
    let l:currPath = ''
    let l:pathCount = 0
    for l:i in l:fullPath
        let l:currPath = l:currPath . l:i . '\'
        let l:pathCount += 1
        if l:pathCount < 3
            continue
        endif
        let l:currGlob = globpath(l:currPath, '*')
        if l:currGlob =~ "hwcommon" && l:currGlob =~ "third_party"
            let $P4CLIENT = l:i
            " let $GTAGSROOT = l:currPath
            " let $GTAGSLIBPATH = l:currPath
            execute 'cd ' . l:currPath
            return
        endif
    endfor
    " echom $P4CLIENT
    " call SetHwEnvVars()
endfunction

function! SetHwEnvVars()
    let $HW_DEBUG = '1'
    let $HW_TARGET_ARCH = '64'
    let $P4PORT = 'blrp4p:1999'
    let $P4USER = 'aravk'
    let hw_paths_added = 1
    if !exists("hw_paths_added")
        let $PATH = $PATH . ";C:\program Files (x86)\Microsoft Visual Studio 10.0\VC\BIN\amd64;C:\WINDOWS\Microsoft.NET\Framework64\v4.0.30319;C:\WINDOWS\Microsoft.NET\Framework64\v3.5;C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\VCPackages;C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE;C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\Tools;C:\Program Files (x86)\HTML Help Workshop;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4.0 Tools\x64;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin\x64;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin"
        let $PATH = $PATH . ";C:\cygwin\bin"
    endif

    " :!call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x64
endfunction

autocmd BufEnter * call SetHwRootDir() " }}}

" Search only in open folds {{{
set fdo-=search
" }}}

" Async Make stuff {{{
fun! GetMakeDir()
  "make sure current directory is the current file's directory
  :cd %:p:h
  let filemk = "makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 10
    "return if we could find a makefile in current directory
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf

function! MyCompile()
    let makedir=GetMakeDir()
    "setlocal makeprg=my_compile
    execute('cd ' . makedir)
    let &makeprg = 'make -k'
    setlocal errorformat=\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %[A-Z\ ]%#%n:\ %m
    Make!
endfunction
nmap <F7> :call MyCompile()<CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
nmap <C-q> :cclose<CR> 
"}}}

" vim indent for C {{{
set cindent
set cino=t0,:0,(0,N-s
" }}}

" remap jk to escape"{{{
inoremap jk <Esc>
"}}}

" QuickFix Settings {{{
let g:qfenter_open_map = ['<CR>', '<2-LeftMouse>']
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_topen_map = ['<C-t>']
" }}}

" Macros {{{
let @d='VDO#if DEBUG_MIDMESHo#endifP' "DEBUG_MIDMESH
let @p='ipl~' " Make it a pointer
let @f='=lf(bdT f(%A;F)=a(' " Align the declaration in header
let @k='[[?)%b*N' " Go to one of the places where current function is called
" let @u = '"zyawIfor (liunsigned int A = 0; "zpA < ; ++"zpA){}kkf<ll'
let @c = 'b"zywifor (auto iter = wea.begin(); iter != "zpa.end(); ++iter){}ko'
let @s = '"tdiwafor (size_t iter = 0; iter < t.size(); ++iter){}'
" }}}

" Signify
let g:signify_disable_by_default = 1

" Vertical split char
set fillchars+=vert:│
set fillchars+=vert:▓
set fillchars+=vert:║

" ALE
let g:ale_c_build_dir=$HW_ROOTDIR

set foldmethod=marker

" Search in function C++ {{{
" Search within a scope (a {...} program block).
" Version 2010-02-28 from http://vim.wikia.com/wiki/VimTip1530

" Search within top-level block for word at cursor, or selected text.
nnoremap <Leader>[ /<C-R>=<SID>ScopeSearch('[[', 1)<CR><CR>
vnoremap <Leader>[ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>gV
" Search within current block for word at cursor, or selected text.
nnoremap <Leader>{ /<C-R>=<SID>ScopeSearch('[{', 1)<CR><CR>
vnoremap <Leader>{ <Esc>/<C-R>=<SID>ScopeSearch('[{', 2)<CR><CR>gV
" Search within current top-level block for user-entered text.
nnoremap <Leader>/ /<C-R>=<SID>ScopeSearch('[[', 0)<CR>
vnoremap <Leader>/ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>

" Return a pattern to search within a specified scope, or
" return a backslash to cancel search if scope not found.
" navigator: a command to jump to the beginning of the desired scope
" mode: 0=scope only; 1=scope+current word; 2=scope+visual selection
function! s:ScopeSearch(navigator, mode)
  if a:mode == 0
    let pattern = ''
  elseif a:mode == 1
    let pattern = '\<' . expand('<cword>') . '\>'
  else
    let old_reg = getreg('@')
    let old_regtype = getregtype('@')
    normal! gvy
    let pattern = escape(@@, '/\.*$^~[')
    call setreg('@', old_reg, old_regtype)
  endif
  let saveview = winsaveview()
  execute 'normal! ' . a:navigator
  let first = line('.')
  normal %
  let last = line('.')
  normal %
  call winrestview(saveview)
  if first < last
    return printf('\%%>%dl\%%<%dl%s', first-1, last+1, pattern)
  endif
  return "\b"
endfunction
" }}}

" vim autocomplete setting
set complete-=i

" open files relative to current path {{{
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
" }}}

" vim easy align {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign) 

let g:easy_align_delimiters = {
    \ '>': { 'pattern': '>>\|=>\|>' },
    \ '/': {
    \     'pattern':         '//\+\|/\*\|\*/',
    \     'delimiter_align': 'l',
    \     'ignore_groups':   ['!Comment'] },
    \ ']': {
    \     'pattern':       '[[\]]',
    \     'left_margin':   0,
    \     'right_margin':  0,
    \     'stick_to_left': 0
    \   },
    \ ')': {
    \     'pattern':       '[()]',
    \     'left_margin':   0,
    \     'right_margin':  0,
    \     'stick_to_left': 0
    \   },
    \ 'd': {
    \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
    \     'left_margin':  0,
    \     'right_margin': 0
    \   }
    \ }
" }}}

nnoremap <C-m> :execute 'FZF '.expand('$HW_ROOTDIR')<CR>
nnoremap ; :FZFMru<CR>

" textwidth
set tw=100
set fo+=t
set wrap linebreak nolist
set colorcolumn=-1

" syntax
syntax on

" Full screen options 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Render options
" set renderoptions+=type:directx

