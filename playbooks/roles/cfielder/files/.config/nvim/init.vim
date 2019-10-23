set nu
syntax on
set termguicolors
set mouse-=a
set inccommand=nosplit
set tags=tags
set cursorline
command! Vimrc :edit $MYVIMRC

" 80 character color difference
let &colorcolumn=join(range(80,999),",")
" highlight ColorColumn ctermbg=Black

" Lines for splitting
set splitbelow
set splitright

" automatically rebalance windows on vim resize
augroup auto_resize
    autocmd!
    autocmd VimResized * :wincmd =
augroup END

" Remaps
inoremap jk <Esc>
inoremap <Esc> <Nop>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" shortcuts with map leader
let mapleader=" "
nnoremap <leader>/ :nohls <enter>
nnoremap <leader>w :w <enter>
nnoremap <leader>W :%s/\s\+$//e <enter>
nnoremap <leader>n :set nu! <enter>
nnoremap <leader>l :set list! <enter>
nnoremap <leader>s :set spell!
nnoremap <leader>T :argadd `rg '.*role: (\w*).*' % -r '$1' --trim \\| xargs -i{} fd -tf . roles/{}/tasks` \| tab all <enter>
nnoremap <leader>bd :bd <enter>
nnoremap <leader>bn :bn <enter>
nnoremap <leader>bp :bp <enter>
if executable("clip.exe")
    nnoremap <leader>c :w !clip.exe <enter> <enter>
endif

" macros
let @j = 'a"{{  }}"4h'
let @c = 'i{code:bash}{code}jkki'

" settings for undo files
set undofile
set undodir=~/.vim/undo/
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

" settings for search
set hlsearch
set incsearch

" settings for tabs
set expandtab
set autoindent
set smarttab

" settings for listchars
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:~

"
" Plugins
"

" Download vim-plug if it is not already present
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync
  source $MYVIMRC
endif
unlet! autoload_plug_path

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'enricobacis/paste.vim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
Plug 'rbong/vim-crystalline'
Plug 'iCyMind/NeoSolarized'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'editorconfig/editorconfig-vim'
Plug 'pearofducks/ansible-vim', { 'for': 'yaml.ansible' }
call plug#end()

" colorscheme solarized
colorscheme NeoSolarized

" fugitive git bindings
nnoremap <leader>ga  :Git add %:p<CR><CR>
nnoremap <leader>gs  :Gstatus<CR>
nnoremap <leader>gc  :Gcommit -v -q<CR>
nnoremap <leader>gt  :Gcommit -v -q %:p<CR>
nnoremap <leader>gd  :Gdiff<CR>
nnoremap <leader>ge  :Gedit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR><CR>
nnoremap <leader>gl  :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp  :Ggrep<Space>
nnoremap <leader>gm  :Gmove<Space>
nnoremap <leader>gb  :Gblame!<CR>
nnoremap <leader>go  :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()} %{StatusDiagnostic()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}  %l/%L  %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
    let l:vimlabel = has("nvim") ? "NVIM" : "VIM"
    return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab#'
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'solarized'
set laststatus=2

" coc settings
let g:coc_global_extensions = [
\   'coc-emoji',
\   'coc-prettier',
\   'coc-json',
\   'coc-python',
\   'coc-yaml',
\   'coc-git',
\   'coc-vimlsp',
\   'coc-docker',
\]

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
map <F10> :Format<cr>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

set updatetime=300
set shortmess+=c
set signcolumn=yes
set pumheight=10

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" dispatch settings
nnoremap <F3> :Dispatch<CR>
nnoremap <F4> :Start<CR>

" vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim', 'help']

" Goyo
nnoremap <leader>g :Goyo<CR>
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

" Quit Vim if this is the only remaining buffer
function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" FZF
nnoremap <C-p> :FZF<cr>
nnoremap <leader>f :FZF <enter>
nnoremap <leader>r :Rg <enter>
nnoremap <leader>b :Buffers <enter>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" dynamic settings per host
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
