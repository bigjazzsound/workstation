setlocal filetype=yaml
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

let &makeprg="ansible-lint -p %"
let b:dispatch = 'ansible-lint -p %'
