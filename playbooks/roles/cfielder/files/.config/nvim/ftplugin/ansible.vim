" Set the filetype to yaml.ansible if it is in the playbooks directory
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
let &makeprg="ansible-lint %"
