set nocompatible

let mapleader=","

syntax enable

filetype plugin on
filetype indent on

set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set termguicolors
set expandtab
set autoindent

set background=dark
colorscheme catppuccin_frappe

" Finding files
set path+=**
set wildignore+=*.swp,*.zip,*.exe,*.pdf,*.docx,*.xlsx
set wildmenu

command! MakeTags !ctags -R .

if has('gui_running')
	set cursorline
	set lines=25 columns=90
endif

set guifont=Consolas:h12:cANSI:qDRAFT
set guioptions=ce
"              ||
"              |+-- use simple dialogs rather than pop-ups
"              +  use GUI tabs, not console style tabs

if $COMPUTERNAME == 'LTGO647023'
	" Set Python path
	set pythonthreehome=C:/opt/python-3.11.3-embed-amd64/
	set pythonthreedll=C:/opt/python-3.11.3-embed-amd64/python311.dll
endif

let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap ; :Unite buffer<cr>
nnoremap <leader>, :Unite -start-insert file_rec<cr>

" Numbering
set number

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> gd <plug>(lsp-declaration)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <expr><c-j> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-k> lsp#scroll(-4)

	let g:lsp_format_sync_timeout = 1000
	autocmd! BufWritePre *.lua,*.json call execute('LspDocumentFormatSync')

	" refer to doc to add more commands
endfunction

augroup lsp_install
	au!
	" call s:on_lsp_buffer_enabled only for languages that has the server registered.
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_virtual_text_align = "right"
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
