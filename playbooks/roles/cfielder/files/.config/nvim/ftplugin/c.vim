setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

" inoremap { {<CR><BS>}<Esc>ko
" inoremap ( ()<Esc>i

if executable('clang')
    let &makeprg="clang -Wall -o %< %"
else
    let &makeprg="gcc -Wall -o %< %"
endif
