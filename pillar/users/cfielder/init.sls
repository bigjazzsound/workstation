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
  " Plug 'valloric/youcompleteme'
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
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'zchee/deoplete-jedi'
  Plug 'zchee/deoplete-go', { 'do': 'make'}
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

  " Deoplete
  let g:deoplete#enable_at_startup = 1

  " vim-markdown
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

  "
  " Settings for specific filetypes
  "

  autocmd BufWritePost /etc/apache2/* !apache2ctl configtest

  " settings for C makefiles
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

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

  " settings for editing go files
  autocmd FileType go setlocal commentstring=//\ %s

  " settings for editing vimrc
  autocmd Filetype vim setlocal commentstring=\"\ %s

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
  export PATH=$PATH:$(go env GOPATH)/bin

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
  [ -f ~/.bashrc.local ] && source ~/.bashrc.local

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

alacritty: |
  # Configuration for Alacritty, the GPU enhanced terminal emulator
  # Any items in the `env` entry below will be added as
  # environment variables. Some entries may override variables
  # set by alacritty it self.
  env:
    # TERM env customization.
    #
    # If this property is not set, alacritty will set it to xterm-256color.
    #
    # Note that some xterm terminfo databases don't declare support for italics.
    # You can verify this by checking for the presence of `smso` and `sitm` in
    # `infocmp xterm-256color`.
    TERM: xterm-256color

  window:
    # Window dimensions in character columns and lines
    # Falls back to size specified by window manager if set to 0x0.
    # (changes require restart)
    dimensions:
      columns: 80
      lines: 24

    # Adds this many blank pixels of padding around the window
    # Units are physical pixels; this is not DPI aware.
    # (change requires restart)
    padding:
      x: 2
      y: 2

    # Window decorations
    # Setting this to false will result in window without borders and title bar.
    decorations: true

  # Display tabs using this many cells (changes require restart)
  tabspaces: 8

  # When true, bold text is drawn using the bright variant of colors.
  draw_bold_text_with_bright_colors: true

  # Font configuration (changes require restart)
  #
  # Important font attributes like antialiasing, subpixel aa, and hinting can be
  # controlled through fontconfig. Specifically, the following attributes should
  # have an effect:
  #
  # * hintstyle
  # * antialias
  # * lcdfilter
  # * rgba
  #
  # For instance, if you wish to disable subpixel antialiasing, you might set the
  # rgba property to "none". If you wish to completely disable antialiasing, you
  # can set antialias to false.
  #
  # Please see these resources for more information on how to use fontconfig
  #
  # * https://wiki.archlinux.org/index.php/font_configuration#Fontconfig_configuration
  # * file:///usr/share/doc/fontconfig/fontconfig-user.html
  font:
    # The normal (roman) font face to use.
    normal:
      family: monaco # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      # style: Regular

    # The bold font face
    bold:
      family: monaco # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      # style: Bold

    # The italic font face
    italic:
      family: monaco # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      # style: Italic

    # Point size of the font
    size: 12.0

    # Offset is the extra space around each character. offset.y can be thought of
    # as modifying the linespacing, and offset.x as modifying the letter spacing.
    offset:
      x: 0
      y: 0

    # Glyph offset determines the locations of the glyphs within their cells with
    # the default being at the bottom. Increase the x offset to move the glyph to
    # the right, increase the y offset to move the glyph upward.
    glyph_offset:
      x: 0
      y: 0

    # OS X only: use thin stroke font rendering. Thin strokes are suitable
    # for retina displays, but for non-retina you probably want this set to
    # false.
    use_thin_strokes: true

  # Should display the render timer
  render_timer: false

  # Use custom cursor colors. If true, display the cursor in the cursor.foreground
  # and cursor.background colors, otherwise invert the colors of the cursor.
  custom_cursor_colors: false

  # Colors (Dracula)
  colors:
    # Default colors
    primary:
      background: '0x282a36'
      foreground: '0xf8f8f2'

    # Normal colors
    normal:
      black:   '0x000000'
      red:     '0xff5555'
      green:   '0x50fa7b'
      yellow:  '0xf1fa8c'
      blue:    '0xcaa9fa'
      magenta: '0xff79c6'
      cyan:    '0x8be9fd'
      white:   '0xbfbfbf'

    # Bright colors
    bright:
      black:   '0x282a35'
      red:     '0xff6e67'
      green:   '0x5af78e'
      yellow:  '0xf4f99d'
      blue:    '0xcaa9fa'
      magenta: '0xff92d0'
      cyan:    '0x9aedfe'
      white:   '0xe6e6e6'

  # Visual Bell
  #
  # Any time the BEL code is received, Alacritty "rings" the visual bell. Once
  # rung, the terminal background will be set to white and transition back to the
  # default background color. You can control the rate of this transition by
  # setting the `duration` property (represented in milliseconds). You can also
  # configure the transition function by setting the `animation` property.
  #
  # Possible values for `animation`
  # `Ease`
  # `EaseOut`
  # `EaseOutSine`
  # `EaseOutQuad`
  # `EaseOutCubic`
  # `EaseOutQuart`
  # `EaseOutQuint`
  # `EaseOutExpo`
  # `EaseOutCirc`
  # `Linear`
  #
  # To completely disable the visual bell, set its duration to 0.
  #
  visual_bell:
    animation: EaseOutExpo
    duration: 0

  # Background opacity
  background_opacity: 1.0

  # Mouse bindings
  #
  # Currently doesn't support modifiers. Both the `mouse` and `action` fields must
  # be specified.
  #
  # Values for `mouse`:
  # - Middle
  # - Left
  # - Right
  # - Numeric identifier such as `5`
  #
  # Values for `action`:
  # - Paste
  # - PasteSelection
  # - Copy (TODO)
  mouse_bindings:
    - { mouse: Middle, action: PasteSelection }

  mouse:
    # Click settings
    #
    # The `double_click` and `triple_click` settings control the time
    # alacritty should wait for accepting multiple clicks as one double
    # or triple click.
    double_click: { threshold: 300 }
    triple_click: { threshold: 300 }

    # Faux Scrollback
    #
    # The `faux_scrollback_lines` setting controls the number
    # of lines the terminal should scroll when the alternate
    # screen buffer is active. This is used to allow mouse
    # scrolling for applications like `man`.
    #
    # To disable this completely, set `faux_scrollback_lines` to 0.
    faux_scrollback_lines: 1

  selection:
    semantic_escape_chars: ",`|:\"' ()[]{}<>"

  dynamic_title: true

  hide_cursor_when_typing: false

  # Style of the cursor
  #
  # Values for 'cursor_style':
  # - Block
  # - Underline
  # - Beam
  cursor_style: Block

  # Live config reload (changes require restart)
  live_config_reload: true

  # Shell
  #
  # You can set shell.program to the path of your favorite shell, e.g. /bin/fish.
  # Entries in shell.args are passed unmodified as arguments to the shell.
  #
  # shell:
  #   program: /bin/bash
  #   args:
  #     - --login

  # Key bindings
  #
  # Each binding is defined as an object with some properties. Most of the
  # properties are optional. All of the alphabetical keys should have a letter for
  # the `key` value such as `V`. Function keys are probably what you would expect
  # as well (F1, F2, ..). The number keys above the main keyboard are encoded as
  # `Key1`, `Key2`, etc. Keys on the number pad are encoded `Number1`, `Number2`,
  # etc.  These all match the glutin::VirtualKeyCode variants.
  #
  # A list with all available `key` names can be found here:
  # https://docs.rs/glutin/*/glutin/enum.VirtualKeyCode.html#variants
  #
  # Possible values for `mods`
  # `Command`, `Super` refer to the super/command/windows key
  # `Control` for the control key
  # `Shift` for the Shift key
  # `Alt` and `Option` refer to alt/option
  #
  # mods may be combined with a `|`. For example, requiring control and shift
  # looks like:
  #
  # mods: Control|Shift
  #
  # The parser is currently quite sensitive to whitespace and capitalization -
  # capitalization must match exactly, and piped items must not have whitespace
  # around them.
  #
  # Either an `action`, `chars`, or `command` field must be present.
  #   `action` must be one of `Paste`, `PasteSelection`, `Copy`, or `Quit`.
  #   `chars` writes the specified string every time that binding is activated.
  #     These should generally be escape sequences, but they can be configured to
  #     send arbitrary strings of bytes.
  #   `command` must be a map containing a `program` string, and `args` array of
  #     strings. For example:
  #     - { ... , command: { program: "alacritty", args: ["-e", "vttest"] } }
  #
  # Want to add a binding (e.g. "PageUp") but are unsure what the X sequence
  # (e.g. "\x1b[5~") is? Open another terminal (like xterm) without tmux,
  # then run `showkey -a` to get the sequence associated to a key combination.
  key_bindings:
    - { key: V,        mods: Control|Shift,    action: Paste               }
    - { key: C,        mods: Control|Shift,    action: Copy                }
    - { key: Q,        mods: Command, action: Quit                         }
    - { key: W,        mods: Command, action: Quit                         }
    - { key: Insert,   mods: Shift,   action: PasteSelection               }
    - { key: Key0,     mods: Control, action: ResetFontSize                }
    - { key: Equals,   mods: Control, action: IncreaseFontSize             }
    - { key: Subtract, mods: Control, action: DecreaseFontSize             }
    - { key: Home,                    chars: "\x1bOH",   mode: AppCursor   }
    - { key: Home,                    chars: "\x1b[H",   mode: ~AppCursor  }
    - { key: End,                     chars: "\x1bOF",   mode: AppCursor   }
    - { key: End,                     chars: "\x1b[F",   mode: ~AppCursor  }
    - { key: PageUp,   mods: Shift,   chars: "\x1b[5;2~"                   }
    - { key: PageUp,   mods: Control, chars: "\x1b[5;5~"                   }
    - { key: PageUp,                  chars: "\x1b[5~"                     }
    - { key: PageDown, mods: Shift,   chars: "\x1b[6;2~"                   }
    - { key: PageDown, mods: Control, chars: "\x1b[6;5~"                   }
    - { key: PageDown,                chars: "\x1b[6~"                     }
    - { key: Tab,      mods: Shift,   chars: "\x1b[Z"                      }
    - { key: Back,                    chars: "\x7f"                        }
    - { key: Back,     mods: Alt,     chars: "\x1b\x7f"                    }
    - { key: Insert,                  chars: "\x1b[2~"                     }
    - { key: Delete,                  chars: "\x1b[3~"                     }
    - { key: Left,     mods: Shift,   chars: "\x1b[1;2D"                   }
    - { key: Left,     mods: Control, chars: "\x1b[1;5D"                   }
    - { key: Left,     mods: Alt,     chars: "\x1b[1;3D"                   }
    - { key: Left,                    chars: "\x1b[D",   mode: ~AppCursor  }
    - { key: Left,                    chars: "\x1bOD",   mode: AppCursor   }
    - { key: Right,    mods: Shift,   chars: "\x1b[1;2C"                   }
    - { key: Right,    mods: Control, chars: "\x1b[1;5C"                   }
    - { key: Right,    mods: Alt,     chars: "\x1b[1;3C"                   }
    - { key: Right,                   chars: "\x1b[C",   mode: ~AppCursor  }
    - { key: Right,                   chars: "\x1bOC",   mode: AppCursor   }
    - { key: Up,       mods: Shift,   chars: "\x1b[1;2A"                   }
    - { key: Up,       mods: Control, chars: "\x1b[1;5A"                   }
    - { key: Up,       mods: Alt,     chars: "\x1b[1;3A"                   }
    - { key: Up,                      chars: "\x1b[A",   mode: ~AppCursor  }
    - { key: Up,                      chars: "\x1bOA",   mode: AppCursor   }
    - { key: Down,     mods: Shift,   chars: "\x1b[1;2B"                   }
    - { key: Down,     mods: Control, chars: "\x1b[1;5B"                   }
    - { key: Down,     mods: Alt,     chars: "\x1b[1;3B"                   }
    - { key: Down,                    chars: "\x1b[B",   mode: ~AppCursor  }
    - { key: Down,                    chars: "\x1bOB",   mode: AppCursor   }
    - { key: F1,                      chars: "\x1bOP"                      }
    - { key: F2,                      chars: "\x1bOQ"                      }
    - { key: F3,                      chars: "\x1bOR"                      }
    - { key: F4,                      chars: "\x1bOS"                      }
    - { key: F5,                      chars: "\x1b[15~"                    }
    - { key: F6,                      chars: "\x1b[17~"                    }
    - { key: F7,                      chars: "\x1b[18~"                    }
    - { key: F8,                      chars: "\x1b[19~"                    }
    - { key: F9,                      chars: "\x1b[20~"                    }
    - { key: F10,                     chars: "\x1b[21~"                    }
    - { key: F11,                     chars: "\x1b[23~"                    }
    - { key: F12,                     chars: "\x1b[24~"                    }
    - { key: F1,       mods: Shift,   chars: "\x1b[1;2P"                   }
    - { key: F2,       mods: Shift,   chars: "\x1b[1;2Q"                   }
    - { key: F3,       mods: Shift,   chars: "\x1b[1;2R"                   }
    - { key: F4,       mods: Shift,   chars: "\x1b[1;2S"                   }
    - { key: F5,       mods: Shift,   chars: "\x1b[15;2~"                  }
    - { key: F6,       mods: Shift,   chars: "\x1b[17;2~"                  }
    - { key: F7,       mods: Shift,   chars: "\x1b[18;2~"                  }
    - { key: F8,       mods: Shift,   chars: "\x1b[19;2~"                  }
    - { key: F9,       mods: Shift,   chars: "\x1b[20;2~"                  }
    - { key: F10,      mods: Shift,   chars: "\x1b[21;2~"                  }
    - { key: F11,      mods: Shift,   chars: "\x1b[23;2~"                  }
    - { key: F12,      mods: Shift,   chars: "\x1b[24;2~"                  }
    - { key: F1,       mods: Control, chars: "\x1b[1;5P"                   }
    - { key: F2,       mods: Control, chars: "\x1b[1;5Q"                   }
    - { key: F3,       mods: Control, chars: "\x1b[1;5R"                   }
    - { key: F4,       mods: Control, chars: "\x1b[1;5S"                   }
    - { key: F5,       mods: Control, chars: "\x1b[15;5~"                  }
    - { key: F6,       mods: Control, chars: "\x1b[17;5~"                  }
    - { key: F7,       mods: Control, chars: "\x1b[18;5~"                  }
    - { key: F8,       mods: Control, chars: "\x1b[19;5~"                  }
    - { key: F9,       mods: Control, chars: "\x1b[20;5~"                  }
    - { key: F10,      mods: Control, chars: "\x1b[21;5~"                  }
    - { key: F11,      mods: Control, chars: "\x1b[23;5~"                  }
    - { key: F12,      mods: Control, chars: "\x1b[24;5~"                  }
    - { key: F1,       mods: Alt,     chars: "\x1b[1;6P"                   }
    - { key: F2,       mods: Alt,     chars: "\x1b[1;6Q"                   }
    - { key: F3,       mods: Alt,     chars: "\x1b[1;6R"                   }
    - { key: F4,       mods: Alt,     chars: "\x1b[1;6S"                   }
    - { key: F5,       mods: Alt,     chars: "\x1b[15;6~"                  }
    - { key: F6,       mods: Alt,     chars: "\x1b[17;6~"                  }
    - { key: F7,       mods: Alt,     chars: "\x1b[18;6~"                  }
    - { key: F8,       mods: Alt,     chars: "\x1b[19;6~"                  }
    - { key: F9,       mods: Alt,     chars: "\x1b[20;6~"                  }
    - { key: F10,      mods: Alt,     chars: "\x1b[21;6~"                  }
    - { key: F11,      mods: Alt,     chars: "\x1b[23;6~"                  }
    - { key: F12,      mods: Alt,     chars: "\x1b[24;6~"                  }
    - { key: F1,       mods: Super,   chars: "\x1b[1;3P"                   }
    - { key: F2,       mods: Super,   chars: "\x1b[1;3Q"                   }
    - { key: F3,       mods: Super,   chars: "\x1b[1;3R"                   }
    - { key: F4,       mods: Super,   chars: "\x1b[1;3S"                   }
    - { key: F5,       mods: Super,   chars: "\x1b[15;3~"                  }
    - { key: F6,       mods: Super,   chars: "\x1b[17;3~"                  }
    - { key: F7,       mods: Super,   chars: "\x1b[18;3~"                  }
    - { key: F8,       mods: Super,   chars: "\x1b[19;3~"                  }
    - { key: F9,       mods: Super,   chars: "\x1b[20;3~"                  }
    - { key: F10,      mods: Super,   chars: "\x1b[21;3~"                  }
    - { key: F11,      mods: Super,   chars: "\x1b[23;3~"                  }
    - { key: F12,      mods: Super,   chars: "\x1b[24;3~"                  }

alacritty-desktop: |
  [Desktop Entry]
  Encoding=UTF-8
  Name=Alacritty
  Exec=sh -c "env WAYLAND_DISPLAY= alacritty"
  Icon=utilities-terminal
  Type=Application
  Categories=Development;
