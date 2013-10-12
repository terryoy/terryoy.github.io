# Preferences for Vim

- date: 2013-09-23 23:16
- tags: linux, vim
- category: tricks

-----------------------------

These are settings that to improve usage of VI text editor for various purposes.

Copy & paste below lines to __*~/.vimrc*__:

```
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
```

1. smartindent - Do smart autoindenting when starting a new line for C-like programs.
2. tabstop - Number of spaces that a <Tab> in the file counts for.
3. shiftwidth - Number of spaces to use for each step of (auto)indent.
4. expandtab - Spaces are used in indents with <Tab>.

For color scheme preferences:

```
colorscheme torte
```

It is the default black/white scheme.
