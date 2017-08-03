if has("vim_starting")
    set rtp+=~/.vim/bundle/Vundle.vim
endif

set nocompatible
filetype off

" Vundle
call vundle#begin()
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'rust-lang/rust.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-bufferline'
Plugin 'gcmt/taboo.vim'
Plugin 'jamessan/vim-gnupg'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 't9md/vim-choosewin'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'

" Syntax
Plugin 'robbles/logstash.vim'

" Color schemes
Plugin 'rainux/vim-desert-warm-256'
Plugin 'toupeira/vim-desertink'
Plugin 'mhartington/oceanic-next'
call vundle#end()
filetype plugin indent on

set nocompatible
set background=dark
syntax on

if $TERM == "screen"
    set ttymouse=xterm2
endif

if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12,Menlo:h12,DejaVu\ Sans:h12,Consolas:h12
    set guioptions-=T
    colorscheme jellybeans
else
    colorscheme elflord
    if $TERM == "xterm-256color" || $TERM == "screen"
        set t_Co=256
        try
            colorscheme jellybeans
        catch
        endtry
    endif
endif

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

"set autochdir
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set fileformats=unix,dos,mac
set hidden
set iskeyword+=_,$,@,%,#
set mouse=a
set cursorline
set noerrorbells
set novisualbell
set whichwrap=b,s,<,>,~,[,]

if $TMUX == ''
    set clipboard+=unnamed
endif

" Regular expressions
set magic

" Tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" Status bar
set ruler
set showcmd
set cmdheight=1
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
if exists("&wildignorecase")
    set wildignorecase
endif
set wildmenu
set wildmode=longest:list,full
set lazyredraw
set ttyfast

" Search and highlight
set incsearch
set showmatch
set sc
set smartcase
hi NonText cterm=NONE ctermfg=NONE
hi Search cterm=bold ctermbg=99 ctermfg=17

"set cursorcolumn
"set cursorline
set laststatus=2
set linespace=0
"set list
"set listchars=tab:>-,trail:-
set modeline
set modelines=1
set nostartofline
set novisualbell
set number
set numberwidth=5
set report=5
set scrolloff=10
set sidescrolloff=10
set title

" Text Formatting
set formatoptions=rw
set ignorecase
set infercase
set shiftround
set smartcase

" Code folding
set foldenable
set foldlevelstart=6
set foldnestmax=10
set foldmethod=indent
set foldcolumn=1

" Autoreload .vimrc
if has("autocmd")
    augroup vimrchooks
        au!
        autocmd bufwritepost .vimrc source ~/.vimrc
    augroup END
endif

" Keymappings
let mapleader=","
"nnoremap <silent> <C-s> :w<CR>
nnoremap <F3> :ToggleBufExplorer<CR>
nnoremap <space> za

" Filetype-specific settings
if has("autocmd")
    " Golang
    au BufRead,BufNewFile *.go set ft=go noexpandtab softtabstop=4 tabstop=4

    " Ruby
    au BufRead,BufNewFile Berksfile set shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile Vagrantfile set shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.rb set shiftwidth=2 softtabstop=2

    " Rust
    au BufRead,BufNewFile *.rs set colorcolumn=80
endif

" Plugin: airline
let g:airline#extensions#tagbar#enabled = 0
if exists('g:asyncrun_status')
  let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
endif

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
let g:airline_theme = "jellybeans"

" Plugin: asyncrun
nnoremap <silent> <Leader>mi :w<CR>:Dispatch make install<CR>
nnoremap <silent> <Leader>mm :w<CR>:Dispatch make<CR>
nnoremap <silent> <Leader>mt :w<CR>:Dispatch make test<CR>
nnoremap <silent> <Leader>mr :w<CR>:Dispatch make run<CR>

" Plugin: bclose
nnoremap <silent> <Leader>bd :Bclose<CR>

" Plugin: BufExplorer
let g:bufExplorerSortBy = 'number'

" Plugin: choosewin
let g:choosewin_overlay_enable = 1
nmap - <Plug>(choosewin)

" Plugin: CtrlSpace
let g:CtrlSpaceSearchTiming=500
nnoremap <silent><C-p> :CtrlSpace O<CR>

" Plugin: gnupg
let g:GPGPreferArmor=1
let g:GPGPreferSign=1
let g:GPGPreferSymmetric=1

" Plugin: NERDTree
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeCreatePrefix="silent keepalt keepjumps"
let g:NERDTreeMouseMode=2
if has("autocmd")
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
nnoremap <silent> <F6> :NERDTreeToggle<CR>

" Plugin: Projectionist
let g:projectionist_heuristics = {
    \   '*.go': {
    \     '*.go': {
    \       'alternate': '{}_test.go',
    \       'type': 'source'
    \     },
    \     '*_test.go': {
    \       'alternate': '{}.go',
    \       'type': 'test'
    \     }
    \   }
    \ }

" Plugin: Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Plugin: taboo
let g:taboo_renamed_tab_format = "  %N:%l  "
let g:taboo_tab_format = "  %N:%f%m  "

" Plugin: Tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
let g:tagbar_width = 40
nnoremap <silent> <F8> :TagbarToggle<CR>

" Plugin: vimfiler
nnoremap <silent> <Leader>o :VimFiler<CR>
nnoremap <silent> <Leader>d :bdelete<CR>
