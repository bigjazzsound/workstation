" Testing a couple of options available via the lua api.
lua <<EOF
local api = vim.api

api.nvim_win_set_option(0, 'number', true)
api.nvim_set_option(
    'statusline',
    '[%n] %f%h%w%m%r  %{fugitive#head()} %{StatusDiagnostic()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P '
)

api.nvim_command("command! Vimrc :edit $MYVIMRC")
api.nvim_command("autocmd! VimResized * :wincmd =")

api.nvim_set_option('syntax', 'on')
api.nvim_set_option('termguicolors', true)
api.nvim_set_option('inccommand', 'nosplit')
api.nvim_set_option('splitbelow', true)
api.nvim_set_option('splitright', true)
api.nvim_set_option('cursorline', true)
api.nvim_set_option('tags', 'tags')
api.nvim_set_option('winblend', 5)
api.nvim_set_option('laststatus', 2)

api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = true})
api.nvim_set_keymap('i', '<Esc>', '', {noremap = true, silent = true})

-- split navigation
api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true, silent = true})

-- settings for undofiles
api.nvim_set_option('undofile', false)
api.nvim_set_option('undodir', '~/.vim/undo/')
api.nvim_set_option('backupdir', '~/.vim/backup/')
api.nvim_set_option('directory', '~/.vim/swp/')

-- settings for search
api.nvim_set_option('hlsearch', true)
api.nvim_set_option('incsearch', true)

-- settings for tabs
api.nvim_set_option('expandtab', true)
api.nvim_set_option('autoindent', true)
api.nvim_set_option('smarttab', true)

api.nvim_set_option('listchars', 'tab:..,trail:-,extends:>,precedes:<,nbsp:~')
EOF

" set nu
" syntax on
" set termguicolors
" set mouse-=a
" set inccommand=nosplit
" set tags=tags
" set cursorline
" set winblend=15
" command! Vimrc :edit $MYVIMRC

" 80 character color difference
" let &colorcolumn=join(range(80,999),",")
set colorcolumn=80
highlight ColorColumn ctermbg=DarkBlue

" Lines for splitting
" set splitbelow
" set splitright

" automatically rebalance windows on vim resize
" augroup auto_resize
"     autocmd!
"     autocmd VimResized * :wincmd =
" augroup END

" Remaps
" inoremap jk <Esc>
" inoremap <Esc> <Nop>

" split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

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
" set undofile
" set undodir=~/.vim/undo/
" set backupdir=~/.vim/backup/
" set directory=~/.vim/swp/

" settings for search
" set hlsearch
" set incsearch

" settings for tabs
" set expandtab
" set autoindent
" set smarttab

" settings for listchars
" set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:~

"
" Plugins
"

" Download vim-plug if it is not already present
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync
  source $MYVIMRC
endif
unlet! autoload_plug_path

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'enricobacis/paste.vim'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'herrbischoff/cobalt2.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
" Plug 'pearofducks/ansible-vim', { 'for': 'yaml.ansible' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

colorscheme cobalt2

" vim-signify settings
let g:signify_sign_change='~'

" vim-sneak
let g:sneak#label = 1

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
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" coc settings
let g:coc_global_extensions = [
\   'coc-docker',
\   'coc-emoji',
\   'coc-json',
\   'coc-prettier',
\   'coc-python',
\   'coc-vimlsp',
\   'coc-yaml',
\]

set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>ca :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ce :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>cc :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>co :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>cp :<C-u>CocListResume<CR>

" dispatch settings
nnoremap <F3> :Dispatch<CR>
nnoremap <F4> :Start<CR>

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

" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu signcolumn=no
let $FZF_DEFAULT_OPTS .= ' --layout=reverse -m --border'

" Testing floating fzf window
" if has('nvim') && exists('&winblend') && &termguicolors
"   set winblend=5

"   hi NormalFloat guibg=None
"   if exists('g:fzf_colors.bg')
"     call remove(g:fzf_colors, 'bg')
"   endif

"   if stridx($FZF_DEFAULT_OPTS, '--border') == -1
"     let $FZF_DEFAULT_OPTS .= ' --border --layout=reverse'
"   endif

"   function! FloatingFZF()
"     let width = float2nr(&columns * 0.8)
"     let height = float2nr(&lines * 0.6)
"     let opts = { 'relative': 'editor',
"                \ 'row': (&lines - height) / 2,
"                \ 'col': (&columns - width) / 2,
"                \ 'width': width,
"                \ 'height': height }

"     call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
"   endfunction

"   let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" endif

lua <<EOF
function NavigationFloatingWin()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- if the editor is big enough
  if (width > 150 or height > 35) then
    -- fzf's window height is 3/4 of the max height, but not more than 30
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
    local win_width

    -- if the width is small
    if (width < 150) then
      -- just subtract 8 from the editor's width
      win_width = math.ceil(width - 8)
    else
      -- use 90% of the editor's width
      win_width = math.ceil(width * 0.9)
    end

    -- settings for the fzf window
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2)
    }

    -- create a new floating window, centered in the editor
    local win = vim.api.nvim_open_win(buf, true, opts)
  end
end
EOF

let g:fzf_layout = { 'window': 'lua NavigationFloatingWin()' }
