base:
  pkg.latest:
    - pkgs:
      - bash
      - bash-completion
      - tmux
      - htop
      - nmap
      - mpv
      - pavucontrol
      - redshift
      - git
      - qbittorrent
      - curl
      - docker-compose
      {% if grains['os_family'] == 'RedHat' %}
      # - vim-enhanced
      - chromium
      - docker
      - neovim
      {% endif %}
      {% if grains['os_family'] == 'Debian' %}
      - vim
      - build-essential
      - chromium-browser
      - docker.io
      {% endif %}

{% if 'svm' or 'vmx' in grains['cpu_flags'] and grains['os_family'] == 'RedHat' %}
Virtualization:
  pkg.group_installed
{% endif %}

{% if grains['os_family'] == 'RedHat' %}
python:
  pkg.latest:
    - pkgs:
      - python2
      - python2-pip
      - python2-devel
python3:
  pkg.latest:
    - pkgs:
      - python3
      - python3-pip
      - python3-devel
{% endif %}

{% if grains['os_family'] == 'Debian' %}
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
{% endif %}

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
