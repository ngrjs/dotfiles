call plug#begin('~/.vim/plugged')

" Vim customization plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

" Vim code plugins
Plug 'tpope/vim-fugitive'

" Vim language plugins
Plug 'fatih/vim-go'

" Initialize plugin system
call plug#end()

" Vim Base 16 related configs
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-gruvbox-dark-hard

" Vim netrw (file tree) related configs
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
