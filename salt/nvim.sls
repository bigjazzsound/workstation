neovim:
  pkgrepo.managed:
    - human_name: Neovim Repo
    - name: deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/neovim-ppa-ubuntu-stable-bionic.list
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - refresh: True
    - name: []

vim-plug:
  file.managed:
    - name: /home/cfielder/.local/share/nvim/site/autoload/plug.vim
    - source: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - makedirs: True
    - skip_verify: True
    - user: cfielder
    - group: cfielder
    - recurse: True

plug-update:
  cmd.run:
    - name: 'nvim +PlugUpdate +qall > /dev/null 2>&1'
    - user: cfielder
    - stateful: True
    - require:
      - pkg: neovim
