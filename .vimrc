set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax enable
" set <leader> key
let mapleader = ","
let g:mapleader = ","


call plug#begin('~/.vim/plugged')

Plug 'unblevable/quick-scope'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/YankRing.vim'
Plug 'tomtom/checksyntax_vim/'
Plug 'itchyny/vim-cursorword'
Plug 'sjl/gundo.vim'

Plug 'wellle/targets.vim'
"

Plug 'tpope/vim-commentary'
Plug 'haya14busa/incsearch-fuzzy.vim' | Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'corntrace/bufexplorer'
Plug 'vim-scripts/Align'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/Marks-Browser'
Plug 'vim-scripts/netrw.vim'

Plug 'shawncplus/phpcomplete.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'

Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'Shougo/unite.vim'

Plug 'Shougo/neocomplete'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/vim-easy-align'

Plug 'Shougo/vimproc'

"Plug 'mkusher/padawan.vim'


Plug 'dkprice/vim-easygrep'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'algotech/ultisnips-php'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Add plugins to &runtimepath
call plug#end()



if !exists('g:neocomplete#force_omni_patterns')
      let g:neocomplete#force_omni_patterns = {}
  endif
  let g:neocomplete#force_omni_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
set backspace=indent,eol,start
"
    let g:neocomplete#data_directory = '~/.vim/tmp/neocomplete'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

            let g:neocomplete#keyword_patterns = {}
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'



" <CR>: close popup and save indent.
imap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

let g:neocomplete#use_vimproc=1
inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
  endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'



set wildmode=list:longest,list:full
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : exists("g:loaded_snips") ? "\<C-r>=TriggerSnippet()\<CR>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : exists("g:loaded_snips") ? "\<C-r>=BackwardsSnippet()\<CR>" : "\<S-Tab>"
set completeopt-=preview


set autochdir
autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

set tags+=~/tags

set hlsearch



"let g:padawan#timeout = 0.1
"let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
"let g:padawan#composer_command = "composer"

set background=dark
colorscheme hybrid

" Убираем добавление пустой строки в конец файла при сохранении файла
set binary
set noeol

" hide mouse pointer when printing
"set mousehide

" yank to the system register (*) by default
set clipboard=unnamedplus

" enable autoident
set autoindent

" mouse
"set mouse=a
"set mousemodel=popup

" enable smart indent
set smartindent

"disable beep
set novisualbell

" auto update files
set autoread

" fast use mapping keys
set notimeout

" Enable filetype plugins
filetype on

au BufReadPost *.phtml set syntax=html
au BufReadPost *.twig set syntax=html
au BufReadPost *.thrift set syntax=thrift
au BufReadPost *.yml set nocursorline

" autoreload vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" indent plugin
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
set foldcolumn=2

let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_min_num_of_chars_for_namespace_completion = 2

"syntax checkers
let g:syntastic_php_checkers=['php']

" highlight trailing spaces
au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)

" highlight tabs between spaces
au BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
au BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)

" file options
set fileencodings=utf8
set encoding=utf8 nobomb " utf-8 with out BOM
set termencoding=utf-8 " default text encoding
set ff=unix " default file format










function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction


command! BTags call s:btags()
map <leader>bt :BTags<cr>

















let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>



"function PhpDoc()
"    call pdv#DocumentWithSnip()<CR>
"endfunction

let g:vim_php_refactoring_phpdoc="PhpDoc"


set noswapfile



set laststatus=2
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1














" gundo
nnoremap <F6> :GundoToggle<CR>

" Esc
imap jj <Esc>

" Not jump on star, only highlight
nnoremap * *N

" Drop hightlight search result
noremap <leader><space> :nohls<CR>

" long lines
nmap j gj
nmap < DOWN> gj
nmap k gk
nmap < UP> gk


" fast search and replace word under  cursor
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" F5 - show buffers
nmap <F5> <esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" fuzzy search
" map <leader>ft :FufTag<CR>
" map <leader>fb :FufBuffer<CR>
" map <leader>fl :FufLine<CR>
" map <leader>fq :FufQuickfix<CR>

"show marks browser
map <leader>mb :MarksBrowser<CR>
map <leader>d2u :%s/\r//g<cr>

map <leader>yy "*y<cr>











function! s:config_easyfuzzymotion(...) abort
    return extend(copy({
      \   'converters': [incsearch#config#fuzzyword#converter()],
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ 
    }), get(a:, 1, {}))
endfunction

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)



set t_Co=256


set undodir=~/.vim/undodir
set undofile
set hid

"execute the command on write
autocmd BufWritePost,FileWritePost *.php :CheckSyntax
inoremap <silent> <F3> <ESC>:YRShow<cr>
"autocmd! InsertLeave *.php :CheckSyntax %


nnoremap <silent> <leader>ys :YRShow<C-r>