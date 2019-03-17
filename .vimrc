" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

"vim window size
set lines=50 columns=200

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Leader
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5
set showmatch     "Show matching brackets
set smartcase     "Do smart case matching
set ai            "Automaticatlly ident

"code fold
set foldmethod=indent 
set foldlevel=99
nnoremap <space> za


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  "autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  "autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  "autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set shiftround
set smartindent
set expandtab
" Clang autoindent
set cindent

" Display extra whitespace
"set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
colorscheme desert
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

"当新建 .h .c .hpp .cpp 等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,*.php exec ":call SetTitle()" 
map <leader>cm :call SetComment()<cr>

"加入注释
 func SetComment()
     call setline(2,"/*================================================================") 
     call append(line(".")+1, "*  File Name：".expand("%:t")) 
     call append(line(".")+2, "*  Author：carlziess, chengmo9292@126.com")
     call append(line(".")+3, "*  Create Date：".strftime("%Y-%m-%d %H:%M:%S")) 
     call append(line(".")+4, "*  Description：") 
     call append(line(".")+5, "===============================================================*/") 
     let pos=getpos("w$") 
     call setpos(".", pos)  
 endfunc
 
"定义函数SetTitle，自动插入文件头 
func SetTitle()
     call SetComment()
     if expand("%:e") == 'hpp' 
  call append(line(".")+8, "#ifndef _".toupper(expand("%:t:r"))."_H") 
  call append(line(".")+9, "#define _".toupper(expand("%:t:r"))."_H") 
  call append(line(".")+10, "#ifdef __cplusplus") 
  call append(line(".")+11, "extern \"C\"") 
  call append(line(".")+12, "{") 
  call append(line(".")+13, "#endif") 
  call append(line(".")+14, "") 
  call append(line(".")+15, "#ifdef __cplusplus") 
  call append(line(".")+16, "}") 
  call append(line(".")+17, "#endif") 
  call append(line(".")+18, "#endif //".toupper(expand("%:t:r"))."_H") 
     elseif expand("%:e") == 'h' 
  call append(line(".")+8, "#pragma once") 
     elseif &filetype == 'c' 
  call append(line(".")+8,"#include \"".expand("%:t:r").".h\"") 
     elseif &filetype == 'cpp' 
  call append(line(".")+8, "#include \"".expand("%:t:r").".h\"") 
     endif
endfunc

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

"DoxygenToolkit
let g:DoxygenToolkit_briefTag_funcName = "yes"
" for C++ style, change the '@' to '\'
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre = "\\brief "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre = "\\param "
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_throwTag_pre = "\\throw " " @exception is also valid
let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_versionTag = "\\version "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
let g:DoxygenToolkit_authorName = "Carlziess, chengmo9292@126.com"
let g:doxygen_enhanced_color = 1
"let g:load_doxygen_syntax = 1"
"syntastic
let g:syntastic_ignore_files=[".*\.xml$"]
let g:ycm_show_diagnostics_ui=0
" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" miniBufeExpl                                                                       
let g:miniBufExplMapWindowNavVim=1                                                 
let g:miniBufExplMapWindowNavArrows=1                                              
let g:miniBufExplMapCTabSwitchBufs=1                                               
let g:miniBufExplModSelTarget=1                                                                                                                                                 
let g:miniBufExplMoreThanOne=0  "Do not enable this option,if you don't want get in trouble.                                                     
let g:miniBufExplForceSyntaxEnable=1  
let g:miniBufExplorerMoreThanOne=0 
map <F7> :MBEbp<CR>                                                                 
map <F8> :MBEbn<CR> 

" taglist
nnoremap <silent> <F6> :TlistToggle<CR><CR>
let Tlist_Show_One_File=1
let Tlist_WinWidt=28
let Tiist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
"let Tlist_Use_Left_Windo=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Hightlight_Tag_On_BufEnter=1
"let Tlist_Enable_Fold_Column=0
"let Tlist_Process_File_Always=1
"let Tlist_Display_Prototype=0
"let Tlist_Compact_Format=1

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

autocmd Syntax javascript set syntax=jquery " JQuery syntax support
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags 

set matchpairs+=<:>
set statusline+=%{fugitive#statusline()} "  Git Hotness

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=40
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
nmap <F5> :NERDTreeToggle<cr>

" Emmet
let g:user_emmet_mode='i' " enable for insert mode

" Search results high light
set hlsearch

" nohlsearch shortcut
nmap -hl :nohlsearch<cr>
nmap +hl :set hlsearch<cr>

" Javascript syntax hightlight
syntax enable

" ctrap
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>

" Vim-instant-markdown doesn't work in zsh
set shell=bash\ -i

" Snippets author
let g:snips_author = 'Yuez'

set encoding=utf-8
set t_Co=256
set term=xterm-256color
set termencoding=utf-8

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"airline
"let g:airline_powerline_fonts = 1
"set guifont=Source\ Code\ Pro\ for\ Powerline:h14 

" vim-go custom mappings
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)
" vim-go settings
let g:go_fmt_command = "goimports"
" YCM settings
let g:ycm_key_list_select_completion = ['', '']
let g:ycm_key_list_previous_completion = ['', '']
let g:ycm_key_invoke_completion = '<C-Space>'

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
set clipboard=unnamed
