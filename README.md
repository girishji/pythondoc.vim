# Pythondoc - Python Documentation Browser for Vim/Neovim

Access the complete Python official API documentation directly within your editor. Search, browse, and autocomplete Python API documentation using Vim's native `:help` and `:helpgrep` commands.

## Features

- Browse [official Python API documentation](https://docs.python.org/3/) without leaving your editor
- Search function signatures, example code, topics, tutorials, and howto guides
- Comprehensive tags database for precise documentation lookup
- High-quality documentation comparable to [Dash](https://kapeli.com/dash) or [Zeal](https://zealdocs.org/)
- Full integration with Vim's help system
- Fuzzy search support

[![Demo Video](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj.svg)](https://asciinema.org/a/vRjU8x5KjkES4RX5BLJixqcQj)

## Requirements

- Vim or Neovim

## Installation

Install via [vim-plug](https://github.com/junegunn/vim-plug), [lazy](https://github.com/folke/lazy.nvim) or Vim's built-in package manager.

<details>
<summary><b>Show installation instructions</b></summary>

### Using vim-plug

Add to your `.vimrc`:

```vim
call plug#begin()
Plug 'girishji/pythondoc.vim'
call plug#end()
```

### Using Neovim's [Lazy](https://github.com/folke/lazy.nvim)

Add to your Lua config:

```lua
require("lazy").setup({
  { "girishji/pythondoc.vim", opts = {} },
})
```

### Using Vim's built-in package manager

#### Linux

```bash
git clone https://github.com/girishji/pythondoc.vim.git $HOME/.vim/pack/downloads/opt/pythondoc.vim
```

Then add this line to your _vimrc_ file:

```vim
packadd vimsuggest
```

#### Windows

```bash
git clone https://github.com/girishji/pythondoc.vim.git %USERPROFILE%\vimfiles\pack\downloads\opt\pythondoc.vim
```

Then add this line to your _vimrc_ file:

```vim
packadd vimsuggest
```

</details>

## Basic Usage

### Core Commands

```vim
:help <tag>     " Access all helpfiles (Python and Vim)
:Help <tag>     " Python-specific documentation
```

### Quick Customization Guide

1. Enable shorthand `:h` command:

```vim
" In vimrc
let g:pythondoc_h_expand = 1
```

2. Add keyboard shortcut for cursor word lookup:

```vim
" In ftplugin/python.vim
exe 'nnoremap <buffer> dK :<c-u>Help <c-r><c-w>'..nr2char(&wildcharm)
```

3. Configure tab completion (:h 'wildmenu'):

```vim
" Enhanced completion settings
set wildchar=<Tab>      " Use Tab for completion
set wildmenu            " Enable completion menu
set wildmode=full       " Complete first full match
set wildoptions+=pum    " Use popup menu
set wildoptions+=fuzzy  " Optional: Enable fuzzy matching
```

### Tag Format
- Python tags include `@py` suffix in Vim (unless `helplang` is set to `py`)
- Makes Python documentation easily distinguishable
- Format: `function()..topic.pyx` (Open the topic by typing `:h topic.pyx`)

## For Maintainers

The help files are generated from the official Python repository using the [official tool](https://www.sphinx-doc.org/en/master/)  and [extension](https://github.com/girishji/vimbuilder).

Here are the steps to generate help files:

1. **Setup:**
   ```bash
   # Clone repositories
   git clone https://github.com/girishji/pythondoc.vim
   mkdir tmp
   git clone https://github.com/python/cpython tmp/
   ```

2. **Create Python Environment:**
   ```bash
   cd pythondoc.vim/tmp/cpython/Doc
   make venv
   ```

3. **Configure Build:**
   - Add "vimbuilder" to `requirements.txt`
   - Set in conf.py: `vimhelp_filename_extension = 'pyx'`
   - Modify Doc/Makefile:
     - Add 'vimhelp' target (similar to 'html' or 'text')
     - Optional: Comment out Blurb/NEWS lines to avoid harmless errors

4. **Prepare Documentation:**
   - Rename howto/*.rst files: prepend 'howto-'
   - Update references in (to reflect change of file name):
     - howto/howto-index.rst
     - content.rst

5. **Generate Documentation:**
   ```bash
   make vimhelp
   cp build/vimhelp/{library,howto}/*.pyx doc/
   vim "+helptags ./doc | q"
   ```

This plugin is maintained for personal use but aims to stay current with Python releases.
