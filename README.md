# Pythondoc - Python Documentation Browser

Python official API documentation at your fingertips in Vim or Neovim.

Autocomplete and search Python API using `:help` and `:helpgrep` commands. Open [official API
documentation](https://docs.python.org/3/) within Vim and lookup function
signatures, example code, topics, or howto guides. Use the comprehensive tags
database to target specific topics or function calls to browse.

This plugin is not related to the lousy _pydoc_. The quality of information is
comparable to [Dash](https://kapeli.com/dash) or [Zeal](https://zealdocs.org/).

The help files are generated from the official Python repository using the
[official tool](https://www.sphinx-doc.org/en/master/)
and [extension](https://github.com/girishji/vimbuilder). Tags appear in
`function()..topic.pyx` format. You can open the topic by typing `:h topic.pyx`.
With `wildmenu` enabled, when you type `:h foo<tab>` it will complete functions, methods, classes,
attributes, topics, etc. which start with letters `foo`. You can also enable fuzzy
completion. Python library document, howto guides, and tutorial are tokenized.

This plugin provides `:Help` command which searches only Python tags. It is
a filter on top of builtin `:help` command. Vim adds a `@py` suffix to Python
tags (unless `helplang` variable is set to `py`) which makes it easy to distinguish.


## Requirements

- Vim
- Neovim

## Installation

Install using [vim-plug](https://github.com/junegunn/vim-plug). Put the
following lines in `.vimrc` file.

```
call plug#begin()
Plug 'girishji/pythondoc.vim'
call plug#end()
```

Or use Vim's builtin package manager.

Neovim users could use [Lazy](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
  { "girishji/pythondoc.vim", opts = {} },
})
```

## Usage

Use `:help <tag>`. It works for both Vim and Nvim. In Vim you can also use
`:Help <tag>`. It filters only Python documentation.

In Vim, if you set `g:pythondoc_h_expand = 1`, you can use `:h <tag>` instead of `:Help <tag>`.
Add

```vim
exe 'nnoremap <buffer> dK :<c-u>Help <c-r><c-w>'..nr2char(&wildcharm)
```

to `ftplugin/python.vim` to search for the keyword under the cursor by hitting `dK`.

This is easier to type. If you decide to put all our settings in after/ftplugin directory, then setting the above global variable is done too late. You could do the following:

```
import 'pythondoc_abbrev.vim' as abbrev
abbrev.ExpandH()
```

You can activate the `wildmenu` for <Tab> completion. You can type `:Help foo<tab>`
for completion suggestions.

```
:set wildchar=<Tab>
:set wildmenu
:set wildmode=full
:set wildoptions+=pum
```

Optionally, you can `:set wildoptions+=fuzzy`.

## Demo

[![asciicast](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj.svg)](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj)

Demo uses [autosuggest](https://github.com/girishji/autosuggest.vim) plugin,
but <Tab> completion using `wildmenu` works the same.

## Note to Maintainers

This plugin is created for personal use. I plan to keep the documentation up to
date with new Python releases. However, here are
the steps to generate help files from official Python repository.

- Clone this plugin in your workspace
- Create a `tmp` directory
- Clone [Python repository](https://github.com/python/cpython) into `tmp`
- Create virtual environment using the official makefile (`make venv` inside `pythondoc.vim/tmp/cpython/Doc`)
- Add "vimbuilder" to `requirements.txt` file
- Set `vimhelp_filename_extension = 'pyx'` in conf.py file
- Edit the Makefile in `Doc` directory to
    * Create a new target 'vimhelp' akin to one of the existing targets like 'html' or 'text'
    * (Optional) Comment out lines related to `Blurb` or `NEWS` to avoid a harmless error at the end
- (Recommended) Rename `rst` files in `howto` directory by prepending `howto-` to filenames
    * Edit `howto/howto-index.rst` and `content.rst` to reflect filenames change
- Generate Vim help files (`make vimhelp`)
- Copy `pyx` files from `build/vimhelp/[library|howto]` to `doc` directory
- Generate tags from main directory: `vim "+helptags ./doc | q"`

