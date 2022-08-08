"*****************"
"      plugin     "
"*****************"

call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-rails'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'Quramy/tsuquyomi'
Plug 'gregsexton/MatchTag'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
call plug#end()

"""""" netrw """""
set nocompatible
filetype plugin on

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

set nofixendofline
set laststatus=2
set statusline=%F
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set number
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent
set nrformats-=octal

""""" netrw """""
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_preview   = 1

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
" デフォルトは<C-y>
"let g:user_emmet_leader_key=','

"""" tsuquyomi """"
autocmd FileType typescript nmap <buffer> <Leader>, : <C-u>echo tsuquyomi#hint()<CR>

"*****************"
"     commands    "
"*****************"
let mapleader = "\<Space>"
let maplocalleader="\<Space>"

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
nnoremap <silent><C-^> :tabe #<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>
nnoremap <Leader>i gt
nnoremap <Leader>j gT

cnoremap sv source ~/.vimrc<CR>
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
"ファイルを開いたままブランチを移動した時にファイルの中身を自動読み込みする
set autoread
"E363: パターンが 'maxmempattern' 以上のメモリを使用します を防ぐ
set mmp=5000
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
" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
  syntax on

  " PODバグ対策
  syn sync fromstart

  function! ActivateInvisibleIndicator()
    " 下の行の"　"は全角スペース
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
    syntax match InvisibleTab "\t" display containedin=ALL
    "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
  endfunction

  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif
