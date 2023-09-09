# Pythondoc - Python Documentation Browser

Python official API documentation at your fingertips in Vim or Neovim.

Autocomplete and search Python API using `:help` and `:helpgrep` commands. Open [official API
documentation](https://docs.python.org/3/) within Vim and lookup function
signatures, example code, topics, or howto guides.

This plugin is not related to the lousy _pydoc_. The help files are generated
from the official Python repository using the [offical tool](https://www.sphinx-doc.org/en/master/)
and [extension](https://github.com/girishji/vimbuilder). The quality of
information is akin to [Dash](https://kapeli.com/dash) or
[Zeal](https://zealdocs.org/).

## Requirements

- Vim
- Neovim

## Installation

Install using [vim-plug](https://github.com/junegunn/vim-plug).

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

Python help tags look different from Vim help when you use `:help`. Python tags
have a topic (filename) suffixed to the tag. Activate the `wildmenu` for <Tab> completion.

```
:set wildchar=<Tab>
:set wildmenu
:set wildmode=full
:set wildoptions+=pum
```

Optionally, you can also `:set wildoptions+=fuzzy`.

## Demo

[![asciicast](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj.svg)](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj)

Demo uses [autosuggest]() plugin, but <Tab> completion using `wildmenu` works the same.

## Note to Maintainers

This plugin is created for personal use. I plan to keep the documentation up to
date with new Python releases. However, here are
the steps to generate help files from official Python repository.

- Clone this plugin in your workspace
- Create a `tmp` directory
- Clone [Python repository](https://github.com/python/cpython) into `tmp`
- Create virtual environment using the official makefile (`make venv` inside `pythondoc.vim/tmp/cpython/Doc`)
- Install [vimbuilder] plugin inside the virtual environment (`venv/bin/pip3 install vimbuilder`)
- Edit the Makefile in `Doc` directory
    * Create a new target 'vimhelp' akin to one of the existing targets like 'html' or 'text'
    * (Optional) Comment out lines related to `Blurb` or `NEWS` to avoid a harmless error at the end
- Rename `rst` files in `howto` directory by prepending `howto-` to filenames
- Edit `howto/howto-index.rst` and `content.rst` to reflect filenames change
- Generate Vim help files (`make vimhelp`)
- Copy `txt` files from `build/vimhelp/[library|howto]` to `doc` directory of this plugin
