# Neovim Configuration Guide for LLM Agents

This repository contains a modular, well-organized Neovim configuration structure designed for easy maintenance and extension by both humans and LLM agents.

## Repository Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - bootstraps lazy.nvim and loads core config
├── lazy-lock.json              # Lazy.nvim lockfile (auto-generated, commit this)
│
├── lua/
│   ├── config/                 # Core Neovim configuration
│   │   ├── init.lua           # Loads all config modules in order
│   │   ├── options.lua        # Vim options (vim.opt.*)
│   │   ├── keymaps.lua        # Global keymaps (non-plugin specific)
│   │   └── autocmds.lua       # Autocommands and autogroups
│   │
│   └── plugins/                # Plugin specifications organized by category
│       ├── ai.lua             # AI assistants (codecompanion, copilot, etc.)
│       ├── coding.lua         # Coding tools (refactoring, testing, debugging)
│       ├── completion.lua     # Completion engines (nvim-cmp, snippets)
│       ├── editor.lua         # Editor enhancements (treesitter, autopairs, comments)
│       ├── git.lua            # Git integration (gitsigns, fugitive)
│       ├── lsp.lua            # LSP configuration and related plugins
│       ├── navigation.lua     # File navigation (telescope, oil, harpoon)
│       └── ui.lua             # UI plugins (colorscheme, statusline, bufferline)
│
└── after/
    └── ftplugin/              # Filetype-specific settings (optional)
        ├── lua.lua
        ├── python.lua
        └── ...
```

## Design Principles

### 1. Separation of Concerns
- **`config/`** - Core Vim settings, keymaps, and autocommands
- **`plugins/`** - Plugin specifications and configurations
- **`after/ftplugin/`** - Filetype-specific overrides (optional)

### 2. Modular Plugin Organization
Plugins are organized by functional category:
- **ai.lua** - AI-powered coding assistants and code generation
- **coding.lua** - Development tools (refactoring, testing, debugging)
- **completion.lua** - Auto-completion and snippets
- **editor.lua** - Core editing enhancements (syntax, pairs, comments)
- **git.lua** - Version control integration
- **lsp.lua** - Language Server Protocol configuration
- **navigation.lua** - File and buffer navigation
- **ui.lua** - Visual appearance and interface elements

### 3. Lazy Loading Strategy
All plugins use lazy.nvim for optimal startup time:
- Lazy.nvim automatically scans `lua/plugins/` directory
- Each file can return a single plugin spec or an array of specs
- Use event-driven loading (`event`, `ft`, `cmd`, `keys`) when possible

### 4. Configuration Loading Order
1. `init.lua` bootstraps lazy.nvim
2. Sets leader keys (`<Space>` for `mapleader`, `\` for `maplocalleader`)
3. Loads `require("config")` which sequentially loads:
   - `config/options.lua` - Vim options
   - `config/keymaps.lua` - Global keymaps
   - `config/autocmds.lua` - Autocommands
4. Lazy.nvim imports all plugin specs from `lua/plugins/`

## Guidelines for LLM Agents

### Adding New Plugins

1. **Identify the correct category file** based on plugin functionality
2. **Add to existing category file** in `lua/plugins/`
3. **Use lazy loading** where possible (events, commands, keymaps)
4. **Register keymaps with which-key** using `wk.add()` in the plugin's config function
5. **Include descriptions** for all keymaps to improve discoverability

Example:
```lua
-- In lua/plugins/editor.lua
return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "gcc", desc = "Comment line", mode = "n" },
        { "gc", desc = "Comment selection", mode = "v" },
        { "gbc", desc = "Comment block", mode = "n" },
        { "gb", desc = "Comment block selection", mode = "v" },
      })
    end,
  },
}
```

**Important**: When adding plugins with keymaps, always register them with which-key using `wk.add()`. This ensures consistent keymap documentation and better user experience.

### Adding New Global Keymaps

1. **Global keymaps** go in `lua/config/keymaps.lua`
2. **Plugin-specific keymaps** should be registered in the plugin's config using which-key
3. **Always register keymaps with which-key** using `wk.add()` for consistent documentation
4. **Always include a description** for each keymap
5. **Follow existing naming conventions**

Example for global keymaps:
```lua
-- In lua/config/keymaps.lua
local wk = require("which-key")

