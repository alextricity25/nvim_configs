## Executive Summary

Based on current best practices for 2025, the optimal Neovim setup for PHP Laravel development involves a combination of powerful LSP servers, Laravel-specific tooling, and modern formatting/analysis tools. The ecosystem has matured significantly, with several production-ready options available.

---

## 1. Language Server Protocol (LSP)

### Primary LSP Options

#### **Intelephense** (Recommended for Production)
- **Type**: Commercial (freemium model)
- **Cost**: $25 USD lifetime license for premium features
- **Pros**:
  - Superior handling of Laravel's "magic" methods and features
  - Fewer false-positive diagnostics
  - Single license works across all LSP-compatible editors
  - More stable and feature-complete
  - Better autocomplete for Laravel facades and helpers
- **Cons**:
  - Requires payment for advanced features (renaming, code actions)
  - Closed source
- **Free Features**: Basic autocomplete, go-to-definition, hover information
- **Premium Features**: Variable renaming, code actions, advanced refactoring

#### **Phpactor** (Free Alternative)
- **Type**: Open source
- **Cost**: Free
- **Pros**:
  - Completely free and open source
  - Active development with frequent releases
  - Includes refactoring and code transformation tools
  - Can be used alongside Intelephense (see below)
  - Built-in support for PHPStan and Psalm integration
- **Cons**:
  - Struggles more with Laravel's magic methods and missing types
  - May produce more diagnostic noise without proper configuration
  - Less polished experience out of the box
- **Best For**: Learning Laravel, budget-conscious developers, those who value open source

### Recommended Approach

Many developers use a **hybrid setup**:
- **Intelephense** as the primary LSP for completions and diagnostics
- **Phpactor** as a companion for code actions and refactoring tools
- This provides the best of both worlds: Intelephense's superior Laravel support + Phpactor's powerful refactoring capabilities

---

## 2. Essential Laravel Tooling

### Laravel IDE Helper (Critical)
- **Package**: `barryvdh/laravel-ide-helper`
- **Installation**: `composer require --dev barryvdh/laravel-ide-helper`
- **Purpose**: Generates helper files that dramatically improve LSP accuracy
- **Commands**:
  - `php artisan ide-helper:generate` - Generate facades/helpers
  - `php artisan ide-helper:models --write` - Generate model annotations
  - `php artisan ide-helper:meta` - Generate PhpStorm meta file
- **Benefits**:
  - Solves most LSP diagnostic errors
  - Provides accurate autocomplete for models, facades, and helpers
  - Essential for both Intelephense and Phpactor
  - Generated files should be added to `.gitignore`

### Neovim Laravel Plugins

#### **laravel.nvim** by adalessa (Most Feature-Rich)
- **Features**:
  - **Model Info**: Shows database, table, and field information directly on model files
  - **Route Info**: Displays URI, method, and middleware on controller functions
  - **Artisan Integration**: Run artisan commands with fuzzy search (`<leader>la`)
  - **Route Listing**: View all routes (`<leader>lr`)
  - **Composer Info**: Check installed versions and available updates
  - **Telescope Integration**: Enhanced development workflow
  - **Tinker Support**: Interactive REPL with dedicated UI
  - **Completion Source**: Integrates with nvim-cmp
  - **Resource Pickers**: Quick navigation to routes, models, views
- **Dependencies**: Requires Telescope for optimal functionality
- **Integration**: Works with treesitter for intelligent PHP parsing

#### **laravel.nvim** by adibhanna
- **Features**:
  - Built-in IDE Helper management commands
  - Smart navigation and autocompletion
  - Lighter weight alternative
- **Commands**:
  - `:LaravelInstallIdeHelper`
  - `:LaravelIdeHelperCheck`
  - `:LaravelIdeHelper all`
  - `:LaravelIdeHelperClean`

#### **laravel-ide-helper.nvim** by Bleksak
- **Purpose**: Wrapper for Laravel IDE Helper generation
- **Features**: Key mappings for model generation with auto-save/format options

#### **blade-nav.nvim**
- **Purpose**: Navigate between Blade views and components
- **Features**: Quick jumping between related Blade files

---

## 3. Syntax Highlighting & Parsing

### Treesitter Configuration

#### Core PHP Support
- **Parser**: `php` (official treesitter parser)
- **Installation**: `:TSInstall php`
- **Features**: Full syntax highlighting, folding, indentation

#### Blade Template Support
- **Parser**: `tree-sitter-blade` by EmranMR
- **Repository**: https://github.com/EmranMR/tree-sitter-blade
- **Dependencies**: Requires `php` and `html` parsers
- **Installation**: `:TSInstall blade`
- **Features**:
  - Syntax highlighting for Blade directives
  - Language injections (PHP, HTML, CSS, JS)
  - Autocompletion support
  - Code folding
  - Auto-indentation

#### Configuration Requirements
```lua
-- Add to treesitter ensure_installed
ensure_installed = { "php", "html", "blade" }

-- File type detection for *.blade.php files
-- Parser registration for blade grammar
```

---

## 4. Code Formatting

### Available Formatters

