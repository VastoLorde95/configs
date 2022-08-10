" Vim-Plug
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'python-mode/python-mode'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf'

call plug#end()

filetype plugin on

" Set the delay for vim escape key
set ttimeoutlen=5

" Search through subdirs
set path+=**

"" Set auto complete options in insert mode (^n)
" Exclude the tags files and the included files for quick auto complete
setglobal complete-=i
setglobal complete-=t

" Tab autocomplete when finding files thorugh 'find'
set wildmenu

"ignore case when searching
set ic

" Show the command as it is being typed
set showcmd

" highlight search
set hlsearch

"line numbers
set nu
set rnu

" Enable syntax highlighting
syntax enable

" Python settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" lineline
set laststatus=2
set noshowmode

"remove highlights
nnoremap <C-n> :nohlsearch<CR>

"jump to search AND center the screen
nnoremap n nzz
nnoremap N Nzz

" Highlight color
highlight Search ctermfg=black

"tab creation
nnoremap T :tabe<CR>
nnoremap W :tabc<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERDTree
let g:NERDTreeDirArrows=0
set encoding=utf-8

" pymode
let g:pymode = 0
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_motion = 0
let g:pymode_rope = 0
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_highlight_async_await = g:pymode_syntax_all
let g:pymode_synatx_highlight_equal_operator = g:pymode_syntax_all
let g:pymode_syntax_hight_stars_operator = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
let g:pymode_syntax_string_fomratting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_syntax_docstrings = g:pymode_syntax_all
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_write = 0

"enable syntax highlighting
colorscheme monokain

hi Normal ctermfg=white

set cursorline
set backspace=indent,eol,start

" fzf
set rtp+=~/.fzf
nnoremap <leader>f :FZF<CR>