wk.add({
  { "<leader>w", "<cmd>write<CR>", desc = "Save file" },
  { "<leader>q", "<cmd>quit<CR>", desc = "Quit" },
})
```

Example for plugin-specific keymaps:
```lua
-- In the plugin's config function
config = function()
  local wk = require("which-key")
  wk.add({
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
  })
end
```

### Adding Vim Options

1. **All vim options** go in `lua/config/options.lua`
2. **Group related options** with comments
3. **Use `vim.opt` API** for setting options

Example:
```lua
-- In lua/config/options.lua
-- Terminal colors
opt.termguicolors = true
opt.background = "dark"
```

### Adding Autocommands

1. **All autocommands** go in `lua/config/autocmds.lua`
2. **Create a dedicated augroup** for each logical grouping
3. **Include descriptive comments**

Example:
```lua
-- In lua/config/autocmds.lua
local my_group = augroup("MyCustomGroup", { clear = true })
autocmd("BufWritePre", {
  group = my_group,
  pattern = "*.lua",
  callback = function()
    -- Your logic here
  end,
  desc = "Format Lua files on save",
})
```

### Filetype-Specific Settings

1. **Create a file** in `after/ftplugin/<filetype>.lua`
2. **Use `vim.opt_local`** for buffer-local settings
3. **Use `vim.keymap.set`** with `{ buffer = 0 }` for buffer-local keymaps

Example:
```lua
-- In after/ftplugin/python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
```

## Modification Workflow

### When modifying this configuration:

1. **Read before writing** - Always read the target file before making changes
2. **Maintain consistency** - Follow existing patterns and conventions
3. **Test incrementally** - Verify changes work before proceeding
4. **Update this file** - If structure changes significantly, update CLAUDE.md

### Common Scenarios

#### Scenario 1: User wants to add Telescope
1. Open `lua/plugins/navigation.lua`
2. Uncomment or add Telescope configuration
3. Register keymaps with which-key in the plugin's config function

Example:
```lua
config = function()
  require("telescope").setup()

  local wk = require("which-key")
  wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
  })
end
```

#### Scenario 2: User wants to change leader key
1. Edit `init.lua` and change `vim.g.mapleader`
2. Consider updating keymap descriptions in `lua/config/keymaps.lua`
3. Update which-key group registrations if needed

#### Scenario 3: User wants to add LSP for new language
1. Open `lua/plugins/lsp.lua`
2. Add language server to Mason's `ensure_installed`
3. Add server setup with `lspconfig.<server>.setup()`
4. Register any custom LSP keymaps with which-key

#### Scenario 4: User wants to customize treesitter
1. Open `lua/plugins/editor.lua`
2. Add/modify treesitter configuration
3. Add languages to `ensure_installed`

#### Scenario 5: User wants to add language support (e.g., Bash)
1. **LSP Setup** - Add to `lua/plugins/lsp.lua`:
   - Add language server to Mason's `ensure_installed` array
   - Configure server with `vim.lsp.config("<server_name>", { ... })`
   - Enable server with `vim.lsp.enable("<server_name>")`
2. **Treesitter** - Add to `lua/plugins/editor.lua`:
   - Add language to treesitter's `ensure_installed` array
3. **Linting/Formatting** - Add to `lua/plugins/coding.lua`:
   - Add linter to nvim-lint's `linters_by_ft` configuration
   - Add formatter to conform.nvim's `formatters_by_ft` configuration
   - Add tools to mason-tool-installer's `ensure_installed` array
4. **Filetype Settings** (optional) - Create `after/ftplugin/<filetype>.lua`:
   - Set buffer-local options with `vim.opt_local`
   - Add buffer-local keymaps with `{ buffer = 0 }`
   - Register keymaps with which-key using `buffer = 0` parameter

Example structure for bash support:
```lua
-- In lua/plugins/lsp.lua (ensure_installed)
ensure_installed = { "bashls", ... }

-- In lua/plugins/lsp.lua (config function)
vim.lsp.config("bashls", {
  capabilities = capabilities,
  filetypes = { "sh", "bash" },
})
vim.lsp.enable("bashls")

-- In lua/plugins/coding.lua (conform.nvim)
formatters_by_ft = {
  bash = { "shfmt" },
}

-- In lua/plugins/coding.lua (nvim-lint)
linters_by_ft = {
  bash = { "shellcheck" },
}

