# Makefile for Neovim Configuration Testing and Maintenance

.PHONY: test test-verbose clean help

# Default target
help:
	@echo "Available targets:"
	@echo "  test        - Run LSP configuration unit tests"
	@echo "  test-verbose- Run tests with verbose output" 
	@echo "  clean       - Clean up test artifacts"
	@echo "  help        - Show this help message"

# Run the test suite
test:
	@echo "Running LSP Configuration Tests..."
	@cd tests && nvim --headless -c "lua package.path = package.path .. ';../lua/?.lua;./spec/?.lua'; dofile('test_runner.lua')" -c "qa!"

# Run tests with more verbose output  
test-verbose:
	@echo "Running LSP Configuration Tests (Verbose)..."
	@cd tests && nvim --headless -c "lua package.path = package.path .. ';../lua/?.lua;./spec/?.lua'; dofile('test_runner.lua')" -c "qa!"

# Clean up any test artifacts
clean:
	@echo "Cleaning up test artifacts..."
	@find tests -name "*.log" -delete 2>/dev/null || true
	@find tests -name "*.tmp" -delete 2>/dev/null || true

# Validate Neovim configuration syntax
validate:
	@echo "Validating Neovim configuration..."
	@nvim --headless -c "lua require('lsp_utils')" -c "qa!" 2>/dev/null && echo "✅ lsp_utils.lua syntax is valid" || echo "❌ lsp_utils.lua has syntax errors"
	@nvim --headless -c "lua require('pluginconfigs')" -c "qa!" 2>/dev/null && echo "✅ pluginconfigs.lua syntax is valid" || echo "❌ pluginconfigs.lua has syntax errors"