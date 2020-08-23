"*****************"
"      plugin     "
"*****************"
call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-rails'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'Quramy/tsuquyomi'
call plug#end()

"*****************"
"      color      "
"*****************"
colorscheme iceberg
set cursorline
set hlsearch
hi Cursorline term=bold cterm=bold guibg=Grey40
hi Visual cterm=bold ctermbg=231
hi MatchParen ctermbg=69
hi Search ctermbg=195
hi link markdownError Normal

"*****************"
"      style      "
"*****************"
let g:netrw_banner = 0
set laststatus=2
set statusline=%F
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set number
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent
set nrformats-=octal

"""""" netrw """""
set nocompatible
filetype plugin on

""""" nerdtree """"""
let NERDTreeShowHidden=1
set encoding=UTF-8
map <C-e> :NERDTreeToggle<CR>

""""" emmet.vim """""
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'indentation' : '  ',
\  'html' : {
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\">\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n</body>\n"
\        ."</html>",
\    }
\  }
\}
"let mapleader = ','
"let g:user_emmet_leader_key=','

"""" tsuquyomi """"
autocmd FileType typescript nmap <buffer> <Leader>, : <C-u>echo tsuquyomi#hint()<CR>

"*****************"
"     commands    "
"*****************"
inoremap <silent> jj <ESC>
inoremap <silent><C-s> <ESC>:w<CR>
inoremap <silent><C-s><C-d> <ESC>:wq<CR>
inoremap <silent>qq <ESC>:q!<CR>
nnoremap <silent><C-k> :bnext<CR>
nnoremap <silent><C-j> :bprev<CR>
nnoremap <silent>qq :q!<CR>
nnoremap <silent><C-s> :w<CR>
nnoremap <silent><C-s><C-d> :wq<CR>
nnoremap <silent><C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent>j gj
nnoremap <silent>k gk
nnoremap <silent>gj j
nnoremap <silent>gk k
nnoremap <silent><Space><Space> a <Esc> 
"nnoremap <silent><C-z> :tabm -<CR>
"nnoremap <silent><C-x> :tabm +<CR>
"nnoremap <silent><C-r> :e<CR>
noremap <S-h> :
noremap <S-l> $
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""""" fzf vim """""
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

"*****************"
"      others     "
"*****************"
"swpファイルの置き場所を指定
set swapfile
set dir=~/tmp/vim
"ヤンクした内容を自動的にクリップボードに保存
set clipboard+=unnamed
" 自動的に隠しバッファにする
set hidden
" マウスクリックを有効にする
"set mouse=a
" マウスクリックを無効にする
set mouse=""
" 保存するコマンドラインの履歴数
set history=200
" アクティブなファイルの含まれているディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