-- In after/ftplugin/bash.lua
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
```

## Plugin Management with lazy.nvim

### Useful Commands
- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy clean` - Remove unused plugins
- `:Lazy update` - Update all plugins
- `:Lazy profile` - Profile startup time

### Plugin Spec Reference

```lua
{
  "author/plugin-name",           -- Plugin repository
  branch = "main",                 -- Git branch (optional)
  tag = "v1.0.0",                  -- Git tag (optional)
  commit = "abc123",               -- Specific commit (optional)
  version = "^1.0",                -- Version constraint (optional)

  -- Lazy loading triggers
  lazy = true,                     -- Don't load on startup
  event = "VeryLazy",              -- Load on event
  cmd = "CommandName",             -- Load on command
  ft = "lua",                      -- Load on filetype
  keys = { ... },                  -- Load on keymap

  -- Configuration
  opts = { ... },                  -- Passed to plugin's setup()
  config = function() ... end,     -- Custom setup function

  -- Dependencies
  dependencies = { ... },          -- Required plugins

  -- Build steps
  build = "make",                  -- Run after install/update
}
```

## Best Practices

### For LLM Agents:

1. **Read existing code first** - Understand current patterns before adding new code
2. **Maintain structure** - Keep plugins in appropriate category files
3. **Use lazy loading** - Optimize startup time with proper event triggers
4. **Register all keymaps with which-key** - Use `wk.add()` for consistent documentation
5. **Include descriptions** - All keymaps should have `desc` field
6. **Test configuration** - Verify Neovim can load without errors
7. **Be conservative** - Don't add unnecessary plugins or features
8. **Follow conventions** - Match existing code style and organization
9. **Document changes** - Add comments for complex configurations
10. **Avoid duplication** - Check if functionality already exists
11. **Respect user preferences** - Ask before making opinionated changes

### For Humans:

1. **Commit `lazy-lock.json`** - Ensures reproducible plugin versions
2. **Review changes carefully** - Use `:Lazy profile` to check startup impact
3. **Keep it organized** - Create new category files only when necessary
4. **Back up regularly** - Version control is your friend
5. **Test incrementally** - Add one plugin/feature at a time

## Troubleshooting

### Configuration won't load
1. Check for syntax errors: `:messages`
2. Verify file paths are correct
3. Ensure all `require()` statements are valid

### Plugin not loading
1. Check lazy.nvim UI: `:Lazy`
2. Verify lazy loading triggers are correct
3. Check for dependency issues

### Keymaps not working
1. Verify leader key is set before keymaps load
2. Check for conflicting keymaps: `:map <key>`
3. Ensure plugin is loaded before its keymaps

### LSP not working
1. Check if language server is installed: `:Mason`
2. Verify server is set up in `lua/plugins/lsp.lua`
3. Check LSP logs: `:LspLog`

## Resources

