set colorcolumn=120
set nu
set relativenumber
set cursorline
set cursorcolumn
set smartindent
set nowrap
set ignorecase
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set hlsearch
set incsearch
set noswapfile
set nobackup
set scrolloff=8
set sidescroll=1
set sidescrolloff=10
set noshowmode
set mouse=nicr

call plug#begin('~/.nvim/plugged')                                                               
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'neovim/nvim-lspconfig'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'edolphin-ydf/goimpl.nvim'

Plug 'folke/zen-mode.nvim'
Plug 'tjdevries/cyclist.vim'
Plug 'windwp/nvim-autopairs'
Plug 'rafamadriz/friendly-snippets'

Plug 'christoomey/vim-tmux-navigator'

Plug 'ellisonleao/glow.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
call plug#end()                                                               


colorscheme gruvbox

let mapleader = " "

map <leader>w :up<CR>
map <leader>q :q<CR>


vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ) <esc>`>a)<esc>`<i(<esc>
vnoremap ( <esc>`>a)<esc>`<i(<esc>
"
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ! !<c-g>u

noremap <leader>j :cnext<CR> 
noremap <leader>k :cprev<CR> 

inoremap jj <esc>
nnoremap Y y$
noremap <leader>n :nohlsearch<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>

nmap ,p "0p
nmap ,P "0P

nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap <leader>m :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s

lua require("tele")
lua require("lsp_config")
lua require("completion")
lua require("highlight")
lua require("status_line")
lua require("zen")
lua require('nvim-autopairs').setup{}
lua require("luasnip.loaders.from_vscode").load()

nnoremap <c-u> <cmd>Telescope find_files<cr>
nnoremap <leader>d <cmd>lua require("tele").symbols()<cr>
nnoremap <leader>gl <cmd>lua require('go_lint').run()<cr>
nnoremap <leader>z <cmd>ZenMode<cr>

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()

"nnoremap ; :

nnoremap <C-h> <cmd>wincmd h<cr>
nnoremap <C-j> <cmd>wincmd j<cr>
nnoremap <C-k> <cmd>wincmd k<cr>
nnoremap <C-l> <cmd>wincmd l<cr>
nnoremap <leader>e <cmd>Vex <cr>

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>
hi Normal guibg=NONE ctermbg=NONE

noremap <leader>y "+y
noremap <leader>p "+p
nnoremap <leader>cd :cd %:p:h<CR>
call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',    
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
