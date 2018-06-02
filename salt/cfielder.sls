{% set user='cfielder' %}

docker:
  group.present

{{ user }}:
  group.present: []
  user.present:
    - fullname: Craig James Fielder
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: 1000
    - gid: 1000
    {% if grains['os_family'] == 'RedHat' %}
    - groups: [wheel]
    - optional_groups: [libvirt, docker]
    {% endif %}
    {% if grains['os_family'] == 'ubuntu' %}
    - groups: [sudo]
    - optional_groups: [docker, libvirtd]
    {% endif %}

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

/usr/share/applications/Alacritty.desktop:
  file.managed:
    - contents_pillar: alacritty-desktop
    - user: root
    - group: root

/usr/local/bin/alacritty:
  file.symlink:
    - target: /home/{{ user }}/.cargo/bin/alacritty
    - user: root
    - group: root
    - makedirs: True

/home/{{ user }}/.bash.local:
  file.managed:
    - user: {{ user }}
    - group: {{ user }}
    - replace: False

/home/{{ user }}/.weechat:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True

/home/{{ user }}/.weechat/weechat.conf:
  file.managed:
    - contents_pillar: weechat
    - user: {{ user }}
    - group: {{ user }}

go_dirs:
  file.directory:
    - names:
      - /home/{{ user }}/go
      - /home/{{ user }}/go/src
      - /home/{{ user }}/go/bin
      - /home/{{ user }}/go/pkg
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
    - makedirs: True
