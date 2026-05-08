" .vimrc for CKA Exam
" Place this file in your home directory (~/.vimrc) during practice
" It prevents auto-indentation nightmares when pasting YAML

set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" Show line numbers
set number

" Enable syntax highlighting
syntax on

" Use spacebar for folding/unfolding (optional but helpful)
nnoremap <space> za
