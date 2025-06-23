# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration using Lazy.nvim as the plugin manager. The configuration is organized into modular Lua files with clear separation of concerns:

- `init.lua` - Entry point that initializes Lazy.nvim and loads other modules
- `lua/plugins_lazy.lua` - Plugin specifications for Lazy.nvim
- `lua/settings.lua` - General Vim settings and options
- `lua/keymappings.lua` - Key mappings using which-key
- `lua/pluginconfigs.lua` - Plugin configurations
- `lua/lspmappings.lua` - LSP-specific key mappings and autocommands
- `lua/utils.lua` - Utility functions for configuration

## Key Components

### Plugin Management
- Uses Lazy.nvim with plugins defined in `lua/plugins_lazy.lua`
- Supports local development plugins (gcloudrun.nvim in ~/Development)
- Plugins are loaded with lazy loading strategies for performance

### LSP Setup
- Mason for LSP server management
- Custom LSP configurations for Go (gopls), Helm (helm_ls), and Laravel (laravel_ls)
- UFO plugin for enhanced folding with LSP support
- Lspsaga for enhanced LSP UI

### Key Features
- Telescope for fuzzy finding with live grep args extension
- TreeSJ for splitting/joining code structures
- Spectre and SSR for search and replace
- Multiple cursor support with vim-visual-multi
- Git integration with Fugitive, Gitsigns, and Diffview
- AI integration with ChatGPT (gp.nvim) and GitHub Copilot
- Database support with vim-dadbod

### Theme and UI
- GitHub dark theme as default
- Lualine statusline with bufferline
- NvimTree file explorer
- Scrollbar with git signs integration
- Statuscol for enhanced status column

## Development Commands

Since this is a Neovim configuration, there are no traditional build/test commands. Configuration changes are applied by:

1. Reloading Neovim (`:qa` and restart)
2. Using `:Lazy sync` to update plugins
3. Using `:Mason` to manage LSP servers

## File Structure Patterns

- Plugin specifications use lazy loading with `event`, `ft`, `dependencies`
- Key mappings use which-key groups for organization
- LSP configurations use Mason handlers for consistent setup
- Autocommands are grouped for easy management

## Important Notes

- Leader key is set to space
- Custom development plugin (gcloudrun.nvim) is loaded from ~/Development
- Formatter configurations for Lua (stylua), PHP (php-cs-fixer), TypeScript/JavaScript (prettier)
- Go-specific configuration with custom gopls path and logging