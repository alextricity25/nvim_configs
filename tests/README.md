# LSP Configuration Testing

This directory contains unit tests for the LSP root directory detection logic used in the Neovim configuration.

## Overview

The tests verify that TypeScript/Deno LSP conflict resolution works correctly across various project structures including:

- Monorepos with mixed TypeScript and Deno projects
- Dedicated TypeScript or Deno repositories  
- Nested project structures
- ESLint integration that properly skips Deno projects

## File Structure

```
tests/
├── README.md           # This file
├── test_runner.lua     # Test runner designed for Neovim headless mode
└── spec/
    ├── test_helpers.lua    # Test utilities and mock file system
    └── lsp_utils_spec.lua  # Comprehensive test cases
```

## Running Tests

Run tests using the Makefile in the project root:

```bash
# Run tests
make test

# Run with verbose output (same as test for now)
make test-verbose

# Validate configuration syntax
make validate

# Clean test artifacts
make clean
```

## Test Scenarios

### TypeScript Root Directory Tests
- Monorepo TypeScript project detection
- Deno project exclusion for TypeScript LSP
- Dedicated TypeScript project handling
- Nested frontend project detection

### Deno Root Directory Tests  
- Dedicated Deno project detection
- Monorepo Deno project handling
- Non-Deno project exclusion
- Nested Deno project root detection

### ESLint Integration Tests
- ESLint enabled in TypeScript projects
- ESLint disabled in Deno projects
- Monorepo ESLint behavior

### Edge Cases
- Files without project markers
- Multiple nested project roots (finds closest)

## Architecture

Tests use dependency injection to mock the `root_pattern` function, allowing simulation of various file system structures without touching the actual file system. The mock file system is defined as Lua tables mapping directory paths to arrays of marker files.

Example:
```lua
local fs = {
  ["/monorepo"] = { ".git", "package.json" },
  ["/monorepo/deno-app"] = { "deno.json" },
  ["/monorepo/ts-app"] = { "package.json", "tsconfig.json" }
}
```

## Adding New Tests

1. Create new test scenarios in `test_helpers.lua` if needed
2. Add test cases to `lsp_utils_spec.lua` using the `test()` function
3. Run tests to verify functionality

The test framework provides assertion helpers:
- `assert_root_equals(actual, expected, message)`
- `assert_root_is_nil(actual, message)`