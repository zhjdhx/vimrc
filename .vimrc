
"source ~/.vimrc立即生效
"必须
set nocompatible
"帮助
set helplang=cn 
"主题
colorscheme 256_jungle
"自动语法高亮
syntax on
filetype off
"回车
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
"行号
set number
" 使用鼠标"鼠标复制不方便  
""set mouse=a  
""set selection=exclusive  
""set selectmode=mouse,key
""if has('mouse')
""   set mouse-=a
""endif 
"设置编码
set enc=utf-8  
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936  
" 检测文件类型  
filetype on  
" 检测文件类型插件  
filetype plugin on 
"据说加了这句才可以用智能补全
set completeopt=longest,menu
"" replace tab with space  
set expandtab  
" 设定 tab 长度为 4  
set tabstop=4  
" 设置按BackSpace的时候可以一次删除掉4个空格  
set softtabstop=4  
" 设定 << 和 >> 命令移动时的宽度为 4  
set shiftwidth=4  
set smarttab  
"突出当前行
set cursorline
"搜索
" 搜索时忽略大小写，有一个或以上大写字母时仍大小写敏感  
set ignorecase  
set smartcase  
" " 搜索到文件两端时重新搜索  
set wrapscan  
" " 实时搜索  
set incsearch  
" " 搜索时高亮显示被找到的文本  
set hlsearch 
"显示括号配对情况  
set showmatch

" Ctrl+a  
nmap <silent> <C-a> ggvG$  
"   
"   " 选中状态下 Ctrl+c 复制  
vnoremap <c-c> "+y  
"     
"     " Ctrl+v  
"nmap <silent> <C-v> "+p


"   
set hidden  
" " 智能自动缩进  
set smartindent  
" " 设定命令行的行数为 1  
set cmdheight=1  
" " 显示状态栏 (默认值为 1, 无法显示状态栏)  
set laststatus=2  
"
" 据说解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题  
set display=lastline
" 设置在状态行显示的信息  
set statusline=%F%m%r%h%w%=\ [ft=%Y]\ %{\"[fenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [ff=%{&ff}]\ [asc=%03.3b]\ [hex=%02.2B]\ [pos=%04l,%04v][%p%%]\ [len=%L]

" 打开状态栏标尺 
set ruler
"关闭声音
set noerrorbells 
set novisualbell
"设置魔术，方便正则
set magic

"折叠
set foldenable " 开始折叠
set foldmethod=manual
""set foldmethod=syntax " 设置语法折叠
""set foldcolumn=0 " 设置折叠区域的宽度
""setlocal foldlevel=1 " 设置折叠层数为
""set foldclose=all " 设置为自动关闭折叠 


"
"按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh' 
        exec "!time ./%"
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'go'
        "exec "!time go build %<"
        exec "!time go run %"
     endif
endfunc
"
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py,*.go exec ":call SetTitles()" 
"""定义函数SetTitle，自动插入文件头 
func! SetTitles() 
    "如果文件类型为.sh文件 
        if &filetype == 'python' 
                call setline(1,"\#!usr/bin/env python") 
                call append(line("."), "\#-*- coding: utf-8 -*-") 
                call append(line(".")+1,"\#########################################################################") 
                call append(line(".")+2, "\# FileName: ".expand("%")) 
                call append(line(".")+3, "\#Author: zslearn") 
                call append(line(".")+4, "\# mail:XXXXXXXXXXX") 
                call append(line(".")+5, "\# Created Time:".strftime("%c")) 
                call append(line(".")+6, "\#########################################################################") 
                call append(line(".")+7,"") 
        endif
        if &filetype == 'go' 
                call setline(1,"\#########################################################################") 
                call append(line("."), "\# File Name: ".expand("%")) 
                call append(line(".")+1, "\# Author: zslearn") 
                call append(line(".")+2, "\# mail: XXXXXXXXXXX") 
                call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
                call append(line(".")+4, "\#########################################################################") 
                call append(line(".")+5, "package main") 
                call append(line(".")+6, "import (") 
                call append(line(".")+7, "\_ \"fmt\"")
                call append(line(".")+8, ")")
        endif
    autocmd BufNewFile * normal G
endfunc
"识别go
au BufRead,BufNewFile *.{go}  setfiletype go
au BufRead,BufNewFile *.{py}  setfiletype python
"补全单双
"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
"python高亮全开
let python_highlight_all=1
call plug#begin()
"Plug 'maralla/completor.vim'python支持问题
"补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug 'vim-syntastic/syntastic'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
""插入代码段方便
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'    
" Optional:
Plug 'honza/vim-snippets'
""补全单双
Plug 'jiangmiao/auto-pairs'
"多文件
Plug 'fholgado/minibufexpl.vim'

Plug 'fatih/vim-go'

call plug#end()
"let g:completor_min_chars=2
"开启python自动补全
"autocmd FileType python set omnifunc=python3complete#Complete
""filetype plugin on 
""let g:pydiction_location = '/root/.vim/after/complete-dict'
""let g:completor_python_binary = '/root/miniconda2/lib/python2.7/site-packages/jedi-0.13.1.dist-info/INSTALLER'
""已更换为jedi

""开启go自动补全
let g:completor_gocode_binary = '/usr/local/go/bin/gocode'
"let g:completor_python_binary = '/usr/bin/python3'
""目录树C+n,C+w+w切换窗口
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '<'
""静态检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
""tagbar
"F9触发，设置宽度为30
let g:tagbar_width = 30
nmap <F8> :TagbarToggle<CR>
""开启自动预览(随着光标在标签上的移动，顶部会出现一个实时的预览窗口)
let g:tagbar_autopreview = 1
"关闭排序,即按标签本身在文件中的位置排序
let g:tagbar_sort = 0
""gotags调用gd ,C+o
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
""ctags gd C+o ,CTRL + ],CTRL + T
set tags=tags;
set tags+=~/.vim/tags/python.ctags
set tags+=~/.vim/tags/python3.ctags
set tags+=~/.vim/tags/golang.ctags
set autochdir

""undo tree
nnoremap <C-u> :UndotreeToggle<cr>
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
"miniexplore bn,bp,bd,bw
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

