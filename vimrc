set nocompatible

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" Current line highlight
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Set encoding
set encoding=utf-8

set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P%#warningmsg#%{SyntasticStatuslineFlag()}%*
set laststatus=2  " Always show status line.

" Line numbers
set number 

" Set solarized dark color for terminal vim
color jellybeans

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

set visualbell
set mousehide
set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set ruler
set nowrap

set timeoutlen=500
set history=1000

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

let mapleader = ","

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set list listchars=tab:\ \ ,trail:·

set backspace=start,indent,eol
autocmd FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Summon git commits hystory on current file
map <Leader>x :Extradite! <CR>

" No bloody backups anymore!
set nobackup
set nowritebackup
set noswapfile

" NERDTree hidden files filter
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '\.DS_Store', '\.sass-cache', '\.svn', '\.idea', '\.gitkeep']
let NERDTreeShowHidden = 1

" RVM options for ruby debugger
let g:ruby_debugger_spec_path = '$GEM_HOME/bin/spec'
let g:ruby_debugger_cucumber_path = '$GEM_HOME/bin/cucumber'

" ,c to show hidden characters
"set listchars=tab:>-,trail:·,eol:$
"nmap <silent> <leader>c :set nolist!<CR>

" Highlight trailing whitespace
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

" ,h to toggle search result highlighting
map <silent> <leader>h :set hls!<CR>

" ,w to toggle line wrap
map <silent> <Leader>w :set wrap!<CR>

" ,u to toggle undo history browser
map <Leader>u :GundoToggle<CR>

" ,m toggle NERDTree
map <silent> <Leader><Leader> :NERDTreeToggle<CR>

" ,f to find current file in NERDTree
map <silent> <Leader>f :NERDTreeFind<CR>


" BufExplorer
map <silent> <unique> <Leader>. :BufExplorerHorizontalSplit<CR>

" Kwbd configuration
map <Leader>w :Kwbd<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A whole bunch of NERDTree configuration stolen from carlhuda's janus

autocmd VimEnter * call s:NERDTreeIfDirectory(expand("<amatch>"))
autocmd VimEnter * wincmd p
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

"Disable netrw's autocmd, since we're ALWAYS using NERDTree
runtime plugin/netRwPlugin.vim
augroup FileExplorer
  au!
augroup END

let g:NERDTreeHijackNetrw = 0

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory (including implicit '.'), open NERDTree
function s:NERDTreeIfDirectory(directory)
  if isdirectory(a:directory) || a:directory == ""
    NERDTree
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  if isdirectory(a:directory)
    call ChangeDirectory(a:directory)
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(stay)
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      NERDTree
      if !a:stay
        wincmd p
      end
    endif
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . a:dir
  let stay = exists("a:1") ? a:1 : 1
  call s:UpdateNERDTree(stay)
endfunction

function Touch(file)
  execute "!touch " . a:file
  call s:UpdateNERDTree(1)
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . a:file
  endif
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . a:file

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . a:file)}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(system("dirname " . a:file), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" end of the NERDTree configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tabular
vnoremap <silent> <Leader>tt :call Tabularize('/\|/')<CR>

" Folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=3     "deepest fold is 3 levels
set nofoldenable

" Jump to last cursor position when opening a file
" Don't do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal g`\""
    endif
  end
endfunction

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" strip trailing whitespace<foo&bar>
function! StripTrailingWhitespace()
	normal mz
	normal Hmy
	exec '%s/\s*$//g'
	normal 'yz<cr>
	normal `z
endfunction
nmap <silent> <Leader>sw :call StripTrailingWhitespace()<CR>

let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=0
let g:syntastic_auto_loc_list=1

" Alternatives to ESC
inoremap jjj <ESC>
inoremap kkk <ESC>

" Align =>
vnoremap <silent> <Leader>t> :Align =><CR>

" It's not like :W is bound to anything anyway.
command! W :w

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
