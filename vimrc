set nocompatible


" Disable lightline

let mapleader=","

set bg=dark
colorscheme one

set wildignore+=*.swp,*.zip,*.exe,*.pdf,*.docx,*.xlsx

if has('gui_running')
	set cursorline
	set lines=25 columns=90
endif

set guifont=Consolas:h12:cANSI:qDRAFT
set guioptions=ce 
"              ||
"              |+-- use simple dialogs rather than pop-ups
"              +  use GUI tabs, not console style tabs

" Set Python path
set pythonthreehome=C:/opt/python-3.11.3-embed-amd64/
set pythonthreedll=C:/opt/python-3.11.3-embed-amd64/python311.dll

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
nmap ; :CtrlPBuffer<CR>
nmap <Leader>t :CtrlP<CR>
nmap <Leader>r :CtrlPBufTagAll<CR>
