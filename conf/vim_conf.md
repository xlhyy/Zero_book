# vim配置


### ~/.vimrc


```
syntax on
"set t_Co=256
"解决在输入模式下删除键不好用
set backspace=2
"背景颜色
set background=dark
"激活鼠标
"set mouse=a
"编码格式
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
"显示行号
set nu
set number
"tab键缩进大小
set tabstop=4
"颜色主题
color koehler
"显示标尺
set ruler
"自动缩进
set autoindent
set cindent
"缩进长度
set softtabstop=4
set shiftwidth=4
"光标从行首和行末时可以跳到另一行去
"set whichwrap=b,s,<,>,[,]
"配色主题
colorscheme desert
"还有: desert, murphy torte, solarized, molokai, phd, ron, evening 等经典配色
"高亮当前行
set cursorline
set cursorcolumn
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black ctermfg=gray guibg=NONE guifg=NONE
"red（红），white（白），black（黑），green（绿），yellow（黄），blue（蓝），purple（紫），gray（灰），brown（棕），tan(褐色)，syan(青色)
"搜索忽略大小写
set ignorecase
"vim自身命令行模式智能补全
set wildmenu
"定义快捷键到行首和行尾
nmap LB 0
nmap LE $
```
