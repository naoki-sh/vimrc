if has('vim_starting')
  " 初回起動時のみruntimepathにneobundleのパスを指定する
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするプラグインをここに記述
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tomasr/molokai'
NeoBundle 'ConradIrwin/vim-bracketed-paste' "ペースト時のインデント無効
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'tomtom/tcomment_vim' "コメントのON/OFFをC+-で行う


" NeoBundleをNeoBundle自体で管理する
NeoBundleFetch 'Shougo/neobundle.vim'
" シンタックスハイライト
NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }
" 補完機能----------------------------------------------------
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"neocomplete用設定
let g:acp_enableAtStartup = 0 " Disable AutoComplPop.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"hi WarningMsg guifg=bg "補完時のメッセージを消す

" neosnippet設定
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"------------------------------------------------------------
NeoBundle 'nathanaelkane/vim-indent-guides'
" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=#444433 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#333344 ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
"-----------------------------------------------------------
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'html5.vim' "html5色つけ
NeoBundle 'hokaccha/vim-html5validator' "html5文法チェック
NeoBundle 'hail2u/vim-css3-syntax' "css3色付け
"NeoBundle 'vim-javascript-syntax' "javascript色付け
NeoBundle 'open-browser.vim' "ファイル中のurl読み込み
"-----------------------------------------------------------
NeoBundle 'itchyny/lightline.vim' "ステータスライン色付け
set laststatus=2 "ステータス行を常に表示
let g:lightline = {
    \ 'colorscheme': 'wombat'
    \ }
"-----------------------------------------------------------
" vim-quickrun
NeoBundle 'thinca/vim-quickrun' "設定は~/.vimrc/ftplugin/tex.vim
"-----------------------------------------------------------
" Vim設定
"NeoBundle 'lervag/vimtex'

" 公式サンプルだとsa/sd/srだがsurround.vimに合わせた
nmap ys <Plug>(operator-surround-append)
nmap ds <Plug>(operator-surround-delete)
nmap cs <Plug>(operator-surround-replace)

call neobundle#end()

" NeoBundleCheck を走らせ起動時に未インストールプラグインをインストールする
NeoBundleCheck

syntax enable

set number
set title
set ruler
set list
set mouse=a
set incsearch "検索ワードの最初の文字を入力した時点で検索を開始する
set hlsearch "検索結果をハイライトする
set nowrap
set showmatch "カッコの対応関係を表示する
set whichwrap=h,l
set nowrapscan
"set ignorecase
set smartcase "小文字のみで検索した時に大文字小文字の区別をなくす
set hidden
set history=2000
set autoindent "改行時に前の行のインデントを保持する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set cindent "c言語スタイルのインデントを自動入力する
set expandtab
set tabstop=2
set softtabstop=2 "tabstopと同じ量のスペースがtabキーを押した時に挿入される
set shiftwidth=2
set ambiwidth=double
set helplang=en
set whichwrap=b,b,[,],<,>
set backspace=indent,eol,start
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu wildmode=list:full
"入力中のコマンドを表示する
set showcmd
" statusline
set statusline=%F%r%h%=
set encoding=utf8
scriptencoding
set fileencoding=utf-8 "ファイルエンコーディングの自動判別対象を指定する
"set fileencodings=utf-8,cp932,sjis,euc-jp,latin1 "文字コードの自動識別
set clipboard=unnamed,autoselect "vimでyankしたテキストをクリップボードに格納する
set completeopt=menuone "プレビュー廃止
set wrap "折り返し有効

"全角スペースの可視化
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

"文字コードの自動識別
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:% ",eol:↲

colorscheme molokai
let g:rehash256 = 1
highlight Normal ctermbg=none

nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;

"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" ファイルタイプ別のプラグイン/インデントを有効にする
"filetype plugin indent on
filetype plugin on
""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
" """"""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
" """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
" """"""""""""""""""""""""""""""
if has("autocmd")
   autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

