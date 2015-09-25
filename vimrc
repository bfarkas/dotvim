execute pathogen#infect()
execute pathogen#helptags()

syntax on
filetype plugin on
filetype plugin indent on
set number

set guifont=Hack:h11 
colorscheme flattown

" always show vim-airline with powerline fonts
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'flattown'

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
