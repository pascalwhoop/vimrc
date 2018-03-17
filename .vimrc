set term=xterm-256color
set nocompatible              " be iMproved, required
filetype off                  " required

"------------------------------------------------------------
"vim customisations and custom mappings
"------------------------------------------------------------
set relativenumber
set wildignore+=*/node_modules/*,_site,*/venv/*
set encoding=utf-8
"set spell

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
"pymode mappings
"let g:pymode_rope_rename_bind = '<C-c>rr'
"let g:pymode_rope_organize_imports_bind = '<C-c>ro'
"let g:pymode_rope_extract_method_bind = '<C-c>rm'
"let g:pymode_rope_extract_variable_bind = '<C-c>rl'
"------------------------------------------------------------
"vim customisations END
"------------------------------------------------------------
"------------------------------------------------------------
" VUNDLE
"------------------------------------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" add vim plugins here
"
"Plugin 'lervag/vimtex'
Plugin 'python-mode/python-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/vim-easy-align'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'abolish.vim'
Plugin 'repeat.vim'
Plugin 'surround.vim'
Plugin 'altercation/vim-colors-solarized' "solarized theme

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"------------------------------------------------------------
" VUNDLE END
"------------------------------------------------------------
"------------------------------------------------------------
"PYTHON COMPATIBILITY
"------------------------------------------------------------
au BufNewFile,BufRead *.py
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
"set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" disable pymode linting because we use syntastic
let g:pymode_lint_on_write = 0
let g:pymode_rope_completion = 0
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1 "highlight python like crazy


"------------------------------------------------------------
"vim custom functions
"------------------------------------------------------------
command SpellOn set spell spelllang=en_us
command SpellOff set nospell
"command -nargs=1 PadRight <f-args>s/.*/\=printf('%-72s',submatch(0))
"------------------------------------------------------------
"vim custom functions END
"------------------------------------------------------------

"------------------------------------------------------------
"let g:ycm_filetype_blacklist = {}
"------------------------------------------------------------
" ultisnips SETUP 
"------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-e>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"------------------------------------------------------------
" LATEX SETUP 
"------------------------------------------------------------
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" filetype plugin on

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"------------------------------------------------------------
" LATEX END 
"------------------------------------------------------------

"------------------------------------------------------------
" SOLARIZE THEME 
"------------------------------------------------------------
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
"------------------------------------------------------------
" SOLARIZE END 
"------------------------------------------------------------
" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
" vim-easy-align setup
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------------------------------------------------
" FINAL IMPORT, nothing after this
" from https://stackoverflow.com/a/31978241/1170940
"------------------------------------------------------------
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
au VimEnter * nested :call LoadSession()
au VimLeave *  :call  MakeSession()

