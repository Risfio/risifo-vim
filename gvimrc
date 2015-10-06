execute pathogen#infect()
syntax on
filetype plugin indent on

" Completion mode !?
set wildmenu
set wildmode=longest:full,full

" Number line in editor
set number
set backspace=indent,eol,start

" Show starting-closing for brackets and etc.
set showmatch
set whichwrap=b,s,h,l,<,>,[,]

set nowrap
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\\\s\\\\+$","","")'))

" Indentation
" set autoindent
set shiftwidth=4
set tabstop=4
set expandtab

set laststatus=2
set statusline=\ %<%f\                          " Filename
set statusline+=%w%h%m%r                        " Options
set statusline+=%{fugitive#statusline()}        " Git Hotness
set statusline+=\ [%{&ff}/%Y]                   " filetype
set statusline+=\ [%{getcwd()}]                 " current dir
set statusline+=%=
set statusline+=%l/%L,%c%V\                     " Right aligned file nav info
let g:airline_powerline_fonts = 1
" hi Normal guifg=#d8d8d8 guibg=#34363a font='Meslo LG L DZ 10'
hi Normal guifg=#d8d8d8 guibg=#34363a
hi Comment guifg=#767f8c
hi Number guifg=#ac92ec
hi String guifg=#f7e3ba
hi Boolean guifg=#ec87c0
hi NonText guifg=bg
hi CursorLine guibg=#3e4145
hi StatusLine gui=bold guibg=#4a4d52
hi StatusLineNC gui=bold guibg=#4a4d52 guifg=#222222
hi VertSplit gui=None guibg=#4a4d52 guifg=#4a4d52
hi LineNr guifg=#868789
hi SignColumn guibg=bg
hi SpecialKey guifg=#444444
hi Directory guifg=fg gui=bold

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/dev/ | endif
map <C-o> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Line below - is different mode for show nerdtree menu. It horrible
" autocmd BufNew * wincmd l

let g:NERDTreeChDirMode=2
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeIgnore=['.swp$', '\.git$', '\~$']
let g:NERDTreeWinSize=20

" Remove top and side bars
set go-=m
set go-=T  "remove toolbar
set go-=r  "remove right-hand scroll bar
set go-=L  "remove left-hand scroll bar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
set guiheadroom=0

:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" ##################### DEVELOPER SETTINGS ####################
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

