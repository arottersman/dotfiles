""" VIM PLUG
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/csv.vim'
Plug 'vim-scripts/YankRing.vim'
Plug '/usr/local/opt/fzf'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'cormacrelf/vim-colors-github'
Plug 'sindrets/diffview.nvim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'mzlogin/vim-markdown-toc'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kburdett/vim-nuuid'
Plug 'jxnblk/vim-mdx-js'
Plug 'ghifarit53/tokyonight-vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'github/copilot.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()

set encoding=UTF-8

""" Python required for defx deps
set pyxversion=3

""" COLORS
" set t_Co=256   " This is may or may not be needed...
" let &t_ZH="\e[3m"
" let &t_ZR="\e[23m"
"" set background=light
"" let g:github_colors_soft = 1
"" colorscheme github
"" colorscheme tokyonight
"" let g:tokyonight_style = 'night' " available: night, storm
"" let g:tokyonight_enable_italic = 1

colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha



" colorscheme dracula "colorscheme (elflord/slate/torte)
syntax enable           " enable syntax processing
highlight CopilotSuggestion guifg=#555555 ctermfg=8

""" TABS & SPACES
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces

""" LINE STUFF
set relativenumber              " show line numbers
set cursorline                  " highlight current line
" hi CursorLine term=bold cterm=bold guibg='DraculaBgDarker' ctermbg" =15
" hi CursorLine term=bold cterm=bold guibg=Black ctermbg=0

hi MoreMsg     term=bold ctermfg=29 gui=bold guifg=#22863a


""" MENU AND RENDERING
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.

set showmatch           " highlight matching [{()}]

""" SEARCH
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

""" FD FOR LIFE
inoremap fd <esc>

""" Make backspace work like normal
set backspace=indent,eol,start

""" clippy clappy boards (set to system)
set clipboard=unnamedplus

""" airline
" let g:airline_theme='papercolor'
let g:airline_theme = "github"

""" Remaps
:noremap <C-f> :Files <CR>

""" FZF
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $BAT_THEME='GitHub'
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

""" Grepping
set grepprg=rg\ --vimgrep


""" JAVASCRIPT
" enable jsdoc highlighting
let g:javascript_plugin_jsdoc = 1

""" Fugitive
command -nargs=* Glg Git! lg <args>

""" COC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"" Coc explorer
nmap <leader>fc :CocCommand explorer<CR>
"" Coc Colors
hi CocErrorFloat cterm=bold ctermfg=238 ctermbg=218 gui=bold guifg=#C8CED6 guibg=#f6f8fa


""" GO
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.formatDocument')
