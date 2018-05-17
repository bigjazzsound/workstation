base:
  pkg.installed:
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
      - vim-enhanced
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

update:
  pkg.uptodate:
    - name: "Update packages"
    - refresh: True

{% if 'svm' or 'vmx' in grains['cpu_flags'] and grains['os_family'] == 'RedHat' %}
Virtualization:
  pkg.group_installed
{% endif %}

{% if grains['os_family'] == 'RedHat' %}
python:
  pkg.installed:
    - pkgs:
      - python2
      - python2-pip
      - python2-devel
python3:
  pkg.installed:
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
    - user: bigjazzsound
    - require:
      - pkg: python
    - upgrade: True

pip3_user_packages:
  pip.installed:
    - pkgs:
      - neovim
      - yapf
    - user: bigjazzsound
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: python3
    - upgrade: True
