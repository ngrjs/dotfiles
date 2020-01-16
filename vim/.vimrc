call plug#begin('~/.vim/plugged')

" Vim customization plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'


" Vim language plugins
Plug 'fatih/vim-go', { 'tag': '*' }

" Initialize plugin system
call plug#end()

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-gruvbox-dark-hard
