set nobackup " バックアップを取らない
set noswapfile
set nonumber
set fenc=utf-8
set cursorline
set virtualedit=onemore
set smartindent
set laststatus=2
set display=lastline
set scrolloff=5
set ruler
set list listchars=tab:\▸\-
set expandtab
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

set tabstop=2
set shiftwidth=2
set softtabstop=2
au BufNewFile,BufRead *.py set tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.php set tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.go set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

nnoremap Y y$

" Save as sudo
cmap w!! w !sudo tee > /dev/null %

autocmd BufWritePre * :%s/\s\+$//ge  "最終行の空白を削除
syntax on
filetype plugin indent on

colorscheme slate


" set paset
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

:map <C-a> <Home>
:map <C-e> <End>
