base:
  pkg.installed:
    - pkgs:
      - tmux
      - neovim
      - htop
      - nmap
      - mpv
      - python3-venv
      - chromium-browser
      - pavucontrol
      - redshift
      - git
      - yadm
      - qbittorrent
      - bash
      - bash-completion

google-chrome-stable:
  pkgrepo.managed:
    - human_name: Google Chrome Repo
    - name: deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
    - file: /etc/apt/sources.list.d/google-chrome.list
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub
  pkg.installed:
    - fromrepo: deb http://dl.google.com/linux/chrome/deb/ stable main

syncthing:
  pkgrepo.managed:
    - human_name: Syncthing Repo
    - name: deb https://apt.syncthing.net/ syncthing stable
    - file: /etc/apt/sources.list.d/syncthing.list
    - key_url: https://syncthing.net/release-key.txt
  pkg.installed:
    - fromrepo: deb https://apt.syncthing.net/ syncthing stable

neovim:
  pkgrepo.managed:
    - human_name: Neovim Repo
    - name: deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main
    - file: /etc/apt/sources.list.d/neovim-ppa-ubuntu-stable-xenial.list
    - keyid: 8231B6DD
    - keyserver: keyserver.ubuntu.com
  pkg.installed:
    - fromrepo: deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main