#### **Laravel Pint** (Recommended for Laravel Projects)
- **Type**: Official Laravel tool
- **Style**: Opinionated PHP code style fixer
- **Philosophy**: Minimal configuration, Laravel-focused
- **Integration**: Works with `conform.nvim` or `null-ls`
- **Pros**:
  - Zero configuration needed
  - Built specifically for Laravel projects
  - Consistent with Laravel coding standards
  - Fast execution
- **Installation**: Included in Laravel 9+, or `composer require laravel/pint --dev`

#### **PHP-CS-Fixer**
- **Type**: Community standard
- **Style**: Highly configurable
- **Pros**: More customization options, supports various standards (PSR-2, PSR-12, Symfony)
- **Use Case**: Multi-framework projects or custom standards

#### **phpcbf** (PHP Code Beautifier and Fixer)
- **Part of**: PHP_CodeSniffer suite
- **Purpose**: Automatically fixes coding standard violations
- **Integration**: Works alongside phpcs for linting

### Modern Integration Approach (2025)

**conform.nvim** (Recommended)
```lua
formatters_by_ft = {
  php = { { "pint", "php_cs_fixer" } }, -- Pint primary, php_cs_fixer fallback
}
```

**Features**:
- Format on save
- Respects local vendor/bin installations
- Multiple formatter fallback support
- Async formatting

### Linting

#### **phpcs** (PHP_CodeSniffer)
- **Purpose**: Detect coding standard violations
- **Integration**: Via LSP diagnostics or null-ls
- **Standards**: PSR-2, PSR-12, WordPress, custom
- **Workflow**: phpcs lints → phpcbf fixes

---

## 5. Static Analysis

### Tool Options

#### **PHPStan**
- **Strengths**:
  - More actively developed
  - Better Laravel support via larastan
  - More user-friendly error messages
  - Level-based strictness (0-9)
  - Excellent community adoption
- **Laravel Extension**: `larastan` - Laravel-specific rules and stubs
- **Integration**: Via Phpactor LSP extension

#### **Psalm**
- **Strengths**:
  - More advanced type system
  - Better at finding complex type issues
  - Strong focus on type safety
- **Laravel Extension**: `psalm-plugin-laravel`
- **Integration**: Via Phpactor or standalone

### Integration in Neovim

**Through Phpactor**:
```lua
init_options = {
  ["language_server_phpstan.enabled"] = true,
  ["language_server_psalm.enabled"] = false, -- or true to enable both
}
```

**Important Notes**:
- Neither PHPStan nor Psalm have native LSP support
- Phpactor acts as a bridge/adapter
- Diagnostics appear in real-time as you edit (with Phpactor)
- Analysis runs on saved files
- Configuration files (phpstan.neon, psalm.xml) in project root

**Recommendation**: Use PHPStan with larastan for Laravel projects (better ecosystem fit)

---

## 6. Debugging

### Xdebug + nvim-dap Setup

#### Required Components

1. **Xdebug** (PHP extension)
   - Configure in php.ini
   - Port: 9003 (Xdebug 3.x default)

2. **vscode-php-debug**
   - Debug adapter for DAP protocol
   - Installation:
     ```bash
     git clone https://github.com/xdebug/vscode-php-debug.git
     cd vscode-php-debug
     npm install && npm run build
     ```

3. **Neovim Plugins**:
   - `mfussenegger/nvim-dap` - Debug Adapter Protocol client
   - `rcarriga/nvim-dap-ui` - Debug UI
   - `theHamsta/nvim-dap-virtual-text` - Inline variable values

#### Basic Configuration
```lua
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/path/to/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}
```

#### Docker Support
- Requires `pathMappings` to map container paths to local paths
- Common pattern: `/var/www/html` → `${workspaceFolder}`

---

## 7. Completion System

### nvim-cmp Configuration

**Recommended Sources** (priority order):
1. `nvim_lsp` - LSP completions (Intelephense/Phpactor)
2. `nvim-cmp-laravel` - Laravel-specific completions
3. `luasnip` or `vsnip` - Snippets
4. `buffer` - Buffer text
5. `path` - File paths

**Laravel-Specific**:
- `nvim-cmp-laravel` or laravel.nvim's completion source
- Provides completions for routes, config, views, translations

---

## 8. Additional Quality-of-Life Tools

### Recommended Plugins

1. **nvim-autopairs** - Auto-close brackets, quotes
2. **Comment.nvim** - PHP comment toggling with filetype awareness
3. **nvim-surround** - Surround text with quotes, tags, etc.
4. **telescope.nvim** - Fuzzy finding for files, symbols, diagnostics
5. **nvim-tree** or **oil.nvim** - File explorer
6. **gitsigns.nvim** - Git integration
7. **which-key.nvim** - Keymap discovery

### PHP-Specific

1. **vim-phpunit** - Run PHPUnit tests from Neovim
2. **neotest** with `neotest-phpunit` - Modern test runner
3. **nvim-dap** with Pest/PHPUnit - Debug tests directly

---

## 9. Recommended Setup Workflow

