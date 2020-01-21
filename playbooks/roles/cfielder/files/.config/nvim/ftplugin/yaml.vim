setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent

let &makeprg="ansible-lint -p %"
let b:dispatch = 'ansible-lint -p %'
