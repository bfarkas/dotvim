set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'blerins/flattown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
"Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-latex/vim-latex'
Plugin 'tpope/vim-scriptease'
Plugin 'salsifis/vim-transpose'
Plugin 'vim-scripts/vimwiki'
Plugin 'dense-analysis/ale'
Plugin 'majutsushi/tagbar'
Plugin 'itchyny/lightline.vim'
Plugin 'maximbaz/lightline-ale'

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
"
syntax on
"filetype plugin on
set number
set mouse=a

set guifont=Hack:h11 
colorscheme flattown-mod 

" always show lightline
set laststatus=2
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'flattown'

map <C-n> :NERDTreeToggle<CR>

if $HOSTNAME == "gpserv.c3e.cs.tu-bs.de"
  if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
  endif
  
  set backspace=indent,eol,start
endif

" set paste magic for tmux
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>P"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

nmap <F8> :TagbarToggle<CR>

"vim latex settings
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
let g:Tex_ViewRule_pdf = 'open -a Preview.app'

"ALE Linters
let g:ale_linters = {
\   'python': ['pyls'],
\}
"folding settings, open all folds automatically
au BufRead * normal zR

" mode is not necessary with lightline
set noshowmode

" lightline settings
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [['filetype'],[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
