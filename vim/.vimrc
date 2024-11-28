
set nocompatible  " not vi compatible
" -----------------------
" Plugin
" -----------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"   this is using vim-plug https://github.com/junegunn/vim-plug
"   link plug.vim into ~/.vim/autoload folder
"   plugins installed by :PlugInstall
call plug#begin('~/.vim/plugged')

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " conquer of completion 

" GUI enhancements
Plug 'itchyny/lightline.vim'  " Better Status Bar

" Writting
Plug 'rhysd/vim-grammarous'  " GrammarCheck using LenguageTool

" Git GUI
Plug 'tpope/vim-fugitive'  " Git interface

" Syntactic language support
Plug 'vim-python/python-syntax'
Plug 'stephpy/vim-yaml'                " YAML support
Plug 'elzr/vim-json'                   " Better JSON support
Plug 'w0rp/ale'                        " Linting engine
Plug 'maximbaz/lightline-ale'          " Lightline + Ale
Plug 'preservim/vim-markdown'         " Markdown support
Plug 'lervag/vimtex'                   " Latex support

" Other 
Plug 'wakatime/vim-wakatime'   " Wakatime time tracking
Plug 'simnalamburt/vim-mundo'  " Gundo fork

call plug#end()

if isdirectory($HOME . "/.vim/plugged/coc.nvim")
    call coc#add_extension(
       \'coc-explorer',
       \'coc-git',
       \'coc-go',
       \'coc-highlight',
       \'coc-highlight',
       \'coc-pyright',
       \'coc-json',
       \'coc-lua',
       \'coc-prettier',
       \'coc-rls',
       \'coc-sh',
       \'coc-tabnine',
       \'coc-vimlsp',
       \'coc-yaml',
       \'coc-eslint',
       \'coc-tsserver',
       \'coc-xml',
       \'coc-css',
       \'coc-stylelint',
     \)
endif


" -----------------------
"  Basic editing config
"  ----------------------
syntax on  " Turn on syntax highlighting
set background=dark 
set nu              " number lines
set relativenumber  " relative numbers
set colorcolumn=80  " show column at 80 characters
set linebreak       " have lines wrap instead of continue off-screen
set nojoinspaces    " suppress inserting two spaces between sentences
filetype indent on  " load filetype-specific indent files
filetype plugin on  " load filetype specific plugin files
set wildmenu        " visual autocomplete for command menu
set showmatch       " show matching braces when text indicator is over them
set splitbelow      " Open new vertical split bottom
set splitright      " Open new horizontal splits right
set mouse+=a        " A necessary evil, mouse support

" Spaces and tabs
" use 4 spaces instead of tabs during formatting
set expandtab       " tabs are spaces, mainly because of python
set tabstop=4       " number of visual spaces per TAB
set shiftwidth=4    " Insert 4 spaces on a tab
set softtabstop=4   " number of spaces in tab when editing

" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu

" searching
set hls  " highlight search
set ignorecase      " Ignore case in searches by default
set smartcase       " But make it case sensitive if an uppercase is entered

"--------------------
" Plugins config
"--------------------
"Conquer of Completion
if !exists("*VSCodeNotify") && isdirectory($HOME . "/.vim/plugged/coc.nvim")

    let g:coc_custom_config = '1'
    let g:coc_node_path = '/usr/bin/node'
    " let g:coc_disable_startup_warning = 1

    let g:vista_default_executive = 'coc'

    "source ~/.vim/coc.vim
    " Use autocmd to force lightline update.
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

    " Lightline mods for CoC compatibility
    let g:lightline = {
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified', 'fugitive' ] ],
          \   'right': [ [ 'lineinfo' ],
		  \              [ 'percent' ],
		  \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'filetype', 'fileencoding'] ]
          \ },
          \ 'component_function': {
          \   'filename': 'LightlineFilename',
          \   'cocstatus': 'coc#status',
          \   'currentfunction': 'CocCurrentFunction'
          \ },
          \ }
    function! LightlineFilename()
      return expand('%:t') !=# '' ? @% : '[No Name]'
    endfunction

    function! CocCurrentFunction()
        return get(b:, 'coc_current_function', '')
    endfunction


let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

    " vim-easymotion disturbs diagnostics
    " See https://github.com/neoclide/coc.nvim/issues/110
    " let g:easymotion#is_active = 0
    " function! EasyMotionCoc() abort
    "   if EasyMotion#is_active()
    "     let g:easymotion#is_active = 1
    "     CocDisable
    "   else
    "     if g:easymotion#is_active == 1
    "       let g:easymotion#is_active = 0
    "       CocEnable
    "     endif
    "   endif
    " endfunction
    " autocmd TextChanged,CursorMoved * call EasyMotionCoc()

   nnoremap <silent> <space>Y  :<C-u>CocList -A --normal yank<cr>

   command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

endif

" minor config
" ------------
" * Gundo
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
