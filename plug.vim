" =============== Plug configuration ===============
call plug#begin('~/.vim/plugged')

Plug 'k-takata/minpac', {'type': 'opt'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-signify'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-abolish'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" html
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" graphql
Plug 'jparise/vim-graphql'

" ruby
Plug 'vim-ruby/vim-ruby'

" {{{ Plugin Specific Settings
" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Lightline
let g:lightline = { 'colorscheme': 'nightowl' }

" fzf
let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'xoffset': 0.5 } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --glob "!{**/node_modules/*,.git/*,public/*,**/package-lock.json}"'

cnoreabbrev Ag Rg

nmap <Leader>f :FZF<CR>
nmap <Leader>s :Rg<Space><C-r>=expand("<cword>")<CR>

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case --ignore node_modules --ignore public --ignore package-lock.json'
endif

" CoC extensions
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-gist',
  \ 'coc-graphql',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-yaml'
\ ]

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" ale
let g:ale_enabled = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = '•'
let g:ale_sign_warning = '.'
let g:ale_set_highlights = 1
let g:ale_lint_on_text_changed = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='onehalfdark'

let g:ale_linters = {
  \ 'javascript': ['eslint', 'prettier'],
  \ 'typescript': ['eslint', 'prettier'],
  \ 'json': ['jsonlint'],
  \ 'ruby': ['prettier'],
  \ 'scss': ['prettier'],
  \ 'css': ['prettier']
\ }

let g:ale_fixers = {
  \ 'javascript': ['eslint', 'prettier'],
  \ 'typescript': ['eslint', 'prettier'],
  \ 'json': ['prettier'],
  \ 'ruby': ['prettier'],
  \ 'scss': ['prettier'],
  \ 'css': ['prettier']
\ }

highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)

map <silent><leader>p :ALEFix<cr>:echo 'Linted!'<cr>
nnoremap <leader>p  <esc>:ALEFix<cr>:echo 'Linted!'<cr>
