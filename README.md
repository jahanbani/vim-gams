# vim-gams

A modern Vim/Neovim plugin for GAMS (General Algebraic Modeling System) syntax highlighting and development support.

## Features

- ✨ **Comprehensive syntax highlighting** for GAMS files (`.gms`)
- 🎯 **Smart indentation** with GAMS-aware formatting
- 🔍 **Enhanced commenting** with proper GAMS comment syntax
- 📁 **File type detection** for `.gms` and `.lst` files
- 🎨 **Modern color schemes** support
- 📝 **TODO highlighting** in comments
- 🔧 **Configurable options** for customization

## Installation

### Using a plugin manager (recommended)

#### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'jahanbani/vim-gams'
```

#### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use 'jahanbani/vim-gams'
```

#### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
  'jahanbani/vim-gams',
  config = function()
    -- Optional: Configure plugin options
    vim.g.gams_enable_lst_highlighting = true
    vim.g.gams_highlight_equation_components = true
  end
}
```

### Manual installation
```bash
git clone https://github.com/jahanbani/vim-gams.git ~/.vim/pack/plugins/start/vim-gams
```

## Configuration

### Global Options

Add these to your `.vimrc` or `init.lua`:

```vim
" Enable LST file highlighting (default: true)
let g:gams_enable_lst_highlighting = 1

" Highlight sets/parameters/variables in equations (default: true)
let g:gams_highlight_equation_components = 1

" Custom comment character (default: '*')
let g:gams_comment_char = '*'

" Enable enhanced indentation (default: true)
let g:gams_smart_indent = 1
```

### Neovim Lua Configuration

```lua
-- Configure vim-gams
vim.g.gams_enable_lst_highlighting = true
vim.g.gams_highlight_equation_components = true
vim.g.gams_comment_char = '*'
vim.g.gams_smart_indent = true
```

## Usage

### Basic Usage
1. Open any `.gms` file
2. Syntax highlighting will be automatically applied
3. Use `*` at the beginning of lines for comments
4. Smart indentation works with GAMS keywords

### Key Features
- **Comments**: Use `*` at line start or `#` for inline comments
- **Indentation**: Automatic indentation for GAMS declarations
- **Folding**: Code folding for declarations and equations
- **Dollar Commands**: Syntax highlighting for `$include`, `$load`, etc.

## File Types Supported

- `.gms` - GAMS model files
- `.lst` - GAMS listing files (optional)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## TODO

- [ ] Add highlighting for LST files
- [ ] Highlight sets/parameters/variables in equations
- [ ] Add LSP support for GAMS
- [ ] Implement tree-sitter grammar
- [ ] Add snippet support
- [ ] Create modern color scheme

## License

MIT License - see LICENSE file for details.

## Acknowledgments

- Original syntax highlighting by the GAMS community
- Modern improvements and maintenance by contributors