### Phase 1: Core Setup
1. Install Mason.nvim for LSP/tool management
2. Install Intelephense (or Phpactor)
3. Configure nvim-lspconfig
4. Set up nvim-cmp with appropriate sources
5. Configure treesitter with php parser

### Phase 2: Laravel Integration
1. Install Laravel IDE Helper in your project
2. Generate helper files
3. Install laravel.nvim plugin
4. Configure Blade treesitter parser
5. Set up Laravel-specific keymaps

### Phase 3: Quality Tools
1. Configure Pint for formatting
2. Set up PHPStan/larastan
3. Integrate with conform.nvim or null-ls
4. Configure format-on-save

### Phase 4: Debugging
1. Install Xdebug
2. Set up nvim-dap
3. Install vscode-php-debug adapter
4. Configure debug configurations
5. Test with breakpoints

---

## 10. Configuration Best Practices

### File Organization (Based on Your Structure)

```
lua/plugins/
├── lsp.lua           # Intelephense, Phpactor, Mason
├── completion.lua    # nvim-cmp, laravel completion source
├── editor.lua        # Treesitter (php, blade), autopairs, comments
├── coding.lua        # laravel.nvim, testing tools, dap
├── navigation.lua    # Telescope, file explorers, blade-nav
├── ui.lua           # Theme, statusline
└── git.lua          # Gitsigns, fugitive
```

### Key Points

1. **Lazy Loading**: Load LSP on FileType events for PHP files
2. **Laravel Detection**: Check for `artisan` file to conditionally enable Laravel plugins
3. **Docker Awareness**: Configure path mappings if using Docker
4. **Project-Specific Settings**: Use `.nvimrc` or `exrc` for per-project config

---

## 11. Performance Considerations

### Optimization Tips

1. **Lazy Loading**: Essential with many plugins
   - Use `ft = "php"` for PHP-specific plugins
   - Use `event = "VeryLazy"` for non-critical plugins

2. **LSP Configuration**:
   - Limit diagnostics frequency
   - Disable unused LSP features
   - Use single LSP server where possible

3. **Treesitter**:
   - Only install needed parsers
   - Use `ensure_installed` for automatic management

4. **Startup Time**:
   - Aim for <100ms startup
   - Use `:Lazy profile` to identify slow plugins

---

## 12. Common Pitfalls & Solutions

### Issue: LSP shows too many errors
- **Solution**: Run Laravel IDE Helper generators
- **Solution**: Configure larastan for PHPStan
- **Solution**: Add project-specific stubs

### Issue: Blade files not highlighting
- **Solution**: Ensure blade parser is installed
- **Solution**: Check file type detection for `*.blade.php`
- **Solution**: Verify php and html parsers are installed

### Issue: Completions not showing Laravel helpers
- **Solution**: Generate IDE helper files
- **Solution**: Install nvim-cmp-laravel or use laravel.nvim completion source
- **Solution**: Restart LSP server after generating helpers

### Issue: Debugging not working with Docker
- **Solution**: Add pathMappings to dap configuration
- **Solution**: Verify Xdebug can reach host machine
- **Solution**: Check port mappings (9003)

---

## 13. Recommended Minimal Setup

For developers just starting with Neovim for Laravel:

**Essential**:
1. Intelephense or Phpactor LSP
2. Laravel IDE Helper (composer package)
3. Treesitter with php + blade parsers
4. nvim-cmp for completions
5. Laravel Pint for formatting

**Next Level**:
6. laravel.nvim for artisan/route integration
7. PHPStan with larastan
8. nvim-dap for debugging
9. Telescope for navigation
10. Which-key for discoverability

**Advanced**:
11. Neotest for test running
12. Custom Laravel snippets
13. Tinker integration
14. Docker-specific configurations

---

## 14. Resources for Implementation

### Key GitHub Repositories
- adalessa/laravel.nvim - Most comprehensive Laravel plugin
- EmranMR/tree-sitter-blade - Blade syntax parser
- mfussenegger/nvim-dap - Debug adapter protocol
- stevearc/conform.nvim - Modern formatter integration

### Documentation
- LazyVim extras: Quick PHP/Laravel setup presets
- Phpactor docs: Comprehensive LSP configuration
- Laracasts "Neovim as a PHP IDE" series - Video tutorials

### Community
- /r/neovim - Active Neovim community
- Laracasts forum - Laravel + Neovim discussions
- GitHub Discussions on laravel.nvim

---

## 15. Conclusion

The modern Neovim setup for Laravel development in 2025 is mature and production-ready. The key to success is:

1. **Start simple**: LSP + IDE Helper + basic tooling
2. **Layer incrementally**: Add features as you need them
3. **Leverage Laravel.nvim**: It handles most Laravel-specific needs
4. **Use IDE Helper**: Critical for LSP accuracy
5. **Choose your LSP wisely**: Intelephense for ease, Phpactor for flexibility

The ecosystem has evolved significantly, with Neovim 0.11 simplifying many aspects that previously required complex configuration. The combination of a good LSP, Laravel IDE Helper, and laravel.nvim provides an experience comparable to (or better than) traditional IDEs like PhpStorm, with the added benefit of Neovim's modal editing and extensibility.
