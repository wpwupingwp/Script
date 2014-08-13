"2014.8.13 wpwupingwp@outlook.com
"Vundle Setup
if has("unix")
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    set guifont=Inconsolata\ 12" 字体 && 字号
else
    set rtp+=$VIM/vimfiles/Bundle/vundle/
	call vundle#rc('$VIM/vimfiles/Bundle')
    set guifont=Inconsolata:h12
    let g:Powerline_symbols='fancy'
    set guioptions-=m       " hide menu
endif

"Plugin List
Bundle 'gmarik/vundle'           
Bundle 'Shougo/neocomplcache'
Bundle 'garbas/vim-snipmate'
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
Bundle 'scrooloose/nerdtree'
Bundle 'chriskempson/tomorrow-theme',{'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'nathanaelkane/vim-indent-guides'

"indent-guides setup"
set ts=4 sw=4 et
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1

"NeoComplCache setup
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.phtml set filetype=php
au BufRead,BufNewFile *.js set ft=javascript.jquery
let g:neocomplcache_enable_at_startup = 1

"Configure 
set background=dark
"colorscheme Tomorrow-Night-Eighties
colorscheme solarized
let g:solarized_termcolors=256
set tabstop=4                " 设置tab键的宽度
set autoindent               " 自动对齐
set cuc                      "Highlight line 
set cul
set ai                      " 设置自动缩进
set nu                      " 显示行号
"set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set hlsearch                 " 开启高亮显示结果
set nocompatible             " 关闭兼容模式
"set list                     " 显示Tab符，使用一高亮竖线代替
"set listchars=tab:\|\ ,
set foldlevel=100            "禁止折叠
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全
set backspace=indent,start   "Enable Backspace
set directory=.,$TEMP

if has("gui_running")
  "  au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    set guioptions-=m       " 隐藏菜单栏
    set guioptions-=T        " 隐藏工具栏
    set guioptions-=L       " 隐藏左侧滚动条
    "set guioptions-=r       " 隐藏右侧滚动条
    set guioptions-=b       " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
endif

" encoding
set fenc=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,latin1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_US.utf-8

"Txt Setup
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=1

"map 
imap <C-[> <Esc>
