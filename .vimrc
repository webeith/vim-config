call plug#begin('~/.vim/bundle')
call plug#begin('~/.vim/plugged')


Plug 'Valloric/YouCompleteMe'

Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'



Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0ng/vim-hybrid'
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'Shougo/vimproc'

Plug 'mkusher/padawan.vim'


Plug 'dkprice/vim-easygrep'
" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Add plugins to &runtimepath
call plug#end()


set autochdir
autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

set tags+=~/htdocs/phoenix/tags




let g:padawan#timeout = 0.1
let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
let g:padawan#composer_command = "composer"

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


















"

function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
" \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
" \            '| grep -v ^!',
" \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
" \ 'down':    '40%',
" \ 'sink':    function('s:tags_sink')})
            \   'source': "cat " . tagfiles()[0] . ' | grep "' . expand('%:@') . '"' . " | sed -e '/^\\!/d;s/\t.*//' ". ' |  uniq',
            \   'sink':   'tag',
            \   'options':  '+m',
            \   'left':     60,
            \ })
endfunction

command! Tags call s:tags()




