if has("gui_macvim")
  set fuoptions=maxhorz,maxvert

  set guifont=Menlo:h16
  set anti

  set background=light
  color sweyla_g_dark

  " Debugger settings
  let g:ruby_debugger_progname = 'mvim'
  map <Leader>dg :Rdebugger<CR>
  map <Leader>dr :RdbTest<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Command-Option-ArrowKey to switch viewports
  map <S-D-Up> <C-w>k
  imap <S-D-Up> <Esc> <C-w>k
  map <S-D-Down> <C-w>j
  imap <S-D-Down> <Esc> <C-w>j
  map <S-D-Right> <C-w>l
  imap <S-D-Right> <Esc> <C-w>l
  map <S-D-Left> <C-w>h
  imap <S-D-Left> <C-w>h

  " Adjust viewports to the same size
  map <Leader>= <C-w>=
  imap <Leader>= <Esc> <C-w>=
endif

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T


" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
