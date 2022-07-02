call plug#begin()

" Airline
Plug 'joshdick/onedark.vim'

" Colorscheme
Plug 'arzg/vim-colors-xcode'
Plug 'gantoreno/vim-gabriel'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" File browsing
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdtree'

" Language
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

" Tools
Plug 'tomtom/tcomment_vim'
Plug 'voldikss/vim-floaterm'

" Formatting
Plug 'ruby-formatter/rufo-vim'
Plug 'prettier/vim-prettier', { 
  \ 'do': 'yarn install',
  \ 'for': [
  \   'css',
  \   'graphql',
  \   'html',
  \   'javascript', 
  \   'json',
  \   'markdown',
  \   'scss',
  \   'typescript',
  \   'yaml',
  \   ],
  \ }

call plug#end()

colorscheme xcodewwdc

set nocompatible
set nohls
set smartindent
set splitbelow
set splitright
set number
set noswapfile
set cursorline
set termguicolors

set t_Co=256
set background=dark
set backspace=indent,eol,start
set laststatus=0
set nuw=5
set showtabline=1
set signcolumn=number
set so=15
set softtabstop=2
set tabstop=2
set cmdheight=0

set mouse+=a
set path+=**

let $VIM=1

let g:rufo_auto_formatting = 1

let g:mapleader=' '

let g:ctrlp_map = '<leader>ff'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](build|node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  \ 'file': '\v\.(dll|min.js|min.css|jpg|png|mp4)$'
  \ }

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

let g:prettier#autoformat = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0

let g:floaterm_shell = 'NEOVIM=1 '.&shell
let g:floaterm_height = 0.25
let g:floaterm_autoclose = 1
let g:floaterm_wintype = 'split'
let g:floaterm_position = 'botright'
let g:floaterm_keymap_toggle = '<leader>tt'

hi VertSplit guibg=none guifg=#383b44
hi Comment guifg=#61a858

nmap <silent><leader>nn :NerdTree<cr>
nmap <silent><leader>ss :SynStack<cr>

nmap <silent><leader><up> :tabnew<cr>
nmap <silent><leader><left> :tabprev<cr>
nmap <silent><leader><right> :tabnext<cr>
nmap <silent><leader><down> :tabclose<cr>

nmap <silent><leader>cc :TComment<cr>
vmap <silent><leader>cc :TComment<cr>

inoremap <c-space> <c-x><c-p>

nnoremap <c-h> <c-w><left>
nnoremap <c-j> <c-w><down>
nnoremap <c-k> <c-w><up>
nnoremap <c-l> <c-w><right>

tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l

autocmd FileType nerdtree setlocal nocursorline

autocmd FileType floaterm call FloatermSettings()

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

autocmd BufWritePre *.js,*.html,*.ts,*.json,*.jsx,*.tsx PrettierAsync

autocmd FileType c setl ofu=ccomplete#CompleteCpp
autocmd FileType css setl ofu=csscomplete#CompleteCSS
autocmd FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
autocmd FileType php setl ofu=phpcomplete#CompletePHP
autocmd FileType ruby,eruby setl ofu=rubycomplete#Complete

autocmd BufNewFile,BufRead * call s:DetectShebang()
autocmd BufNewFile,BufRead *.zsh-theme set filetype=zsh

autocmd VimLeave * call CloseTerminal()

command -nargs=0 NerdTree :call NerdTree()
command -nargs=0 SynStack :call SynStack()

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

function! NerdTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif

  silent NERDTreeMirror
endfunction

function! Terminal() abort
	term ++rows=10
endfunction

function! CloseTerminal() abort
  let pane_count = system("workspace count")

  if pane_count > 1
     silent !workspace down 2> /dev/null
  endif
endfunction

function SynStack()
  if !exists("*synstack")
    return
  endif

  let groups = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

  echo groups
endfunction

fun! s:DetectShebang()
  if getline(1) == '#!/bin/sh'
    set ft=zsh
  endif
endfun

function FloatermSettings() abort
  setlocal nonumber
  setlocal nocursorline
  setlocal norelativenumber

  setlocal signcolumn=no
endfunction

augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
