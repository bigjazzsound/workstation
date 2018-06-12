vimrc: |
  set nu
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
  Plug 'sealeg/vim-kickstart'
  Plug 'junegunn/goyo.vim'
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

  " settings for editing md files
  autocmd BufNewFile,BufRead *.md set filetype=markdown textwidth=0

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
  alias sudo='sudo -E '
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
#
# weechat -- weechat.conf
#
# WARNING: It is NOT recommended to edit this file by hand,
# especially if WeeChat is running.
#
# Use /set or similar command to change settings in WeeChat.
#
# For more info, see: https://weechat.org/doc/quickstart
#

weechat: |
  [debug]

  [startup]
  command_after_plugins = ""
  command_before_plugins = ""
  display_logo = on
  display_version = on
  sys_rlimit = ""

  [look]
  align_end_of_lines = message
  align_multiline_words = on
  bar_more_down = "++"
  bar_more_left = "<<"
  bar_more_right = ">>"
  bar_more_up = "--"
  bare_display_exit_on_input = on
  bare_display_time_format = "%H:%M"
  buffer_auto_renumber = on
  buffer_notify_default = all
  buffer_position = end
  buffer_search_case_sensitive = off
  buffer_search_force_default = off
  buffer_search_regex = off
  buffer_search_where = prefix_message
  buffer_time_format = "%H:%M:%S"
  color_basic_force_bold = off
  color_inactive_buffer = on
  color_inactive_message = on
  color_inactive_prefix = on
  color_inactive_prefix_buffer = on
  color_inactive_time = off
  color_inactive_window = on
  color_nick_offline = off
  color_pairs_auto_reset = 5
  color_real_white = off
  command_chars = ""
  command_incomplete = off
  confirm_quit = off
  confirm_upgrade = off
  day_change = on
  day_change_message_1date = "-- %a, %d %b %Y --"
  day_change_message_2dates = "-- %%a, %%d %%b %%Y (%a, %d %b %Y) --"
  eat_newline_glitch = off
  emphasized_attributes = ""
  highlight = ""
  highlight_regex = ""
  highlight_tags = ""
  hotlist_add_conditions = "${away} || ${buffer.num_displayed} == 0"
  hotlist_buffer_separator = ", "
  hotlist_count_max = 2
  hotlist_count_min_msg = 2
  hotlist_names_count = 3
  hotlist_names_length = 0
  hotlist_names_level = 12
  hotlist_names_merged_buffers = off
  hotlist_prefix = "H: "
  hotlist_remove = merged
  hotlist_short_names = on
  hotlist_sort = group_time_asc
  hotlist_suffix = ""
  hotlist_unique_numbers = on
  input_cursor_scroll = 20
  input_share = none
  input_share_overwrite = off
  input_undo_max = 32
  item_away_message = on
  item_buffer_filter = "*"
  item_buffer_zoom = "!"
  item_mouse_status = "M"
  item_time_format = "%H:%M"
  jump_current_to_previous_buffer = on
  jump_previous_buffer_when_closing = on
  jump_smart_back_to_buffer = on
  key_bind_safe = on
  key_grab_delay = 800
  mouse = off
  mouse_timer_delay = 100
  nick_color_force = ""
  nick_color_hash = djb2
  nick_color_stop_chars = "_|["
  nick_prefix = ""
  nick_suffix = ""
  paste_auto_add_newline = on
  paste_bracketed = on
  paste_bracketed_timer_delay = 10
  paste_max_lines = 1
  prefix_action = " *"
  prefix_align = right
  prefix_align_max = 0
  prefix_align_min = 0
  prefix_align_more = "+"
  prefix_align_more_after = on
  prefix_buffer_align = right
  prefix_buffer_align_max = 0
  prefix_buffer_align_more = "+"
  prefix_buffer_align_more_after = on
  prefix_error = "=!="
  prefix_join = "-->"
  prefix_network = "--"
  prefix_quit = "<--"
  prefix_same_nick = ""
  prefix_suffix = "|"
  quote_nick_prefix = "<"
  quote_nick_suffix = ">"
  quote_time_format = "%H:%M:%S"
  read_marker = line
  read_marker_always_show = off
  read_marker_string = "- "
  save_config_on_exit = on
  save_config_with_fsync = off
  save_layout_on_exit = none
  scroll_amount = 3
  scroll_bottom_after_switch = off
  scroll_page_percent = 100
  search_text_not_found_alert = on
  separator_horizontal = "-"
  separator_vertical = ""
  tab_width = 1
  time_format = "%a, %d %b %Y %T"
  window_auto_zoom = off
  window_separator_horizontal = on
  window_separator_vertical = on
  window_title = "WeeChat ${info:version}"
  word_chars_highlight = "!\u00A0,-,_,|,alnum"
  word_chars_input = "!\u00A0,-,_,|,alnum"

  [palette]

  [color]
  bar_more = lightmagenta
  chat = default
  chat_bg = default
  chat_buffer = white
  chat_channel = white
  chat_day_change = cyan
  chat_delimiters = green
  chat_highlight = yellow
  chat_highlight_bg = magenta
  chat_host = cyan
  chat_inactive_buffer = default
  chat_inactive_window = default
  chat_nick = lightcyan
  chat_nick_colors = "cyan,magenta,green,brown,lightblue,default,lightcyan,lightmagenta,lightgreen,blue"
  chat_nick_offline = default
  chat_nick_offline_highlight = default
  chat_nick_offline_highlight_bg = blue
  chat_nick_other = cyan
  chat_nick_prefix = green
  chat_nick_self = white
  chat_nick_suffix = green
  chat_prefix_action = white
  chat_prefix_buffer = brown
  chat_prefix_buffer_inactive_buffer = default
  chat_prefix_error = yellow
  chat_prefix_join = lightgreen
  chat_prefix_more = lightmagenta
  chat_prefix_network = magenta
  chat_prefix_quit = lightred
  chat_prefix_suffix = green
  chat_read_marker = magenta
  chat_read_marker_bg = default
  chat_server = brown
  chat_tags = red
  chat_text_found = yellow
  chat_text_found_bg = lightmagenta
  chat_time = default
  chat_time_delimiters = brown
  chat_value = cyan
  chat_value_null = blue
  emphasized = yellow
  emphasized_bg = magenta
  input_actions = lightgreen
  input_text_not_found = red
  item_away = yellow
  nicklist_away = cyan
  nicklist_group = green
  separator = blue
  status_count_highlight = magenta
  status_count_msg = brown
  status_count_other = default
  status_count_private = green
  status_data_highlight = lightmagenta
  status_data_msg = yellow
  status_data_other = default
  status_data_private = lightgreen
  status_filter = green
  status_more = yellow
  status_mouse = green
  status_name = white
  status_name_ssl = lightgreen
  status_nicklist_count = default
  status_number = yellow
  status_time = default

  [completion]
  base_word_until_cursor = on
  command_inline = on
  default_template = "%(nicks)|%(irc_channels)"
  nick_add_space = on
  nick_case_sensitive = off
  nick_completer = ":"
  nick_first_only = off
  nick_ignore_chars = "[]`_-^"
  partial_completion_alert = on
  partial_completion_command = off
  partial_completion_command_arg = off
  partial_completion_count = on
  partial_completion_other = off

  [history]
  display_default = 5
  max_buffer_lines_minutes = 0
  max_buffer_lines_number = 4096
  max_commands = 100
  max_visited_buffers = 50

  [proxy]

  [network]
  connection_timeout = 60
  gnutls_ca_file = "/etc/pki/tls/certs/ca-bundle.crt"
  gnutls_handshake_timeout = 30
  proxy_curl = ""

  [plugin]
  autoload = "*"
  debug = off
  extension = ".so,.dll"
  path = "%h/plugins"
  save_config_on_unload = on

  [bar]
  buffers.color_bg = default
  buffers.color_delim = default
  buffers.color_fg = default
  buffers.conditions = ""
  buffers.filling_left_right = vertical
  buffers.filling_top_bottom = columns_vertical
  buffers.hidden = on
  buffers.items = "buffers"
  buffers.position = left
  buffers.priority = 0
  buffers.separator = on
  buffers.size = 0
  buffers.size_max = 0
  buffers.type = root
  buflist.color_bg = default
  buflist.color_delim = default
  buflist.color_fg = default
  buflist.conditions = ""
  buflist.filling_left_right = vertical
  buflist.filling_top_bottom = columns_vertical
  buflist.hidden = off
  buflist.items = "buflist"
  buflist.position = left
  buflist.priority = 0
  buflist.separator = on
  buflist.size = 0
  buflist.size_max = 0
  buflist.type = root
  fset.color_bg = default
  fset.color_delim = cyan
  fset.color_fg = default
  fset.conditions = "${buffer.full_name} == fset.fset"
  fset.filling_left_right = vertical
  fset.filling_top_bottom = horizontal
  fset.hidden = off
  fset.items = "fset"
  fset.position = top
  fset.priority = 0
  fset.separator = on
  fset.size = 3
  fset.size_max = 3
  fset.type = window
  input.color_bg = default
  input.color_delim = cyan
  input.color_fg = default
  input.conditions = ""
  input.filling_left_right = vertical
  input.filling_top_bottom = horizontal
  input.hidden = off
  input.items = "[input_prompt]+(away),[input_search],[input_paste],input_text"
  input.position = bottom
  input.priority = 1000
  input.separator = off
  input.size = 1
  input.size_max = 0
  input.type = window
  isetbar.color_bg = default
  isetbar.color_delim = cyan
  isetbar.color_fg = default
  isetbar.conditions = ""
  isetbar.filling_left_right = vertical
  isetbar.filling_top_bottom = horizontal
  isetbar.hidden = on
  isetbar.items = "isetbar_help"
  isetbar.position = top
  isetbar.priority = 0
  isetbar.separator = on
  isetbar.size = 3
  isetbar.size_max = 3
  isetbar.type = window
  nicklist.color_bg = default
  nicklist.color_delim = cyan
  nicklist.color_fg = default
  nicklist.conditions = "${nicklist}"
  nicklist.filling_left_right = vertical
  nicklist.filling_top_bottom = columns_vertical
  nicklist.hidden = off
  nicklist.items = "buffer_nicklist"
  nicklist.position = right
  nicklist.priority = 200
  nicklist.separator = on
  nicklist.size = 0
  nicklist.size_max = 0
  nicklist.type = window
  status.color_bg = blue
  status.color_delim = cyan
  status.color_fg = default
  status.conditions = ""
  status.filling_left_right = vertical
  status.filling_top_bottom = horizontal
  status.hidden = off
  status.items = "[time],[buffer_last_number],[buffer_plugin],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,scroll,[lag],[hotlist],completion"
  status.position = bottom
  status.priority = 500
  status.separator = off
  status.size = 1
  status.size_max = 0
  status.type = window
  title.color_bg = blue
  title.color_delim = cyan
  title.color_fg = default
  title.conditions = ""
  title.filling_left_right = vertical
  title.filling_top_bottom = horizontal
  title.hidden = off
  title.items = "buffer_title"
  title.position = top
  title.priority = 500
  title.separator = off
  title.size = 1
  title.size_max = 0
  title.type = window

  [layout]

  [notify]

  [filter]

  [key]
  ctrl-? = "/input delete_previous_char"
  ctrl-A = "/input move_beginning_of_line"
  ctrl-B = "/input move_previous_char"
  ctrl-C_ = "/input insert \x1F"
  ctrl-Cb = "/input insert \x02"
  ctrl-Cc = "/input insert \x03"
  ctrl-Ci = "/input insert \x1D"
  ctrl-Co = "/input insert \x0F"
  ctrl-Cv = "/input insert \x16"
  ctrl-D = "/input delete_next_char"
  ctrl-E = "/input move_end_of_line"
  ctrl-F = "/input move_next_char"
  ctrl-H = "/input delete_previous_char"
  ctrl-I = "/input complete_next"
  ctrl-J = "/input return"
  ctrl-K = "/input delete_end_of_line"
  ctrl-L = "/window refresh"
  ctrl-M = "/input return"
  ctrl-N = "/buffer +1"
  ctrl-P = "/buffer -1"
  ctrl-R = "/input search_text_here"
  ctrl-Sctrl-U = "/input set_unread"
  ctrl-T = "/input transpose_chars"
  ctrl-U = "/input delete_beginning_of_line"
  ctrl-W = "/input delete_previous_word"
  ctrl-X = "/input switch_active_buffer"
  ctrl-Y = "/input clipboard_paste"
  meta-meta-OP = "/bar scroll buflist * b"
  meta-meta-OQ = "/bar scroll buflist * e"
  meta-meta2-1~ = "/window scroll_top"
  meta-meta2-23~ = "/bar scroll nicklist * b"
  meta-meta2-24~ = "/bar scroll nicklist * e"
  meta-meta2-4~ = "/window scroll_bottom"
  meta-meta2-5~ = "/window scroll_up"
  meta-meta2-6~ = "/window scroll_down"
  meta-meta2-7~ = "/window scroll_top"
  meta-meta2-8~ = "/window scroll_bottom"
  meta-meta2-A = "/buffer -1"
  meta-meta2-B = "/buffer +1"
  meta-meta2-C = "/buffer +1"
  meta-meta2-D = "/buffer -1"
  meta-- = "/filter toggle @"
  meta-/ = "/input jump_last_buffer_displayed"
  meta-0 = "/buffer *10"
  meta-1 = "/buffer *1"
  meta-2 = "/buffer *2"
  meta-3 = "/buffer *3"
  meta-4 = "/buffer *4"
  meta-5 = "/buffer *5"
  meta-6 = "/buffer *6"
  meta-7 = "/buffer *7"
  meta-8 = "/buffer *8"
  meta-9 = "/buffer *9"
  meta-< = "/input jump_previously_visited_buffer"
  meta-= = "/filter toggle"
  meta-> = "/input jump_next_visited_buffer"
  meta-OA = "/input history_global_previous"
  meta-OB = "/input history_global_next"
  meta-OC = "/input move_next_word"
  meta-OD = "/input move_previous_word"
  meta-OF = "/input move_end_of_line"
  meta-OH = "/input move_beginning_of_line"
  meta-OP = "/bar scroll buflist * -100%"
  meta-OQ = "/bar scroll buflist * +100%"
  meta-Oa = "/input history_global_previous"
  meta-Ob = "/input history_global_next"
  meta-Oc = "/input move_next_word"
  meta-Od = "/input move_previous_word"
  meta2-15~ = "/buffer -1"
  meta2-17~ = "/buffer +1"
  meta2-18~ = "/window -1"
  meta2-19~ = "/window +1"
  meta2-1;3A = "/buffer -1"
  meta2-1;3B = "/buffer +1"
  meta2-1;3C = "/buffer +1"
  meta2-1;3D = "/buffer -1"
  meta2-1;3F = "/window scroll_bottom"
  meta2-1;3H = "/window scroll_top"
  meta2-1;5A = "/input history_global_previous"
  meta2-1;5B = "/input history_global_next"
  meta2-1;5C = "/input move_next_word"
  meta2-1;5D = "/input move_previous_word"
  meta2-1~ = "/input move_beginning_of_line"
  meta2-200~ = "/input paste_start"
  meta2-201~ = "/input paste_stop"
  meta2-20~ = "/bar scroll title * -30%"
  meta2-21~ = "/bar scroll title * +30%"
  meta2-23;3~ = "/bar scroll nicklist * b"
  meta2-23~ = "/bar scroll nicklist * -100%"
  meta2-24;3~ = "/bar scroll nicklist * e"
  meta2-24~ = "/bar scroll nicklist * +100%"
  meta2-3~ = "/input delete_next_char"
  meta2-4~ = "/input move_end_of_line"
  meta2-5;3~ = "/window scroll_up"
  meta2-5~ = "/window page_up"
  meta2-6;3~ = "/window scroll_down"
  meta2-6~ = "/window page_down"
  meta2-7~ = "/input move_beginning_of_line"
  meta2-8~ = "/input move_end_of_line"
  meta2-A = "/input history_previous"
  meta2-B = "/input history_next"
  meta2-C = "/input move_next_char"
  meta2-D = "/input move_previous_char"
  meta2-F = "/input move_end_of_line"
  meta2-G = "/window page_down"
  meta2-H = "/input move_beginning_of_line"
  meta2-I = "/window page_up"
  meta2-Z = "/input complete_previous"
  meta2-[E = "/buffer -1"
  meta-_ = "/input redo"
  meta-a = "/input jump_smart"
  meta-b = "/input move_previous_word"
  meta-d = "/input delete_next_word"
  meta-f = "/input move_next_word"
  meta-h = "/input hotlist_clear"
  meta-jmeta-f = "/buffer -"
  meta-jmeta-l = "/buffer +"
  meta-jmeta-r = "/server raw"
  meta-jmeta-s = "/server jump"
  meta-j01 = "/buffer *1"
  meta-j02 = "/buffer *2"
  meta-j03 = "/buffer *3"
  meta-j04 = "/buffer *4"
  meta-j05 = "/buffer *5"
  meta-j06 = "/buffer *6"
  meta-j07 = "/buffer *7"
  meta-j08 = "/buffer *8"
  meta-j09 = "/buffer *9"
  meta-j10 = "/buffer *10"
  meta-j11 = "/buffer *11"
  meta-j12 = "/buffer *12"
  meta-j13 = "/buffer *13"
  meta-j14 = "/buffer *14"
  meta-j15 = "/buffer *15"
  meta-j16 = "/buffer *16"
  meta-j17 = "/buffer *17"
  meta-j18 = "/buffer *18"
  meta-j19 = "/buffer *19"
  meta-j20 = "/buffer *20"
  meta-j21 = "/buffer *21"
  meta-j22 = "/buffer *22"
  meta-j23 = "/buffer *23"
  meta-j24 = "/buffer *24"
  meta-j25 = "/buffer *25"
  meta-j26 = "/buffer *26"
  meta-j27 = "/buffer *27"
  meta-j28 = "/buffer *28"
  meta-j29 = "/buffer *29"
  meta-j30 = "/buffer *30"
  meta-j31 = "/buffer *31"
  meta-j32 = "/buffer *32"
  meta-j33 = "/buffer *33"
  meta-j34 = "/buffer *34"
  meta-j35 = "/buffer *35"
  meta-j36 = "/buffer *36"
  meta-j37 = "/buffer *37"
  meta-j38 = "/buffer *38"
  meta-j39 = "/buffer *39"
  meta-j40 = "/buffer *40"
  meta-j41 = "/buffer *41"
  meta-j42 = "/buffer *42"
  meta-j43 = "/buffer *43"
  meta-j44 = "/buffer *44"
  meta-j45 = "/buffer *45"
  meta-j46 = "/buffer *46"
  meta-j47 = "/buffer *47"
  meta-j48 = "/buffer *48"
  meta-j49 = "/buffer *49"
  meta-j50 = "/buffer *50"
  meta-j51 = "/buffer *51"
  meta-j52 = "/buffer *52"
  meta-j53 = "/buffer *53"
  meta-j54 = "/buffer *54"
  meta-j55 = "/buffer *55"
  meta-j56 = "/buffer *56"
  meta-j57 = "/buffer *57"
  meta-j58 = "/buffer *58"
  meta-j59 = "/buffer *59"
  meta-j60 = "/buffer *60"
  meta-j61 = "/buffer *61"
  meta-j62 = "/buffer *62"
  meta-j63 = "/buffer *63"
  meta-j64 = "/buffer *64"
  meta-j65 = "/buffer *65"
  meta-j66 = "/buffer *66"
  meta-j67 = "/buffer *67"
  meta-j68 = "/buffer *68"
  meta-j69 = "/buffer *69"
  meta-j70 = "/buffer *70"
  meta-j71 = "/buffer *71"
  meta-j72 = "/buffer *72"
  meta-j73 = "/buffer *73"
  meta-j74 = "/buffer *74"
  meta-j75 = "/buffer *75"
  meta-j76 = "/buffer *76"
  meta-j77 = "/buffer *77"
  meta-j78 = "/buffer *78"
  meta-j79 = "/buffer *79"
  meta-j80 = "/buffer *80"
  meta-j81 = "/buffer *81"
  meta-j82 = "/buffer *82"
  meta-j83 = "/buffer *83"
  meta-j84 = "/buffer *84"
  meta-j85 = "/buffer *85"
  meta-j86 = "/buffer *86"
  meta-j87 = "/buffer *87"
  meta-j88 = "/buffer *88"
  meta-j89 = "/buffer *89"
  meta-j90 = "/buffer *90"
  meta-j91 = "/buffer *91"
  meta-j92 = "/buffer *92"
  meta-j93 = "/buffer *93"
  meta-j94 = "/buffer *94"
  meta-j95 = "/buffer *95"
  meta-j96 = "/buffer *96"
  meta-j97 = "/buffer *97"
  meta-j98 = "/buffer *98"
  meta-j99 = "/buffer *99"
  meta-k = "/input grab_key_command"
  meta-l = "/window bare"
  meta-m = "/mute mouse toggle"
  meta-n = "/window scroll_next_highlight"
  meta-p = "/window scroll_previous_highlight"
  meta-r = "/input delete_line"
  meta-s = "/mute aspell toggle"
  meta-u = "/window scroll_unread"
  meta-wmeta-meta2-A = "/window up"
  meta-wmeta-meta2-B = "/window down"
  meta-wmeta-meta2-C = "/window right"
  meta-wmeta-meta2-D = "/window left"
  meta-wmeta2-1;3A = "/window up"
  meta-wmeta2-1;3B = "/window down"
  meta-wmeta2-1;3C = "/window right"
  meta-wmeta2-1;3D = "/window left"
  meta-wmeta-b = "/window balance"
  meta-wmeta-s = "/window swap"
  meta-x = "/input zoom_merged_buffer"
  meta-z = "/window zoom"
  ctrl-_ = "/input undo"

  [key_search]
  ctrl-I = "/input search_switch_where"
  ctrl-J = "/input search_stop_here"
  ctrl-M = "/input search_stop_here"
  ctrl-Q = "/input search_stop"
  ctrl-R = "/input search_switch_regex"
  meta2-A = "/input search_previous"
  meta2-B = "/input search_next"
  meta-c = "/input search_switch_case"

  [key_cursor]
  ctrl-J = "/cursor stop"
  ctrl-M = "/cursor stop"
  meta-meta2-A = "/cursor move area_up"
  meta-meta2-B = "/cursor move area_down"
  meta-meta2-C = "/cursor move area_right"
  meta-meta2-D = "/cursor move area_left"
  meta2-1;3A = "/cursor move area_up"
  meta2-1;3B = "/cursor move area_down"
  meta2-1;3C = "/cursor move area_right"
  meta2-1;3D = "/cursor move area_left"
  meta2-A = "/cursor move up"
  meta2-B = "/cursor move down"
  meta2-C = "/cursor move right"
  meta2-D = "/cursor move left"
  @item(buffer_nicklist):K = "/window ${_window_number};/kickban ${nick}"
  @item(buffer_nicklist):b = "/window ${_window_number};/ban ${nick}"
  @item(buffer_nicklist):k = "/window ${_window_number};/kick ${nick}"
  @item(buffer_nicklist):q = "/window ${_window_number};/query ${nick};/cursor stop"
  @item(buffer_nicklist):w = "/window ${_window_number};/whois ${nick}"
  @chat:Q = "hsignal:chat_quote_time_prefix_message;/cursor stop"
  @chat:m = "hsignal:chat_quote_message;/cursor stop"
  @chat:q = "hsignal:chat_quote_prefix_message;/cursor stop"

  [key_mouse]
  @bar(buffers):ctrl-wheeldown = "hsignal:buffers_mouse"
  @bar(buffers):ctrl-wheelup = "hsignal:buffers_mouse"
  @bar(buflist):ctrl-wheeldown = "hsignal:buflist_mouse"
  @bar(buflist):ctrl-wheelup = "hsignal:buflist_mouse"
  @bar(input):button2 = "/input grab_mouse_area"
  @bar(nicklist):button1-gesture-down = "/bar scroll nicklist ${_window_number} +100%"
  @bar(nicklist):button1-gesture-down-long = "/bar scroll nicklist ${_window_number} e"
  @bar(nicklist):button1-gesture-up = "/bar scroll nicklist ${_window_number} -100%"
  @bar(nicklist):button1-gesture-up-long = "/bar scroll nicklist ${_window_number} b"
  @chat(fset.fset):button1 = "/window ${_window_number};/fset -go ${_chat_line_y}"
  @chat(fset.fset):button2* = "hsignal:fset_mouse"
  @chat(fset.fset):wheeldown = "/fset -down 5"
  @chat(fset.fset):wheelup = "/fset -up 5"
  @chat(perl.iset):button1 = "hsignal:iset_mouse"
  @chat(perl.iset):button2* = "hsignal:iset_mouse"
  @chat(perl.iset):wheeldown = "/repeat 5 /iset **down"
  @chat(perl.iset):wheelup = "/repeat 5 /iset **up"
  @chat(script.scripts):button1 = "/window ${_window_number};/script go ${_chat_line_y}"
  @chat(script.scripts):button2 = "/window ${_window_number};/script go ${_chat_line_y};/script installremove -q ${script_name_with_extension}"
  @chat(script.scripts):wheeldown = "/script down 5"
  @chat(script.scripts):wheelup = "/script up 5"
  @item(buffer_nicklist):button1 = "/window ${_window_number};/query ${nick}"
  @item(buffer_nicklist):button1-gesture-left = "/window ${_window_number};/kick ${nick}"
  @item(buffer_nicklist):button1-gesture-left-long = "/window ${_window_number};/kickban ${nick}"
  @item(buffer_nicklist):button2 = "/window ${_window_number};/whois ${nick}"
  @item(buffer_nicklist):button2-gesture-left = "/window ${_window_number};/ban ${nick}"
  @item(buffers):button1* = "hsignal:buffers_mouse"
  @item(buffers):button2* = "hsignal:buffers_mouse"
  @item(buflist):button1* = "hsignal:buflist_mouse"
  @item(buflist):button2* = "hsignal:buflist_mouse"
  @item(buflist2):button1* = "hsignal:buflist_mouse"
  @item(buflist2):button2* = "hsignal:buflist_mouse"
  @item(buflist3):button1* = "hsignal:buflist_mouse"
  @item(buflist3):button2* = "hsignal:buflist_mouse"
  @bar:wheeldown = "/bar scroll ${_bar_name} ${_window_number} +20%"
  @bar:wheelup = "/bar scroll ${_bar_name} ${_window_number} -20%"
  @chat:button1 = "/window ${_window_number}"
  @chat:button1-gesture-left = "/window ${_window_number};/buffer -1"
  @chat:button1-gesture-left-long = "/window ${_window_number};/buffer 1"
  @chat:button1-gesture-right = "/window ${_window_number};/buffer +1"
  @chat:button1-gesture-right-long = "/window ${_window_number};/input jump_last_buffer"
  @chat:ctrl-wheeldown = "/window scroll_horiz -window ${_window_number} +10%"
  @chat:ctrl-wheelup = "/window scroll_horiz -window ${_window_number} -10%"
  @chat:wheeldown = "/window scroll_down -window ${_window_number}"
  @chat:wheelup = "/window scroll_up -window ${_window_number}"
  @*:button3 = "/cursor go ${_x},${_y}"
