let mapleader = " "

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'kovetskiy/sxhkd-vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
" Always last
Plug 'ryanoasis/vim-devicons'
call plug#end()

"Lightline stuff
let g:lightline = {}

" Colorscheme
colorscheme gruvbox
let g:lightline.colorscheme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'

" Nerd tree settings and auto close when only buffer
nmap <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Active rainbow brackets
let g:rainbow_active = 1

" Shortcuts for navigating different buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"Remove arrow keys for different modes
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
augroup SeriouslyNoInsertArrows
  autocmd!
  autocmd InsertEnter * inoremap <expr> <Up> pumvisible() ? "\<C-P>" : ""
  autocmd InsertEnter * inoremap <expr> <Down> pumvisible() ? "\<C-N>" : ""
augroup END

" Navigation on linebreaks
nnoremap j gj
nnoremap k gk
nnoremap 0 g0i
nnoremap $ g$

"Toggle VIM cheatsheet
command CS :tabnew ~/Documents/vim/cheatsheet.txt

"NerdTree stuff
command NT NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen='1'

"VimTex stuff
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

let g:vimtex_log_verbose=0
let g:vimtex_quickfix_enabled = 0
let g:Tex_GotoError = 0
let g:Tex_ShowErrorContext = 0
let g:vimtex_view_general_viewer = 'zathura'

" Remove autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically delete all trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

" Save file as sudo when needed
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Misc
set nohlsearch " Dont highlight when searching
set clipboard+=unnamedplus " Use system clipboard
set nocompatible " No clue but apparently important
set splitbelow splitright " Set where splits open
set noshowmode " Don't write mode at bottom, already shown in lightline
set ignorecase " Case insensitive matching
set number " Side numbers
filetype plugin indent on " Allow auto-indenting depending on file type

" Auto completion stuff
set omnifunc=syntaxcomplete#Complete
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_auto_popup = 1
set shortmess+=c
"set completeopt=menuone,noselect
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Tab stuff
set tabstop=4 " Size of tabs
set softtabstop=4 " See multiple spaces as tabstops
set shiftwidth=4 " Autoindent width
set autoindent " Autoindent

" Syntax stuff
syntax on " Turn on syntax
set maxmempattern=10000
set redrawtime=10000

" Signcolumn wizardry
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Update binds when sxhkdrc is updated
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Change indentstyle for C files
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 expandtab

" Change indentstyle for F# files
autocmd FileType fsharp setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd BufNewFile,BufRead *.fsl setlocal filetype=fsharp
autocmd BufNewFile,BufRead *.fsp setlocal filetype=fsharp

" VIM buffer navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" For true color
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif
