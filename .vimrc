" Init config ----------------------------------------------------------------
set nocompatible " Don't care about compatibility with Vi.

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
syntax on
set background=dark
colorscheme gruvbox

" UI config ------------------------------------------------------------------
set autoread
set colorcolumn=80
set lazyredraw " Redraw the screen only when necessary.
set number " Show line numbers.
set showmatch " Highlight matching [{()}].
set splitbelow " Split the new pane below the current one.
set splitright " Split the new pane to the right of the current one.
set t_Co=256 " Number of colors to use.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set wildmenu " Visual autocomplete for command menu.

" Syntax and indent by filetype
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

" Remove extra whitespace on save
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
set incsearch " Search as characters are entered
set hlsearch " Highlight matches

" Snippets -------------------------------------------------------------------
nnoremap <silent> bp orequire 'pry'; binding.pry<Esc>

