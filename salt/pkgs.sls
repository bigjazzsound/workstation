base:
  pkg.latest:
    - pkgs:
      - bash
      - bash-completion
      - vim
      - tmux
      - htop
      - nmap
      - mpv
      - chromium-browser
      - pavucontrol
      - redshift
      - git
      - qbittorrent
      - build-essential
      - curl
      - docker.io
      - docker-compose

python:
  pkg.latest:
    - pkgs:
      - python
      - python-pip
      - python-dev

python3:
  pkg.latest:
    - pkgs:
      - python3
      - python3-venv
      - python3-pip
      - python3-dev

pip_user_packages:
  pip.installed:
    - pkgs:
      - neovim
      - yapf
    - user: cfielder
    - require:
      - pkg: python
    - upgrade: True

pip3_user_packages:
  pip.installed:
    - pkgs:
      - neovim
      - yapf
    - user: cfielder
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: python3
    - upgrade: True

# google-chrome-stable:
#   pkgrepo.managed:
#     - human_name: Google Chrome Repo
#     - name: deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
#     - file: /etc/apt/sources.list.d/google-chrome.list
#     - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub
#   pkg.latest:
#     - refresh: True
#     - name: []

# syncthing:
#   pkgrepo.managed:
#     - human_name: Syncthing Repo
#     - name: deb https://apt.syncthing.net/ syncthing stable
#     - file: /etc/apt/sources.list.d/syncthing.list
#     - key_url: https://syncthing.net/release-key.txt
#   pkg.latest:
#     - refresh: True
#     - name: []
