" Vim-Plugged configuration
call plug#begin($HOME . '/.local/share/nvim/plugged')

" Intelligence
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" General
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/calendar-vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Navigation and search
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'

" Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sheerun/vim-polyglot'

" HTML/CSS/JS
Plug 'mattn/emmet-vim'
Plug 'norcalli/nvim-colorizer.lua'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Testing
Plug 'christoomey/vim-tmux-runner'
Plug 'vim-test/vim-test'

" Plain text
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vimwiki/vimwiki'

" Haskell
Plug 'neovimhaskell/haskell-vim'

call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set termguicolors
lua require'colorizer'.setup()

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Theme for lightline
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
let g:lightline#bufferline#show_number=2

" Signify settings
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" rooter settings
let g:rooter_patterns = ['.git', 'Makefile', 'compile_commands.json', 'package.json']

" fzf settings
let g:fzf_preview_window = 'right:60%'
let g:rg_derive_root='true' " move to current root set by rooter

" VimWiki config
let g:vimwiki_list = [{'path': '~/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_listsym_rejected = '✗'
let g:vimwiki_use_calender=1

" Calendar config
let g:calendar_options = 'nornu'        " Draw calendar with proper width in split view
let g:calendar_monday=1                 " Start week on monday
let g:calendar_diary=$HOME.'wiki/diary' " Specify location for diary file


" Copy diary template when starting a new file in diary directory
autocmd BufNewFile */wiki/diary/[0-9]*.md :read ~/wiki/diary/templates/template.md

" Goyo and limelight
let g:goyo_width='95%'
let g:goyo_height='95%'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Which-key
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Vim-test config
let test#strategy = "vtr"
