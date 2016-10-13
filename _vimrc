" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

	
" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
" set guifont=YaHei_Consolas_Hybrid:h10                 "设置字体:字号（字体名称空格用下划线代替）
set nowrap                                            "设置不自动换行
set shortmess=atI                                      "去掉欢迎界面


" 设定默认解码
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936 
" 语法高亮
syntax on 
"最大化
autocmd GUIEnter * simalt ~x
"不产生备份文件
set nobackup
"自定义主题
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
set guifont=Consolas:h15
language messages zh_CN.utf-8
"处理菜单及右键菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set lines=45 columns=100
set number
set autoindent
set smartindent
set tabstop=4
set autochdir

set shiftwidth=4
set foldmethod=manual

syntax enable
colorscheme Monokai
set nocompatible
set nobackup

"nerdtree插件导入
source $VIMRUNTIME/vimrc_nerdtree.vim

"Bundle管理插件
filetype off                                          "禁用文件类型侦测
if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" 使用Vundle来管理插件，这个必须要有。
Bundle 'gmarik/vundle'
" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
Bundle 'L9'
"golang
Bundle 'dgryski/vim-godef' 
Bundle 'Blackrush/vim-gocode' 
Bundle 'majutsushi/tagbar'
"自动格式化golang代码
autocmd BufWritePre *.go :Fmt
"快速注释各种代码
Bundle 'scrooloose/nerdcommenter'
let g:mapleader = "," 
" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测,如果不这样设置，golang识别不了

