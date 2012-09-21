# Installation

If necessary, backup <tt>~/.vim</tt> directory to i.e. <tt>~/.vim-old</tt> and

    git clone git://github.com/dkoprov/vimconfig.git
Don't forget to change the nikname to yours in the line above.
I prefer to keep all git repositories in one place, i.e. in /projects directory, so
I created a symlink to this repository:

    ln -sF ~/projects/github/vimconfig ~/.vim
But you may do what you prefer. Some people clone repository right into ~/.vim directory. It's up to you.
Then <tt>git pull</tt> but since git submodules is used here, you also need to <tt>git submodule init</tt>
and <tt>git submodule update</tt>

After all have updated, link your vimrc and gvimrc files.
<tt>.vimrc</tt>:

    ln -s ~/.vim/vimrc ~/.vimrc
<tt>.gvimrc</tt>:

    ln -s ~/.vim/gvimrc ~/.gvimrc

You're ready to go!

# Included Plugins

See the plugins' web pages for more information. The keybindings listed are mostly
just those defined or overridden locally, not the ones provided by default.

Plugins are installed in their own directories under <tt>bundle</tt>, thanks to
[Pathogen](http://www.vim.org/scripts/script.php?script_id=2332).

## ack (0.3.1)

Plugin for the Perl module / CLI script 'ack' ([more](http://www.vim.org/scripts/script.php?script_id=2572))

## bufexplorer (7.2.8)

Buffer explorer/browser ([more](http://www.vim.org/scripts/script.php?script_id=42))

*Keybindings*

<dl>
  <dt>,.</dt><dd>Show buffer explorer</dd>
</dl>

## Coffeescript (fd170cb - 13 June 2011)

Adds support for CoffeeScript. It handles syntax, indenting, and compiling ([more](http://www.vim.org/scripts/script.php?script_id=3590))

## endwise (1.0)

Wisely add "end" in ruby, endfunction/endif/more in vim script, etc ([more](http://www.vim.org/scripts/script.php?script_id=2386))

## Extradite (4602089 - 2 March 2011)

Brings up the commit log of the current file. In the log view ([more](http://int3.github.com/vim-extradite/))

*Keybindings*

<dl>
  <dt>,x</dt><dd>Open commit history for current file</dd>
</dl>

## Fugitive (1.2)

A Git wrapper so awesome, it should be illegal ([more](http://www.vim.org/scripts/script.php?script_id=2975))

## markdown

Syntax highlighting for Markdown ([more](http://plasticboy.com/markdown-vim-mode/))

## NERD_tree (4.1.0)

A tree explorer plugin for navigating the filesystem ([more](http://www.vim.org/scripts/script.php?script_id=1658))

*Keybindings*

<dl>
  <dt>,m</dt><dd>Show/hide NERDTree</dd>
  <dt>,f</dt><dd>Show current file in tree</dd>
</dl>

## nerdcommenter (2.3.0)

A plugin that allows for easy commenting of code for many filetypes ([more](http://www.vim.org/scripts/script.php?script_id=1218))

## rails (4.3)

Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more ([more](http://www.vim.org/scripts/script.php?script_id=1567))

*Keybindings*

<dl>
  <dt>,r</dt><dd>run rake</dd>
</dl>

## repeat (1.0)

Use the repeat command (.) with supported plugins ([more](http://www.vim.org/scripts/script.php?script_id=2136))

## ruby (7bee8d0 - 8 August, 2011)

Ruby support (newer than the version released with vim). ([more](https://github.com/vim-ruby/vim-ruby))

## surround (1.90)

Delete/change/add parentheses/quotes/XML-tags/much more with ease ([more](http://www.vim.org/scripts/script.php?script_id=1697))

## syntastic (1.2.0)

Automatic syntax checking ([more](http://www.vim.org/scripts/script.php?script_id=2736))

## unimpaired (1.1)

Pairs of handy bracket maps ([more](http://www.vim.org/scripts/script.php?script_id=1590))

## ZoomWin (23)

Zoom in/out  of windows (toggle between one window and multi-window) ([more](http://www.vim.org/scripts/script.php?script_id=508))

*Keybindings*

<dl>
  <dt>,z</dt><dd>Zoom</dd>
</dl>

# Other Keybindings

<dl>
  <dt>ctrl-]</dt><dd>Jump to definition (requires [exuberant ctags](http://blog.tobiascrawley.net/2009/01/01/generating-a-tags-file-from-a-git-hook/))</dd>
  <dt>,c</dt><dd>Show/hide hidden characters</dd>
  <dt>,h</dt><dd>Hide search highlighting</dd>
  <dt>,s</dt><dd>Show/hide spelling errors</dd>
  <dt>,sw</dt><dd>Strip trailing whitespace</dd>
  <dt>,w</dt><dd>Toggle word wrapping</dd>
</dl>
