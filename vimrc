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
set wildignore+=*.swp,*.zip,*.tar.gz,*.7z,*.exe,*.pdf,*.docx,*.xlsx
" Ignore python files
set wildignore+=*.egg-info/,*.pyc,__pycache__/,.pytest_cache/,*.whl,.ipynb_checkpoints/,_build/

set wildmenu

command! MakeTags !ctags -R .

if has('gui_running')
    set cursorline
    set lines=25 columns=90
endif

set guioptions=ce
"              ||
"              |+-- use simple dialogs rather than pop-ups
"              +  use GUI tabs, not console style tabs

if $COMPUTERNAME == 'LTVAC737023'
    set guifont=FiraCode_Nerd_Font_Mono_Ret:h10:W450:cANSI:qDRAFT
	" Set Python path
	set pythonthreehome=C:/opt/python-3.12.0-embed-amd64/
	set pythonthreedll=C:/opt/python-3.12.0-embed-amd64/python312.dll
endif

" Load the packages
packl

if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
endif

let g:unite_source_history_yank_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec', 'ignore_globs', split(&wildignore, ','))

if executable('rg')
    let g:unite_source_grep_command = 'rg'
    let g:unite_source_grep_default_opts = '--vimgrep'
    let g:unite_source_grep_recursive_opt = ''
endif

nnoremap ; :Unite buffer<cr>
nnoremap <leader>, :Unite -start-insert file_rec<cr>
nnoremap <leader>s :UniteWithBufferDir -start-insert grep<cr>

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

let g:sneak#label = 1

let g:ale_virtualtext_cursor = 'disabled'
let g:ale_set_signs = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight link ALEErrorSign    Error
highlight link ALEWarningSign  Warning

let g:ale_linters_explicit = 1
let g:ale_linters = {
            \  'python': ['vim-lsp'],
            \}

let g:ale_fix_on_save = 0
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['ruff', 'ruff_format'],
            \}

" Configuration for note taking

function EditWeeklyMarkdown()
    " Get the current year and week number
    let l:year = strftime("%Y")
    let l:week = strftime("%V")

    " Construct the directory and file path
    let l:directory = expand("$HOME/Notes/" . l:year)  " Adjust path if needed
    let l:file = l:directory . "/" . l:year . "W" . l:week . ".md"

    " Check if the directory exists, create it if not
    if !isdirectory(l:directory)
        call mkdir(l:directory, "p")
    endif

    " Create or overwrite the file
    execute "edit " . l:file

    " Add a basic markdown header (optional)
    call append(0, "# l:year -  Week " . l:week)
    normal! G
endfunction

" Go to index of notes and set working directory to my notes
nnoremap <leader>ni :e $NOTES_DIR/index.md<CR>:cd $NOTES_DIR<CR>
nnoremap <leader>nw :call EditWeeklyMarkdown()<CR>:cd $NOTES_DIR<CR>