- [lazy.nvim documentation](https://github.com/folke/lazy.nvim)
- [Neovim API documentation](https://neovim.io/doc/user/api.html)
- [Neovim Lua guide](https://neovim.io/doc/user/lua-guide.html)
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer

## Current Configuration

### Installed Plugins

#### Core Plugins
- **which-key.nvim** - Keymap discovery and documentation (pinned to latest version)
- **claudecode.nvim** - AI coding assistant with Claude Code CLI integration
- **nvim-treesitter** - Syntax highlighting and code understanding
- **mason.nvim** - LSP/DAP/linter/formatter package manager
- **nvim-lspconfig** - LSP configuration framework
- **snacks.nvim** - Collection of QoL plugins (gitbrowse, bufdelete, terminal, smooth scroll)

#### Development Tools
- **conform.nvim** - Code formatter plugin
- **nvim-lint** - Linter integration plugin
- **mason-tool-installer.nvim** - Auto-install formatters and linters
- **kube-utils-nvim** - Kubernetes and Helm operations

#### Completion
- **blink.cmp** - Completion engine with LSP support

### Language Support

#### Bash/Shell Scripting
Complete bash development environment with:
- **LSP**: `bashls` (bash-language-server) with shellcheck integration
- **Linting**: `shellcheck` via nvim-lint (auto-lints on save/edit)
- **Formatting**: `shfmt` via conform.nvim (format on save, 2-space indent)
- **Syntax**: Treesitter bash parser for accurate highlighting
- **Filetypes**: `.sh`, `.bash`, `.inc`, `.command` files

Bash-specific keymaps (buffer-local in `after/ftplugin/bash.lua`):
- `<leader>rx` - Make executable and run
- `<leader>rr` - Run with bash
- `<leader>rs` - Run shellcheck
- `<leader>cf` - Format buffer
- `<leader>cl` - Lint buffer

#### Lua
- **LSP**: `lua_ls` with Neovim API awareness
- **Syntax**: Treesitter lua parser

#### TypeScript/JavaScript
- **LSP**: `ts_ls` with inlay hints
- **Syntax**: Treesitter parsers for TS/JS

#### YAML/Helm/Kubernetes
- **LSP**: `yamlls` with Kubernetes schemas, `helm_ls` for Helm templates
- **Syntax**: Treesitter parsers for YAML, Helm, and Go templates
- **Tools**: kube-utils-nvim for K8s operations

### Leader Keys
- `<Space>` - Main leader key
- `\` - Local leader key

### Which-Key Configuration
The configuration includes pre-configured leader key groups:
- `<leader>a` - AI
- `<leader>b` - Buffers
- `<leader>c` - Code (includes formatting/linting)
- `<leader>d` - Debug
- `<leader>f` - Find
- `<leader>g` - Git
- `<leader>h` - Helm operations
- `<leader>k` - Kubernetes operations
- `<leader>l` - LSP
- `<leader>r` - Run (buffer-local for bash files)
- `<leader>s` - Search
- `<leader>t` - Terminal
- `<leader>w` - Window
- `<leader>x` - Diagnostics

### Notable Features
- Line numbers with relative numbering
- Smart case-insensitive search
- Automatic trailing whitespace removal
- Highlight on yank
- Sensible split and tab management keymaps
- Diagnostic navigation keymaps
- System clipboard integration
- Interactive keymap discovery with which-key
- Floating terminal popup via snacks.nvim (`<leader>tp`)
- Smooth scrolling animations via snacks.nvim

### Terminal Configuration
The configuration includes a floating terminal powered by snacks.nvim:
- **Toggle keymap**: `<leader>tp` - Toggle floating terminal popup
- **Window style**: Floating window with rounded borders (80% width/height)
- **Interactive mode**: Auto-insert, auto-close enabled by default
- **Default keymaps** (in terminal):
  - `q` - Hide terminal (terminal persists)
  - `Esc` (double-tap) - Exit insert mode
  - `gf` - Open file under cursor
- **Features**: Terminal sessions persist when hidden, allowing quick toggle back to the same session

### Scroll Configuration
Smooth scrolling is enabled via snacks.nvim scroll module:
- **Primary animation**: 200ms total duration with 10ms steps (linear easing)
- **Repeat animation**: 50ms total duration with 5ms steps for faster repeated scrolls
- **Behavior**: Properly handles `scrolloff` and mouse scrolling
- **Buffer filtering**: Automatically excludes terminal buffers from smooth scrolling
- **Control methods**:
  - `:lua Snacks.scroll.enable()` - Enable smooth scrolling
  - `:lua Snacks.scroll.disable()` - Disable smooth scrolling

## Contributing

When working with LLM agents:
1. Provide clear, specific instructions
2. Review generated code before applying
3. Test changes incrementally
4. Keep this CLAUDE.md file updated with significant structural changes

## Which-Key Usage Reference

### Basic Keymap Registration

```lua
local wk = require("which-key")

-- Simple keymap
wk.add({
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
})

-- With group
wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
})

-- Multiple modes
wk.add({
  { "gc", desc = "Comment", mode = { "n", "v" } },
})

-- Buffer-local keymaps
wk.add({
  { "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover", buffer = 0 },
})
```

### Pre-configured Groups
The following leader key groups are already configured and should be used consistently:
- `<leader>a` - AI assistants and code generation
- `<leader>b` - Buffer operations
- `<leader>c` - Code actions and operations
- `<leader>d` - Debugging
- `<leader>f` - Finding/searching files
- `<leader>g` - Git operations
- `<leader>l` - LSP actions
- `<leader>s` - Search operations
- `<leader>t` - Terminal operations
- `<leader>w` - Window management
- `<leader>x` - Diagnostics

---

**Last Updated**: 2025-11-11
**Neovim Version**: 0.9+
**Plugin Manager**: lazy.nvim
**Keymap Manager**: which-key.nvim
