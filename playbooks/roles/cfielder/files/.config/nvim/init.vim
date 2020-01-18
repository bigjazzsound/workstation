" Testing a couple of options available via the lua api.
lua <<EOF
local api = vim.api
local home = os.getenv("HOME")
local DEFAULT_KEYMAP = { noremap = true, silent = true }
local set_option = api.nvim_set_option
local set_keymap = api.nvim_set_keymap

api.nvim_win_set_option(0, 'number', true)
set_option(
  'statusline',
  '[%n] %f%h%w%m%r  %{fugitive#head()} %{StatusDiagnostic()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P '
)

api.nvim_command("command! Vimrc :edit $MYVIMRC")
api.nvim_command("autocmd! VimResized * :wincmd =")

set_option('syntax', 'on')
set_option('termguicolors', true)
set_option('inccommand', 'nosplit')
set_option('splitbelow', true)
set_option('splitright', true)
set_option('cursorline', true)
set_option('tags', 'tags')
set_option('winblend', 5)
set_option('laststatus', 2)

set_keymap('i', 'jk', '<Esc>', DEFAULT_KEYMAP)
set_keymap('i', '<Esc>', '', DEFAULT_KEYMAP)

-- split navigation
set_keymap('n', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
set_keymap('n', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
set_keymap('n', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
set_keymap('n', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

-- settings for undofiles
set_option('undofile', false)
set_option('undodir', home .. '/.vim/undo/')
set_option('backupdir', home .. '/.vim/backup/')
set_option('directory', home .. '/.vim/swp/')

-- settings for search
set_option('hlsearch', true)
set_option('incsearch', true)

-- settings for tabs
set_option('expandtab', true)
set_option('autoindent', true)
set_option('smarttab', true)

set_option('listchars', 'tab:..,trail:-,extends:>,precedes:<,nbsp:~')

-- 80 character color difference
api.nvim_win_set_option(0, 'colorcolumn', '80')
api.nvim_command('highlight ColorColumn ctermbg=DarkBlue')

-- shortcuts with map leader
api.nvim_command('let mapleader=" "')
set_keymap('n', '<leader>/', ':nohls <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>w', ':w <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bd', ':bd <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bn', ':bn <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bp', ':bp <enter>', DEFAULT_KEYMAP)

-- Plugins
local autoload_plug_path = api.nvim_eval("stdpath('config')") .. '/site/autoload/plug.vim'
local plug_file = io.open(autoload_plug_path , "r")
if plug_file == nil then
  os.execute('curl -fLo ' .. autoload_plug_path .. ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  api.nvim_command('autocmd VimEnter * PlugInstall --sync')
  api.nvim_command('source $MYVIMRC')
else
  local plugins = {
    "'christoomey/vim-tmux-navigator'",
    "'editorconfig/editorconfig-vim'",
    "'enricobacis/paste.vim'",
    "'hashivim/vim-hashicorp-tools'",
    "'herrbischoff/cobalt2.vim'",
    "'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }",
    "'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }",
    "'junegunn/fzf.vim'",
    "'junegunn/goyo.vim', { 'for': 'markdown' }",
    "'junegunn/vim-easy-align'",
    "'justinmk/vim-dirvish'",
    "'justinmk/vim-sneak'",
    "'mhinz/vim-signify'",
    "'mhinz/vim-startify'",
    "'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }",
    "'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }",
    "'sheerun/vim-polyglot'",
    "'tpope/vim-commentary'",
    "'tpope/vim-dispatch'",
    "'tpope/vim-eunuch'",
    "'tpope/vim-fugitive'",
    "'tpope/vim-obsession'",
    "'tpope/vim-repeat'",
    "'tpope/vim-surround'",
  }
  api.nvim_command("call plug#begin('" .. home .. "/.vim/plugged')")
  for index, value in ipairs(plugins) do api.nvim_command("Plug " .. value) end
  api.nvim_command("call plug#end()")
end

api.nvim_command('colorscheme cobalt2')

-- vim-signify settings
vim.g.signify_sign_change = '~'

-- vim-sneak
vim.g['sneak#label'] = 1

-- fugitive git bindings
set_keymap('n', '<leader>ga', ':Git add %:p<CR><CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gs', ':Gstatus<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gc', ':Gcommit -v -q<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gt', ':Gcommit -v -q %:p<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gd', ':Gdiff<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>ge', ':Gedit<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gr', ':Gread<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gw', ':Gwrite<CR><CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gp', ':Ggrep<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gm', ':Gmove<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gb', ':Gblame!<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>go', ':Git checkout<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gps', ':Dispatch! git push<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gpl', ':Dispatch! git pull<CR>', DEFAULT_KEYMAP)

-- editorconfig
vim.g['EditorConfig_exclude_patterns'] = { 'fugitive://.\\*' }

-- dispatch settings
set_keymap('n', '<F3>', ':Dispatch<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<F4>', ':Start<CR>', DEFAULT_KEYMAP)

-- FZF
set_keymap('n', '<C-p>', ':FZF<cr>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>f', ':FZF <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>r', ':Rg <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>b', ':Buffers <enter>', DEFAULT_KEYMAP)

-- Terminal buffer options for fzf
api.nvim_command("autocmd! FileType fzf set noshowmode noruler nonu signcolumn=no")
api.nvim_command("let $FZF_DEFAULT_OPTS .= ' --layout=reverse -m --border'")

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

vim.g['fzf_layout'] = { window = 'lua NavigationFloatingWin()' }
EOF

" EVERYTHING ELSE here is COC related, which might go after nvim lsp hits

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
