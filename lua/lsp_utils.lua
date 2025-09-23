-- LSP utility functions for root directory detection
-- These functions are extracted to be pure and testable

local M = {}

-- TypeScript/Node.js root directory detection
-- Returns nil if file should be handled by Deno instead
function M.get_typescript_root_dir(fname, root_pattern_fn)
  -- First check if file is in a Deno subdirectory
  local deno_root = root_pattern_fn("deno.json", "deno.jsonc", "deno.lock", "import_map.json")(fname)
  if deno_root then
    return nil -- Let denols handle this file
  end

  -- If not in Deno subdirectory, use TypeScript/Node.js patterns
  local root = root_pattern_fn("package.json", "tsconfig.json", ".git")(fname)
  return root
end

-- Deno root directory detection
-- Only attach if file is in a directory with Deno markers
function M.get_deno_root_dir(fname, root_pattern_fn)
  local root = root_pattern_fn("deno.json", "deno.jsonc", "deno.lock", "import_map.json")(fname)
  return root
end

-- ESLint root directory detection
-- Don't attach ESLint if file is in a Deno project
function M.get_eslint_root_dir(fname, root_pattern_fn)
  -- Don't attach ESLint if file is in a Deno project
  local deno_root = root_pattern_fn("deno.json", "deno.jsonc", "deno.lock", "import_map.json")(fname)
  if deno_root then
    return nil -- Skip ESLint in Deno projects
  end

  -- Use standard ESLint patterns for non-Deno projects
  local root = root_pattern_fn(".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "package.json")(fname)
  return root
end

-- Helm root directory detection (no special logic needed, but extracted for consistency)
function M.get_helm_root_dir(fname, root_pattern_fn)
  -- Standard helm root detection
  local root = root_pattern_fn("Chart.yaml", "Chart.yml", ".git")(fname)
  return root
end

-- Go root directory detection (no special logic needed, but extracted for consistency)
function M.get_go_root_dir(fname, root_pattern_fn)
  -- Standard go root detection
  local root = root_pattern_fn("go.mod", ".git")(fname)
  return root
end

return M