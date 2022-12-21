let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype on

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'junegunn/fzf',{'dir':'~/fzf','do':'./install --all'}
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'ryanoasis/vim-devicons'
" Plug 'vim-airline/vim-airline'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'iamcco/markdown-preview.nvim',{'do': 'cd app && yarn install'}
Plug 'kyoz/purify', {'rtp': 'vim'}
Plug 'chun-yang/auto-pairs'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'tyrannicaltoucan/vim-quantum'






call plug#end()




set statusline=%1*%F%m%r%h%w%=\ 
set statusline+=%2*\ %Y\ \|\  
set statusline+=%3*%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ 
set statusline+=%4*[%l:%v]\ 
set statusline+=%5*%p%%\ \|\ 
set statusline+=%6*%LL\


set ambiwidth=double  
set encoding=UTF-8
set t_Co=256
set laststatus=2
set autoread
set clipboard=unnamed
set ruler
set cursorline
set foldcolumn=0
set nocompatible

syntax on

set autoindent
set confirm
set tabstop=2
set shiftwidth=4
set number
set relativenumber
set ignorecase
set hlsearch
set incsearch

set mouse=a
set sidescroll=10
set novisualbell
set showcmd

set nofoldenable             " 启动 vim 时关闭折叠代码
set foldmethod=indent        " 设置语法折叠
setlocal foldlevel=99        " 设置折叠层数
nnoremap <space> za          " 用空格键来开关折叠


colorscheme purify

"----------------------------------------------------------------------

" 设置tab栏-------------------------------------------------
" 选中的tab颜色
hi SelectTabLine term=Bold cterm=Bold ctermfg=DarkYellow ctermbg=LightGray
hi SelectPageNum cterm=None ctermfg=DarkRed ctermbg=LightGray
hi SelectWindowsNum cterm=None ctermfg=DarkCyan ctermbg=LightGray
" 未选中状态的tab
hi NormalTabLine cterm=None ctermfg=Gray ctermbg=DarkGray
hi NormalPageNum cterm=None ctermfg=Gray ctermbg=DarkGray
hi NormalWindowsNum cterm=None ctermfg=Gray ctermbg=DarkGray
" tab栏背景色
hi TabLineFill term=reverse ctermfg=5 ctermbg=7 guibg=#6c6c6c






"-----------------------------------------------------------------------
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <C-F2-f> :NERDTreeFind<CR>
noremap <F8> : TagbarToggle<CR> 








"-----------------------------------------------------------------------


autocmd BufEnter * if winnr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |quit |endif


"-----------------------------------------------------------------------

" 下一个buffer(循环)
nmap <C-n> :bn<CR>
imap <C-n> <Esc>:bn<CR>i
" 上一个buffer(循环)
nmap <C-p> :bp<CR>
imap <C-p> <Esc>:bp<CR>i

" 关闭当前buffer, 但是需要先将文件树关闭,否则会退出vim
nmap <Leader>bd :bd<CR>

" 显示全角符号
" set ambiwidth=double
" 主题
colorscheme quantum
let g:airline_theme="badwolf" 
" tag箭头"

set ambiwidth=single
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = ' '






nnoremap <expr> <Tab> pumvisble() ? "\<C-n>":"\<Tab>"
nnoremap <expr> <S-Tab> pumvisble() ? "\<C-p>":"\<S-Tab>"

let g:netrw_banner = 0         " 设置是否显示横幅
let g:netrw_liststyle = 3      " 设置目录列表样式：树形
let g:netrw_browse_split = 4   " 在之前的窗口编辑文件
let g:netrw_altv = 1           " 水平分割时，文件浏览器始终显示在左边
let g:netrw_winsize = 20       " 设置文件浏览器窗口宽度为25%
let g:netrw_list_hide= '^\..*' " 不显示隐藏文件 用 a 键就可以显示所有文件、 隐藏匹配文件或只显示匹配文件

noremap <Leader>] :tabnext<CR>
noremap <Leader>[ :tabprevious<CR>
noremap <Leader><left> :bp<CR>
noremap <Leader><right> :bn<CR>


"--------------------------------------------------------------------

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        let hlTab = ''
        let select = 0
        if i + 1 == tabpagenr()
            let hlTab = '%#SelectTabLine#'
            let s ..= hlTab . '⎡%#SelectPageNum#%T' . (i + 1) . hlTab
            let select = 1
        else
            let hlTab = '%#NormalTabLine#'
            let s ..= hlTab . "⎡%#NormalTabLine#%T" . (i + 1) . hlTab
        endif

        " the label is made by MyTabLabel()
        let s .= ' %<%{MyTabLabel(' . (i + 1) . ', ' . select . ')} '
        "追加窗口数量
        let wincount = tabpagewinnr(i + 1, '$')
        if wincount > 1
            if select == 1
                let s .= "%#SelectWindowsNum#" . wincount
            else
                let s .= "%#NormalWindowsNum#" . wincount
            endif
        endif
        let s .= hlTab . "⎦"
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
      let s ..= '%=%#TabLine#%999X░❨X❩'
    endif

    return s
endfunction

" Now the MyTabLabel() function is called for each tab page to get its label. >
function MyTabLabel(n, select)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    for bufnr in buflist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor

    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])

    if name == ''
        if &buftype == 'quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        let name = fnamemodify(name, ':t')
    endif

    let label .= name
    return label
endfunction

set tabline=%!MyTabLine()



