let &makeprg="terraform plan -no-color"
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal commentstring=//\ %s

command! Format :TerraformFmt
