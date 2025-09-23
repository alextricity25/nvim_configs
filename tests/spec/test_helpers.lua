-- Test helpers and mocks for LSP configuration testing

local M = {}

-- Mock file system structure
-- Structure is a table where keys are directory paths and values are arrays of files/markers
M.mock_fs = {
  -- Example structure:
  -- ["/monorepo"] = { "package.json", ".git" },
  -- ["/monorepo/deno-project"] = { "deno.json" },
  -- ["/monorepo/node-project"] = { "package.json", "tsconfig.json" },
}

-- Create a mock root_pattern function that uses our mock file system
function M.create_mock_root_pattern(fs_structure)
  return function(...)
    local patterns = {...}
    
    return function(fname)
      -- Start from the file's directory and walk up the tree
      local current_dir = fname:match("(.*/)")
      if not current_dir then
        current_dir = "/"
      end
      
      -- Remove trailing slash
      current_dir = current_dir:gsub("/$", "")
      
      -- Walk up the directory tree
      while current_dir and current_dir ~= "" do
        local files_in_dir = fs_structure[current_dir] or {}
        
        -- Check if any of our patterns match files in this directory
        for _, pattern in ipairs(patterns) do
          for _, file in ipairs(files_in_dir) do
            if file == pattern then
              return current_dir
            end
          end
        end
        
        -- Move up one directory level
        local parent = current_dir:match("(.*)/[^/]+$")
        if parent == current_dir or not parent then
          break
        end
        current_dir = parent
      end
      
      return nil -- No matching pattern found
    end
  end
end

-- Test scenario builders
function M.create_monorepo_scenario()
  return {
    ["/monorepo"] = { ".git", "package.json" },
    ["/monorepo/apps/web"] = { "package.json", "tsconfig.json" },
    ["/monorepo/apps/api"] = { "package.json", "tsconfig.json" },
    ["/monorepo/tools/deno-scripts"] = { "deno.json" },
    ["/monorepo/libs/shared"] = { "package.json", "tsconfig.json" },
  }
end

function M.create_deno_only_scenario()
  return {
    ["/deno-project"] = { "deno.json", ".git" },
    ["/deno-project/src"] = {},
    ["/deno-project/tests"] = {},
  }
end

function M.create_typescript_only_scenario()
  return {
    ["/ts-project"] = { "package.json", "tsconfig.json", ".git" },
    ["/ts-project/src"] = {},
    ["/ts-project/tests"] = {},
  }
end

function M.create_nested_scenario()
  return {
    ["/workspace"] = { ".git" },
    ["/workspace/backend"] = { "deno.json" },
    ["/workspace/backend/api"] = { "deno.json" },
    ["/workspace/frontend"] = { "package.json", "tsconfig.json" },
    ["/workspace/frontend/components"] = {},
  }
end

-- Assertion helpers
function M.assert_root_equals(actual, expected, message)
  if actual ~= expected then
    error(string.format("%s: expected '%s', got '%s'", 
          message or "Root assertion failed", 
          expected or "nil", 
          actual or "nil"))
  end
end

function M.assert_root_is_nil(actual, message)
  if actual ~= nil then
    error(string.format("%s: expected nil, got '%s'", 
          message or "Root should be nil", 
          actual))
  end
end

return M