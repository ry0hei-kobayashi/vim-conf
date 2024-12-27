"if you install neovim, this file set to .config/nvim/ 
"if you want to change the rosed defaults. set those to bashrc [alias vim='nvim' export EDITOR='nvim']

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
"set clipboard=unnamed 
set clipboard=unnamedplus

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
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'lewis6991/gitsigns.nvim' 
Plug 'windwp/nvim-autopairs' "auto bracket
Plug 'EdenEast/nightfox.nvim' "colorscheme 
Plug 'mhinz/vim-startify' "startup screen
Plug 'lukas-reineke/indent-blankline.nvim' "indantation viewer
Plug 'HiPhish/rainbow-delimiters.nvim' "indantation viewer

" depend of ddc
Plug 'vim-denops/denops.vim'

"dd series for completion
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-source-around'
Plug 'Shougo/ddc-filter-matcher_head'
Plug 'Shougo/ddc-filter-sorter_rank'
Plug 'Shougo/ddc-ui-native'
"Plug 'Shougo/ddc-source-lsp'

call plug#end()


"denopsの設定
let g:denops#deno = expand('$HOME/.deno/bin/deno')


"----------------nerdtree----------------------
nnoremap <C-n> :NERDTreeToggle<CR>
"----------------nerdtree----------------------
"
"----------------toggle term----------------------
lua << EOF
require("toggleterm").setup({
    open_mapping = [[<c-t>]],
    hide_numbers = true, 
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "1",
    start_in_insert = true, 
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true, 
    shell = vim.o.shell, 

})
vim.api.nvim_set_keymap('t', '<C-[>', [[<C-\><C-n>]], { noremap = true, silent = true })
EOF
"----------------toggle term----------------------

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
call ddc#custom#patch_global('ui', 'native')

" 補完内容を管理
call ddc#custom#patch_global('sources', ['around'])

call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \ },
    \ 'around': {'mark': 'Around'},
    "\ 'lsp': {'mark': 'LSP', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'}
\ })

" Tab for completion
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : ddc#map#manual_complete()
" Shift-Tab for completion back
inoremap <expr> <S-TAB> pumvisible() ? '<C-p>' : '<C-h>'

call ddc#enable()
"----------------ddc----------------------


"" -----------------------------------------------
" indent-blankline 設定
" -----------------------------------------------
lua << EOF
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
require("ibl").setup {}
EOF
"require("ibl").setup { scope = { highlight = highlight }, indent = {highlight = highlight} }



" ハイライト色変更
highlight Visual ctermbg=yellow guibg=yellow ctermfg=black guifg=black

