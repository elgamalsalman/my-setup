"""""""""""""""""""""""""""""""""""
" DONT FORGET RUNNING PlugInstall "
"""""""""""""""""""""""""""""""""""

call plug#begin()
" Fix CursorHold Problem for faster experience with some plugins
Plug 'antoinemadec/FixCursorHold.nvim'

" -------------LAYOUT-------------
" Colorschemes
Plug 'cocopon/iceberg.vim'
" Plug 'ulwlu/abyss.vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'rainglow/vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'pangloss/vim-javascript'

" Airline
Plug 'vim-airline/vim-airline'

" Fern File Explorer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-mapping-git.vim'

" Built in terminal
Plug 'akinsho/toggleterm.nvim'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Toggle Fullscreen
Plug 'markstory/vim-zoomwin'

" ---------FUNCTIONALITY---------
" Snippets
Plug 'honza/vim-snippets'

" Autoclose pairs
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

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

" ---------FUNCTIONALITY---------
syntax on
let mapleader=","
set relativenumber number history=1000 nohlsearch
set tabstop=2 softtabstop=2 shiftwidth=2
set wrap hidden

" Autoclose tags
function! s:isTagLanguage()
	let extensions = ["html", "htm", "jsx", "tsx"]
	if index(extensions, expand("%:e")) == -1
		return 0
	endif
	return 1
endfunction
function! s:isOpeningTag()
	let currLine = getline(".")[0:col(".")-1]
	let i = len(currLine) - 1
	while i >= 0
		if currLine[i] == "/"
			return 0
		endif
		if currLine[i] == "<"
			return 1
		endif
		let i -= 1
	endwhile
	return 0
endfunction
inoremap <expr> ><CR> <SID>isTagLanguage() ? (<SID>isOpeningTag() ? "></<C-x><C-o><C-y><C-o>%<CR><C-o>O" : "><CR>") : "><CR>"
inoremap <expr> / <SID>isTagLanguage() ? (getline(".")[col(".")-2]=="<" ? "/<C-x><C-o>" : "/") : "/"
inoremap <expr> <cr> <SID>isTagLanguage() ? (getline(".")[col(".")-2:col(".")]=="></" ? "<cr><esc>O" : "<cr>") : "<cr>"

" <tab> to select suggestion
inoremap <silent><expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"

" Fix CursorHold Problem
let g:cursorhold_updatetime = 100

" -------------LAYOUT-------------
" Colorscheme
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme material
hi Normal guibg=None ctermbg=None

" Airline
let g:airline_theme = 'iceberg'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
" " Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

" Prettier
function! s:isPrettierLanguage()
	let extensions = ["html", "htm", "js", "ts", "jsx", "tsx", "json", "css", "scss"]
	if index(extensions, expand("%:e")) == -1
		return 0
	endif
	return 1
endfunction
vmap <expr> = <SID>isPrettierLanguage() ? "<Plug>(coc-format-selected)" : "="
nn <expr> == <SID>isPrettierLanguage() ? "V<Plug>(coc-format-selected)" : "=="
nn <expr> = <SID>isPrettierLanguage() ? "<Plug>(coc-format-selected)" : "="

" Fern File Explorer
function! s:init_fern() abort
	nmap <buffer> o <Plug>(fern-action-open:edit)
	nmap <buffer> O <Plug>(fern-action-open:edit)<C-w>p
	nmap <buffer> t <Plug>(fern-action-open:tabedit)
	nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
	nmap <buffer> s <Plug>(fern-action-open:split)
	nmap <buffer> S <Plug>(fern-action-open:split)<C-w>p
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer> V <Plug>(fern-action-open:vsplit)<C-w>p

	nmap <buffer> n <Plug>(fern-action-new-path)
	nmap <buffer> dd <Plug>(fern-action-remove)
	nmap <buffer> m <Plug>(fern-action-move)
	nmap <buffer> u <Plug>(fern-action-leave)
	nmap <buffer> r <Plug>(fern-action-reload)
	nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
	nmap <buffer> cd <Plug>(fern-action-cd)
	nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
	nmap <buffer> I <Plug>(fern-action-hidden-toggle)
	nmap <buffer> q :<C-u>quit<CR>

	nmap <buffer> <C-k><C-b> :Fern . -drawer -stay -toggle<CR>
	nmap <C-k><C-b> :Fern . -drawer -reveal=% -stay -toggle<CR>
	nmap <C-k><C-k> :Fern . -reveal=%<CR>
endfunction
augroup fern-custom
	let g:fern#default_hidden = 1
	let g:fern#renderer = "nerdfont"
	let g:fern#drawer_keep = 1

	autocmd FileType fern call s:init_fern()
	autocmd VimEnter,TabEnter * ++nested Fern . -drawer -reveal=% -stay -toggle
augroup END

" Terminal
nn <C-k><C-t> :ToggleTerm<CR>
tno <C-k><C-t> <C-\><C-n>:ToggleTerm<CR>
tno <C-[> <C-\><C-n>
tno <C-e> <C-\><C-n><C-e>
tno <C-y> <C-\><C-n><C-y>

" Zoom on Window
nn <M-CR> :ZoomToggle<Cr>
tno <M-CR> <C-\><C-n>:ZoomToggle<CR>i
ino <M-CR> <C-o>:ZoomToggle<CR>
