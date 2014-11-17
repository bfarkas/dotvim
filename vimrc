execute pathogen#infect()
execute pathogen#helptags()

syntax on
filetype plugin on
filetype plugin indent on
set number

colorscheme flattown

" always show vim-airline with powerline fonts
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'flattown'

map <C-n> :NERDTreeToggle<CR>
