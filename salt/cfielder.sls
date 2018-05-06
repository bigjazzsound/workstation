{% set user='cfielder' %}
{{ user }}:
  user.present:
    - fullname: Craig James Fielder
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: 1000
    - gid: 1000
    - groups: [docker, kvm, libvirtd, sudo]

/home/{{ user }}/.bashrc:
  file.managed:
    - contents_pillar: bashrc
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.tmux.conf:
  file.managed:
    - contents_pillar: tmux
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.config/i3/config:
  file.managed:
    - contents_pillar: i3
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.vimrc:
  file.managed:
    - contents_pillar: vimrc
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.config/nvim/init.vim:
  file.symlink:
    - target: /home/{{ user }}/.vimrc
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.config/terminator/config:
  file.managed:
    - contents_pillar: terminator
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.config/alacritty/alacritty.yml:
  file.managed:
    - contents_pillar: alacritty
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.config/redshift.conf:
  file.managed:
    - contents_pillar: redshift
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.profile:
  file.managed:
    - contents_pillar: profile
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.fonts:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

# /home/{{ user }}/.config/polybar/config
# /home/{{ user }}/.config/polybar/launch-polybar.sh
