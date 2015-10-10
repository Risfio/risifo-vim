" Use it in powershell on smallscreen notebook.
" Like acer e-111 for example
" Theme setting for black background color for powershell
execute pathogen#infect()
syntax on
filetype plugin indent on

set wildmenu
set wildmode=longest:full,full

set number
"set relativenumber

set history=1000

set cursorline

set backspace=indent,eol,start

set showmatch
set whichwrap=b,s,h,l,<,>,[,]

set nowrap
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\\\s\\\\+$","","")'))

set autoindent
set shiftwidth=4
set tabstop=4

set incsearch
set ignorecase
set smartcase

set laststatus=2
set statusline=\ %<%f\                          " Filename
set statusline+=%w%h%m%r                        " Options
set statusline+=%{fugitive#statusline()}        " Git Hotness
set statusline+=\ [%{&ff}/%Y]                   " filetype
set statusline+=\ [%{getcwd()}]                 " current dir
set statusline+=%=
set statusline+=%l/%L,%c%V\                     " Right aligned file nav info

set go-=m
set go-=T  "remove toolbar
set go-=r  "remove right-hand scroll bar
set go-=L  "remove left-hand scroll bar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
set guiheadroom=0

" set guifont=Inconsolata-dz\ for\ powerline
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
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd BufNew * wincmd l

let g:NERDTreeChDirMode=2
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeIgnore=['.swp$', '\.git$', '\~$']
let g:NERDTreeWinSize=20

let g:airline_section_z = '%l/%L,%v'
let g:airline_theme='dark'

let g:syntastic_error_symbol='?'
let g:syntastic_warning_symbol='?'
let g:syntastic_check_on_open=1

set langmap=éq,öw,óe,êr,åt,íy,ãu,øi,ùo,çp,õ[,ú],ôa,ûs,âd,àf,ïg,ðh,îj,ëk,äl
set langmap+=,ý',ÿz,÷x,ñc,ìv,èb,òn,üm,þ.,¸`,ÉQ,ÖW,ÓE,ÊR,ÅT,ÍY,ÃU,ØI,ÙO,ÇP
set langmap+=,Õ{,Ú},ÔA,ÛS,ÂD,ÀF,ÏG,ÐH,ÎJ,ËK,ÄL,Æ:,Ý\",ßZ,×X,ÑC,ÌV,ÈB,ÒN,ÜM,Á\<,Þ\>,¨\~


set list
set listchars=tab:»-,trail:·


let g:neocomplete#enable_at_startup = 1

set updatetime=750

let g:syntastic_always_populate_loc_list = 1

set noswapfile

im <C-Space> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let g:syntastic_cpp_compiler_options=' -std=c++14'
##################### DEVELOPER SETTINGS ####################
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

