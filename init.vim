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
Plug 'lervag/vimtex'
Plug 'luochen1990/rainbow'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'RasmusKB/project.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'mfussenegger/nvim-jdtls'
" Always last
Plug 'williamboman/mason-lspconfig.nvim'
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
map <C-t> :NERDTreeToggle<CR>
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

" Keybindings for telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Keybinding for opening telescopes project manager
nnoremap <leader>f :lua require'telescope'.extensions.projects.projects{}<cr>

" Keybinds to make X and P not overwrite current clipboard
noremap x "_x
noremap X "_x
xnoremap p pgvy

" Keybindings for floatterms
let g:floaterm_keymap_toggle = '<Leader>ft'

" Keybind for opening a new alacritty terminal
nnoremap <silent> <C-n> :silent !alacritty &<CR>

" Setup for mason.nvim for Language Server Protocols and nvim-cmp for autocomplete
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "jdtls", "lua_ls", "eslint" },
}
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  -- Setup for indent-blankline
  require("ibl").setup {}
  -- Setup for telescopes projects for allowing to switch project root
  require("project_nvim").setup {}
  require('telescope').load_extension('projects')
EOF
