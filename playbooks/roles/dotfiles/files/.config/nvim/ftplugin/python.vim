setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal commentstring=#\ %s
setlocal foldmethod=indent

nnoremap <F8> :CocCommand python.execInTerminal<CR>
