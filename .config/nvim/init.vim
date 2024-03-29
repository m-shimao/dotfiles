let mapleader = "\<space>"
set shiftwidth=2
syntax=on
set showmode
set number
set tabstop=2
set incsearch
set clipboard=unnamed
set cursorline
highlight CursorLine ctermfg=Blue ctermbg=Green
set cursorcolumn
set autoindent
set expandtab
set autowrite
set laststatus=0
set list " 不可視文字を表示
"set foldmethod=indent

" TerminalでInsertスタート
augroup neovim-terminal
  au!
  au TermOpen * startinsert
augroup END

" Terminalでフォーカスを外す
tnoremap <space>jj <C-\><C-n>

" Plugins
abbr _sh #!/bin/bash
call plug#begin()

" file system explorer
Plug 'preservim/nerdtree'

" color schema
Plug 'ntk148v/vim-horizon'

" ファイルオープンを便利に
Plug 'https://github.com/Shougo/unite.vim.git'
Plug 'https://github.com/Shougo/neomru.vim.git'
Plug 'https://github.com/Shougo/neoyank.vim.git'

" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'

" インデント色付け
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" color schema
set termguicolors
colorscheme horizon
let g:lightline = { 'colorscheme': 'horizon' }

""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-N> :Unite buffer<CR>
" ファイル一覧
noremap <C-L> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
let g:unite_source_history_yank_enable =1
noremap <C-Y> :Unite history/yank<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'                                                                                              
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''

" インデント色付け
let g:indent_guides_enable_on_vim_startup = 1

