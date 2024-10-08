"if you install neovim, this file set to .config/nvim/ 
"if you want to change the rosed defaults. set those to bashrc [alias vim='nvim' export EDITOR='nvim']

"
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" leader key map
let mapleader = "\<Space>"

" yankした文字をclipboardへ
set clipboard=unnamed 

" 見た目系
" 行番号を表示
set number
" 右方向へタブを開く
set splitright
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
"set background=dark

" Tab系
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" tab to space for avoiding indantation error
set expandtab
retab 4
" インデントはスマートインデント
set smartindent

" InsertモードからNormalモードに戻るときに英字入力（USキーボード）に切り替え
if executable('ibus')
    autocmd InsertLeave * :silent !ibus engine xkb:us::eng
    " IMEのオンオフはCtrl+Spaceで手動制御
endif

"if executable('fcitx-remote')
"    " InsertモードからNormalモードに戻るときにIMEを無効化（英字入力に戻す）
"    autocmd InsertLeave * :silent !fcitx-remote -c
"    " IMEのオンオフは手動でCtrl+Spaceを使用
"endif

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"tmuxマウススクロール問題 
set mouse=a

"plugin do :PlugInstall
call plug#begin('~/.local/share/nvim/plugged')

Plug 'preservim/nerdtree' "file tree
Plug 'lewis6991/gitsigns.nvim' 
Plug 'windwp/nvim-autopairs' "auto bracket
Plug 'EdenEast/nightfox.nvim' "colorscheme 
Plug 'mhinz/vim-startify' "startup

" depend of ddc
Plug 'vim-denops/denops.vim'

"dd series for completion and suggestion
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-source-around'
Plug 'Shougo/ddc-filter-matcher_head'
Plug 'Shougo/ddc-filter-sorter_rank'
Plug 'Shougo/ddc-ui-native'

call plug#end()


"denopsの設定
let g:denops#deno = expand('$HOME/.deno/bin/deno')


"----------------nerdtree----------------------
nnoremap <C-t> :NERDTreeToggle<CR>
"----------------nerdtree----------------------

"----------------nightfox----------------------
colorscheme carbonfox
"----------------nightfox----------------------

"----------------autopairs---------------------
lua << EOF
require("nvim-autopairs").setup {}
EOF
"----------------autopairs---------------------


"----------------ddc----------------------
" ddcの設定
" ui で何を使用するか指定
call ddc#custom#patch_global('ui', 'native')

" 補完内容を管理
call ddc#custom#patch_global('sources', ['around'])

" 保管時のオプションを管理
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" <TAB>: completion.
inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr> <S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

call ddc#enable()
"----------------ddc----------------------
