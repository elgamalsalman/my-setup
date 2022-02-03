call plug#begin()
" Make sure you use single quotes
" :PlugInstall to install plugins
" Fix CursorHold Problem for faster experience with some plugins
Plug 'antoinemadec/FixCursorHold.nvim'

" -------------LAYOUT-------------
Plug 'cocopon/iceberg.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fern File Explorer
Plug 'lambdalisue/fern.vim'

" Devicons
Plug 'ryanoasis/vim-devicons'

" ---------FUNCTIONALITY---------
" Snippets
Plug 'honza/vim-snippets'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
      \ 'coc-tsserver',	
      \ 'coc-css', 
      \ 'coc-eslint', 
      \ 'coc-prettier', 
      \ 'coc-json', 
      \ 'coc-syntax',
      \ 'coc-snippets',
      \ ]

call plug#end()

inoremap <silent><expr> <Tab> pumvisible() ? "<C-y>" : "\<Tab>"

syntax on
let mapleader=","
set relativenumber number history=1000
set tabstop=2 softtabstop=2 shiftwidth=2

" Fix CursorHold Problem
let g:cursorhold_updatetime = 100

" Colorscheme
set termguicolors
colorscheme iceberg
hi Normal guibg=None ctermbg=None

" Airline
let g:airline_theme = 'iceberg'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
" " Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

" Prettier
vmap = <Plug>(coc-format-selected)
nmap == V<Plug>(coc-format-selected)
nmap = <Plug>(coc-format-selected)
