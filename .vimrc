" vim-plug -------------------------------------------------------------------
" If we don't have vim plug installed, install it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
call plug#end()

" Colorscheme ----------------------------------------------------------------
syntax enable
set background=dark
colorscheme gruvbox

" UI Config ------------------------------------------------------------------
set autoread
set colorcolumn=80
set lazyredraw " redraw the screen only when necessary
set number " show line numbers
set showmatch " highlight matching [{()}]
set splitbelow " split the new pane below the current one
set splitright " split the new pane to the right of the current one
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set wildmenu " visual autocomplete for command menu

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Searching ------------------------------------------------------------------
set incsearch " search as characters are entered
set hlsearch " highlight matches

