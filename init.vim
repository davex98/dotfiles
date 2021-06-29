" vim:fdm=marker:fdl=0

set nocompatible
set encoding=utf-8

set showcmd
set noerrorbells
set smartindent
set incsearch
set nu
set smartcase
set signcolumn=yes
set colorcolumn=120
set relativenumber
set cursorline
hi CursorLine term=bold cterm=bold guibg=White
set cursorcolumn
                                                                                
call plug#begin('~/.nvim/plugged')                                                               
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
Plug 'mhinz/vim-startify'
Plug 'preservim/tagbar'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()                                                               

set termguicolors
let ayucolor="mirage"
colorscheme ayu

let mapleader = " "

set noshowmode
nmap <C-y> :TagbarToggle<CR>
nmap <C-p> :FZF<CR>
map <leader>w :wincmd w<CR>
map <leader>f :Files <CR>
map <leader>r :Rg <CR>
map <leader>b :BLines <CR>
map <leader>mm :GoFmt<CR>
map <leader>t :TagbarToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nmap <leader>cd :cd %:p:h<CR>

nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gs :sp<CR><Plug>(coc-definition)
nmap <silent> <Leader>gv :vsp<CR><Plug>(coc-definition)
nmap <silent> <Leader>gr <Plug>(coc-references)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>a  :<C-u>CocList diagnostics<cr>
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
let g:go_auto_sameids = 0
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_snippet_engine = "ultisnips"

let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

let g:go_auto_type_info = 1
set updatetime=100
let g:UltiSnipsExpandTrigger="<C-j>"
let g:ycm_goto_buffer_command= 'split'
let g:go_def_mapping_enabled = 0

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------
set hidden
set cmdheight=2
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()



" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>


" Manage extensions
"=====================================================
"===================== STATUSLINE ====================

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '%Y-%m-%d %H:%M',
      \'z'    : ' #h',
      \'options' : {'status-justify' : 'left', 'status-position' : 'top'}}

let g:tmuxline_powerline_separators = 0
" go language
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
"" STARTIFY {{{
 let g:ascii = [
			 \ '    ooooo      ooo            .o8       oooo   .ooooo.   ',
			 \ '    `888b.     `8`           "888       `888  888` `Y88. ',
			 \ '     8 `88b.    8   .ooooo.   888oooo.   888  888    888 ',
			 \ '     8   `88b.  8  d88` `88b  d88` `88b  888   `Vbood888 ',
			 \ '     8     `88b.8  888   888  888   888  888        888` ',
			 \ '     8       `888  888   888  888   888  888      .88P`  ',
		 \        '    o8o        `8  `Y8bod8P`  `Y8bod8P` o888o   .oP`     ',
			 \]
                                                      
let g:startify_custom_header = startify#center(g:ascii)
inoremap JJ <esc>:w<CR>
inoremap kj <esc>:w<CR>
nnoremap N :noh<CR>
inoremap FF <esc>:GoFillStruct<CR>
nnoremap FF :GoFillStruct<CR>

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'p': '~/.config/nobl9/config.toml' },
            \ { 'o': '~/.zshrc' },
            \ { 'u': '~/.zshenv' },
            \ ]


let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
 let g:startify_files_number = 10
 "" }}}
 set mouse=nicr
 set shell=/bin/zsh
 set mouse=
