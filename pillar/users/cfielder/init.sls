vimrc: |
  set nu
  set spell spelllang=en_us
  set undofile
  "set paste
  syntax on
  set mouse-=a
  set guifont=Monaco\ for\ Powerline\ Regular\ 12

  " 80 character color difference
  let &colorcolumn=join(range(80,999),",")
  highlight ColorColumn ctermbg=8
  hi ColorColumn ctermbg=Black

  " Lines for splitting
  set splitbelow
  set splitright

  " split navigation
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " shortcuts with map leader
  "let mapleader = ','
  nnoremap <leader>/ :nohls <enter>
  nnoremap <leader>w :w <enter>
  nnoremap <leader>W :%s/\s\+$//e <enter>
  nnoremap <leader>q :bd <enter>
  nnoremap <leader>n :set nonu <enter>
  nnoremap <leader>N :set nu <enter>
  nnoremap <leader>l :set list <enter>
  nnoremap <leader>L :set nolist <enter>
  nnoremap <leader>t :NERDTreeToggle <enter>

  " settings for search
  set hlsearch
  set incsearch

  " settings for tabs
  set expandtab
  set autoindent
  set smarttab

  " settings for listchars
  set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:~

  " settings for closing brackets, parenthesis, etc
  "au Filetype c inoremap ( ()<Esc>i

  " settings for folds
  nnoremap <space> za

  "
  " Plugins
  "

  call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'arcticicestudio/nord-vim'
  Plug 'valloric/youcompleteme'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-dispatch'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'godlygeek/tabular'
  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'
  Plug 'enricobacis/paste.vim'
  Plug 'google/yapf'
  Plug 'dracula/vim',{'as':'dracula'}
  call plug#end()

  " Set colorscheme and fixes
  set t_Co=256
  set background=dark
  color dracula
  highlight Normal ctermbg=NONE
  highlight nonText ctermbg=NONE

  " airline settings
  set laststatus=2
  let g:airline_theme='dracula'
  "let g:airline_powerline_fonts = 1

  " dispatch settings
  nnoremap <F3> :Dispatch<CR>
  nnoremap <F4> :Start<CR>

  " ale settings
  let g:ale_fixers = {
  \   'python': ['yapf'],
  \   'c': ['clang-format'],
  \   'yaml': ['yamllint'],
  \   'javascript': ['eslint'],
  \}
  let g:airline#extensions#ale#enabled = 1
  let g:ale_sign_column_always = 1
  nmap <F10> <Plug>(ale_fix)

  " YouCompleteMe
  let g:ycm_python_binary_path = '/usr/bin/python3'
  let g:ycm_filetype_blacklist = {}
  let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

  " vim-markdown
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

  "
  " Settings for specific filetypes
  "

  autocmd BufWritePost /etc/apache2/* !apache2ctl configtest

  " settings for editing Salt .sls files with yaml syntax hilighting
  autocmd BufNewFile,BufRead *.sls set filetype=yaml tabstop=2 softtabstop=2

  " settings for editing yml files
  autocmd BufNewFile,BufRead *.yml set filetype=yaml tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent

  " settings for editing python .py files
  "autocmd FileType python let b:dispatch = 'python %'
  "autocmd BufNewFile,BufRead *.py
  autocmd FileType python silent!
    set filetype=python
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
    set commentstring=#\ %s
    set foldmethod=indent
    nnoremap <LocalLeader>= :0,$!yapf<CR>
    let b:dispatch = 'python %'

  " settings for editing .c files
  nnoremap <F8> :w <CR> :!gcc -o %< % && ./%< <CR>
  au BufEnter *.c compiler gcc
  au Filetype c inoremap { {<CR><BS>}<Esc>ko
  au Filetype c inoremap ( ()<Esc>i
  autocmd BufNewFile,BufRead *.c
          \ set tabstop=4
          \ softtabstop=4
          \ shiftwidth=4
          \ textwidth=79
          \ expandtab
          \ autoindent
          \ fileformat=unix

bashrc: |
  ## GENERAL OPTIONS ##
  # If not running interactively, don't do anything
  case $- in
      *i*) ;;
        *) return;;
  esac

  # Prevent file overwrite on stdout redirection
  # Use `>|` to force redirection to an existing file
  set -o noclobber

  # Update window size after every command
  shopt -s checkwinsize

  # Automatically trim long paths in the prompt (requires Bash 4.x)
  PROMPT_DIRTRIM=2

  # Enable history expansion with space
  # E.g. typing !!<space> will replace the !! with your last command
  bind Space:magic-space

  # Turn on recursive globbing (enables ** to recurse all directories)
  shopt -s globstar 2> /dev/null

  # Case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob;

  ## SMARTER TAB-COMPLETION (Readline bindings) ##

  # Perform file completion in a case insensitive fashion
  bind "set completion-ignore-case on"

  # Treat hyphens and underscores as equivalent
  bind "set completion-map-case on"

  # Display matches for ambiguous patterns at first tab press
  bind "set show-all-if-ambiguous on"

  # Immediately add a trailing slash when autocompleting symlinks to directories
  bind "set mark-symlinked-directories on"

  ## SANE HISTORY DEFAULTS ##

  # Append to the history file, don't overwrite it
  shopt -s histappend

  # Save multi-line commands as one command
  shopt -s cmdhist

  # Record each line as it gets issued
  # PROMPT_COMMAND='history -a'
  export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

  # Huge history. Doesn't appear to slow things down, so why not?
  HISTSIZE=500000
  HISTFILESIZE=100000

  # Avoid duplicate entries
  HISTCONTROL="erasedups:ignoreboth"

  # Don't record some commands
  export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

  # Use standard ISO 8601 timestamp
  # %F equivalent to %Y-%m-%d
  # %T equivalent to %H:%M:%S (24-hours format)
  HISTTIMEFORMAT="%d/%m/%y %T "

  # Enable incremental history search with up/down arrows (also Readline goodness)
  # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
  bind '"\e[C": forward-char'
  bind '"\e[D": backward-char'

  ## BETTER DIRECTORY NAVIGATION ##

  # Prepend cd to directory names automatically
  shopt -s autocd 2> /dev/null
  # Correct spelling errors during tab-completion
  shopt -s dirspell 2> /dev/null
  # Correct spelling errors in arguments supplied to cd
  shopt -s cdspell 2> /dev/null

  # This defines where cd looks for targets
  # Add the directories you want to have fast access to, separated by colon
  # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
  CDPATH="."

  # This allows you to bookmark your favorite places across the file system
  # Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
  shopt -s cdable_vars

  # Examples:
  # export dotfiles="$HOME/dotfiles"
  # export projects="$HOME/projects"
  export documents="$HOME/Documents"
  # export dropbox="$HOME/Dropbox"

  # ls aliases
  alias ls='ls --color'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
  alias dirs='dirs -l -v'
  alias ip='ip -c'

  # exported variables
  export TERM="screen-256color"

  export PS1="[\t] \u@\h [\w] \\$: \[$(tput sgr0)\]"
  export PATH=$PATH:$HOME/.cargo/bin

  #aliases
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  alias sudo='sudo -E'
  # neovim all the things, if installed
  if [ -f $(which nvim) ]; then
      alias vim='$(which nvim)'
      export EDITOR=nvim
      export VISUAL=nvim
  else
      export EDITOR=vim
      export VISUAL=vim
  fi

  # AWS CLI bash completion
  complete -C '/usr/local/bin/aws_completer' aws

  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

tmux: |
  # use 256 colors
  set -g default-terminal "screen-256color"
  set -s escape-time 0
  set -sg repeat-time 600

  # remap prefix from 'C-b' to 'C-a'
  # unbind C-b
  # set-option -g prefix C-a
  # bind-key C-a send-prefix

  # makes C-a usable in addition to C-b
  # set -g prefix2 C-a
  # bind C-a send-prefix -2

  set -g history-limit 5000

  set -g set-titles on
  set -g set-titles-string "#T"

  #reload configuration
  bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

  # pane navigation
  bind -r h select-pane -L  # move left
  bind -r j select-pane -D  # move down
  bind -r k select-pane -U  # move up
  bind -r l select-pane -R  # move right
  # bind > swap-pane -D       # swap current pane with the next one
  # bind < swap-pane -U       # swap current pane with the previous one
  bind-key -r < swap-window -t -1                                                                                                                                                                                               
  bind-key -r > swap-window -t +1

  # pane resizing
  bind -r H resize-pane -L 2
  bind -r J resize-pane -D 2
  bind -r K resize-pane -U 2
  bind -r L resize-pane -R 2

  # window navigation
  unbind n
  unbind p
  bind -r C-h previous-window # select previous window
  bind -r C-l next-window     # select next window
  bind Tab last-window        # move to last active window

  # split panes using | and -
  bind | split-window -h
  bind - split-window -v
  unbind '"'
  unbind %

  # renumber windows when a window is closed
  set -g renumber-windows on

  # -- New status ---------------------------------------------------------------
  set -g status-bg "colour59"
  set -g message-command-fg "colour117"
  set -g status-justify "left"
  set -g status-left-length "100"
  set -g status "on"
  set -g pane-active-border-fg "colour215"
  set -g message-bg "colour59"
  set -g status-right-length "100"
  set -g status-right-attr "none"
  set -g message-fg "colour117"
  set -g message-command-bg "colour59"
  set -g status-attr "none"
  set -g pane-border-fg "colour59"
  set -g status-left-attr "none"
  setw -g window-status-fg "colour231"
  setw -g window-status-attr "none"
  setw -g window-status-activity-bg "colour59"
  setw -g window-status-activity-attr "none"
  setw -g window-status-activity-fg "colour215"
  setw -g window-status-separator ""
  setw -g window-status-bg "colour59"
  set -g status-left "#[fg=colour17,bg=colour215] #S #[fg=colour215,bg=colour59,nobold,nounderscore,noitalics]"
  set -g status-right "#[fg=colour61,bg=colour59,nobold,nounderscore,noitalics]#[fg=colour231,bg=colour61] %Y-%m-%d | %H:%M #[fg=colour141,bg=colour61,nobold,nounderscore,noitalics]#[fg=colour17,bg=colour141] #h "
  setw -g window-status-format "#[fg=colour231,bg=colour59] #I |#[fg=colour231,bg=colour59] #W "
  setw -g window-status-current-format "#[fg=colour59,bg=colour59,nobold,nounderscore,noitalics]#[fg=colour117,bg=colour59] #I |#[fg=colour117,bg=colour59] #W #[fg=colour59,bg=colour59,nobold,nounderscore,noitalics]"

  # -- Old status ---------------------------------------------------------------
  # left status config
  # set-window-option -g status-left " #[bold][#S] "
  # set-window-option -g status-left-fg colour200
  # set-window-option -g status-left-bg black

  # # right status config
  # set-window-option -g status-right " #[bold]#(curl ipv4.icanhazip.com)"
  # set-window-option -g status-right-fg colour200
  # set-window-option -g status-right-bg black

  # set -g status-fg colour59
  # set -g status-bg black
  # set -g window-status-fg colour60
  # set -g window-status-bg black
  # set-window-option -g window-status-format " #[bold]#I: #W "

  # set-window-option -g window-status-current-format " #[bold]#I: #W "
  # set-window-option -g window-status-current-fg colour45
  # set-window-option -g window-status-current-bg black

  # -- monitoring activity ------------------------------------------------------
  setw -g monitor-activity on
  # setw -g window-status-activity-bg colour46
  # setw -g window-status-activity-fg colour60
  set -g visual-activity off
  set -g status-interval 10
  set-window-option -g mode-keys vi

  # -- list choice --------------------------------------------------------------

  run -b 'tmux bind -t vi-choice h tree-collapse 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice l tree-expand 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice K start-of-list 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice J end-of-list 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice H tree-collapse-all 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice L tree-expand-all 2> /dev/null || true'
  run -b 'tmux bind -t vi-choice Escape cancel 2> /dev/null || true'


  # -- edit mode ----------------------------------------------------------------

  # vi-edit is gone in tmux >= 2.4
  run -b 'tmux bind -ct vi-edit H start-of-line 2> /dev/null || true'
  run -b 'tmux bind -ct vi-edit L end-of-line 2> /dev/null || true'
  run -b 'tmux bind -ct vi-edit q cancel 2> /dev/null || true'
  run -b 'tmux bind -ct vi-edit Escape cancel 2> /dev/null || true'

  # the following vi-copy bindings match my vim settings
  #   see https://github.com/gpakosz/.vim.git
  #bind -ct vi-edit H start-of-line
  #bind -ct vi-edit L end-of-line
  #bind -ct vi-edit q cancel
  #bind -ct vi-edit Escape cancel


  # -- copy mode ----------------------------------------------------------------

  bind Enter copy-mode # enter copy mode

  run -b 'tmux bind -t vi-copy v begin-selection 2> /dev/null || true'
  run -b 'tmux bind -T copy-mode-vi v send -X begin-selection 2> /dev/null || true'
  run -b 'tmux bind -t vi-copy C-v rectangle-toggle 2> /dev/null || true'
  run -b 'tmux bind -T copy-mode-vi C-v send -X rectangle-toggle 2> /dev/null || true'
  run -b 'tmux bind -t vi-copy y copy-selection 2> /dev/null || true'
  run -b 'tmux bind -T copy-mode-vi y send -X copy-selection-and-cancel 2> /dev/null || true'
  run -b 'tmux bind -t vi-copy Escape cancel 2> /dev/null || true'
  run -b 'tmux bind -T copy-mode-vi Escape send -X cancel 2> /dev/null || true'
  run -b 'tmux bind -t vi-copy H start-of-line 2> /dev/null || true'
  run -b 'tmux bind -T copy-mode-vi L send -X end-of-line 2> /dev/null || true'

  # copy to X11 clipboard
  if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
  if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'

  # Settings for moving between vim splits and tmux panes
  is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

  is_fzf="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

  bind -n C-h run "($is_vim && tmux send-keys C-h) || \
  tmux select-pane -L"

  bind -n C-j run "($is_vim && tmux send-keys C-j)  || \
  ($is_fzf && tmux send-keys C-j) || \
  tmux select-pane -D"

  bind -n C-k run "($is_vim && tmux send-keys C-k) || \
  ($is_fzf && tmux send-keys C-k)  || \
  tmux select-pane -U"

  bind -n C-l run "($is_vim && tmux send-keys C-l) || \
  tmux select-pane -R"

  bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"


i3: |
  set $mod Mod1
  font Iosevka Term 8
  floating_modifier $mod

  # start a terminal
  bindsym $mod+Return exec i3-sensible-terminal

  # kill focused window
  bindsym $mod+Shift+q kill

  # start dmenu (a program launcher)
  bindsym $mod+d exec dmenu_run
  # There also is the (new) i3-dmenu-desktop which only displays applications
  # shipping a .desktop file. It is a wrapper around dmenu, so you need that
  # installed.
  # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

  # change focus
  bindsym $mod+h focus left
  bindsym $mod+j focus down
  bindsym $mod+k focus up
  bindsym $mod+l focus right

  # alternatively, you can use the cursor keys:
  bindsym $mod+Left focus left
  bindsym $mod+Down focus down
  bindsym $mod+Up focus up
  bindsym $mod+Right focus right

  # move focused window
  bindsym $mod+Shift+h move left
  bindsym $mod+Shift+j move down
  bindsym $mod+Shift+k move up
  bindsym $mod+Shift+l move right

  # alternatively, you can use the cursor keys:
  bindsym $mod+Shift+Left move left
  bindsym $mod+Shift+Down move down
  bindsym $mod+Shift+Up move up
  bindsym $mod+Shift+Right move right

  # split in horizontal orientation
  bindsym $mod+c split h

  # split in vertical orientation
  bindsym $mod+v split v

  # enter fullscreen mode for the focused container
  bindsym $mod+f fullscreen toggle

  # change container layout (stacked, tabbed, toggle split)
  bindsym $mod+s layout stacking
  bindsym $mod+w layout tabbed
  bindsym $mod+e layout toggle split

  # toggle tiling / floating
  bindsym $mod+Shift+space floating toggle

  # change focus between tiling / floating windows
  bindsym $mod+space focus mode_toggle

  # focus the parent container
  bindsym $mod+a focus parent

  # focus the child container
  #bindsym $mod+d focus child

  #lock i3
  bindsym $mod+q exec i3lock

  # switch to workspace
  bindsym $mod+1 workspace 1
  bindsym $mod+2 workspace 2
  bindsym $mod+3 workspace 3
  bindsym $mod+4 workspace 4
  bindsym $mod+5 workspace 5
  bindsym $mod+6 workspace 6
  bindsym $mod+7 workspace 7
  bindsym $mod+8 workspace 8
  bindsym $mod+9 workspace 9
  bindsym $mod+0 workspace 10

  # move focused container to workspace
  bindsym $mod+Shift+1 move container to workspace 1
  bindsym $mod+Shift+2 move container to workspace 2
  bindsym $mod+Shift+3 move container to workspace 3
  bindsym $mod+Shift+4 move container to workspace 4
  bindsym $mod+Shift+5 move container to workspace 5
  bindsym $mod+Shift+6 move container to workspace 6
  bindsym $mod+Shift+7 move container to workspace 7
  bindsym $mod+Shift+8 move container to workspace 8
  bindsym $mod+Shift+9 move container to workspace 9
  bindsym $mod+Shift+0 move container to workspace 10

  # use workspaces on different monitors
  workspace "1" output DP-0.8
  workspace "2" output DP-0.8
  workspace "3" output DP-0.8
  workspace "4" output DP-0.8
  workspace "5" output DP-0.8
  workspace "6" output DP-2
  workspace "7" output DP-2
  workspace "8" output DP-2
  workspace "9" output DP-2
  workspace "10" output DP-2

  # reload the configuration file
  bindsym $mod+Shift+c reload
  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  bindsym $mod+Shift+r restart
  # exit i3 (logs you out of your X session)
  bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

  # resize window (you can also use the mouse for that)
  mode "resize" {
          # These bindings trigger as soon as you enter the resize mode

          bindsym h resize shrink width 10 px or 10 ppt
          bindsym j resize grow height 10 px or 10 ppt
          bindsym k resize shrink height 10 px or 10 ppt
          bindsym l resize grow width 10 px or 10 ppt

          # same bindings, but for the arrow keys
          bindsym Left resize shrink width 10 px or 10 ppt
          bindsym Down resize grow height 10 px or 10 ppt
          bindsym Up resize shrink height 10 px or 10 ppt
          bindsym Right resize grow width 10 px or 10 ppt

          # back to normal: Enter or Escape
          bindsym Return mode "default"
          bindsym Escape mode "default"
  }

  bindsym $mod+r mode "resize"

  # Start i3bar to display a workspace bar (plus the system information i3status
  # finds out, if available)
  #bar {
  #        status_command i3status
  #        position top
  #}

  exec --no-startup-id nitrogen --restore
  exec --no-startup-id ~/.config/polybar/launch-polybar.sh
  exec --no-startup-id redshift-gtk
  exec --no-startup-id albert
  exec --no-startup-id "eval `ssh-agent`

redshift: |
  [redshift]
  temp-day=5700
  temp-night = 1500
  location-provider=manual

  [manual]
  lat=34.0
  lon=-84.6

terminator: |
  [global_config]
    title_hide_sizetext = True
    title_inactive_bg_color = "#75715e"
    title_inactive_fg_color = "#f8f8f2"
    title_receive_bg_color = "#8FBCBB"
    title_receive_fg_color = "#2E3440"
    title_transmit_bg_color = "#272822"
    title_transmit_fg_color = "#f8f8f2"
    title_use_system_font = False
    window_state = maximise
  [keybindings]
  [layouts]
    [[default]]
      [[[child1]]]
        parent = window0
        type = Terminal
      [[[window0]]]
        parent = ""
        type = Window
  [plugins]
  [profiles]
    [[default]]
      background_color = "#272822"
      background_darkness = 0.9
      background_type = transparent
      cursor_color = "#f8f8f2"
      custom_command = /usr/bin/tmux
      font = mononoki 13
      foreground_color = "#f8f8f2"
      palette = "#272822:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#a1efe4:#f8f8f2:#75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#a1efe4:#f9f8f5"
      scrollbar_position = hidden
      show_titlebar = False
      use_system_font = False
    [[Arc]]
      background_color = "#2e3440"
      background_darkness = 1.0
      background_type = transparent
      cursor_color = "#D8DEE9"
      custom_command = /usr/bin/tmux
      font = mononoki 13
      foreground_color = "#d8dee9"
      palette = "#3b4252:#bf616a:#a3be8c:#ebcb8b:#81a1c1:#b48ead:#88c0d0:#e5e9f0:#4c566a:#bf616a:#a3be8c:#ebcb8b:#81a1c1:#b48ead:#8fbcbb:#eceff4"
      scrollbar_position = hidden
      show_titlebar = False
      use_system_font = False
    [[OneDark]]
      background_color = "#282c34"
      background_darkness = 0.98
      copy_on_selection = True
      cursor_color = "#bbbbbb"
      font = Monaco for Powerline 13
      foreground_color = "#abb2bf"
      icon_bell = False
      palette = "#000000:#eb6e67:#95ee8f:#f8c456:#6eaafb:#d886f3:#6cdcf7:#b2b2b2:#50536b:#eb6e67:#95ee8f:#f8c456:#6eaafb:#d886f3:#6cdcf7:#dfdfdf"
      scrollbar_position = hidden
      show_titlebar = False

profile: |
    if [ -n "$BASH_VERSION" ]; then
      # include .bashrc if it exists
      if [ -f "$HOME/.bashrc" ]; then
          . "$HOME/.bashrc"
      fi
    fi
