-- Test specification for LSP utilities

local test_helpers = require('test_helpers')
local lsp_utils = require('lsp_utils')

local M = {}

function M.run_tests()
  local tests_passed = 0
  local tests_failed = 0
  local failures = {}
  
  local function test(name, test_fn)
    io.write("  " .. name .. "... ")
    local success, err = pcall(test_fn)
    if success then
      print("✅")
      tests_passed = tests_passed + 1
    else
      print("❌")
      tests_failed = tests_failed + 1
      table.insert(failures, name .. ": " .. tostring(err))
    end
  end
  
  print("\nTypeScript Root Directory Tests:")
  
  -- Test 1: Monorepo scenario - TypeScript project should get TypeScript LSP
  test("TypeScript file in monorepo TypeScript project", function()
    local fs = test_helpers.create_monorepo_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_typescript_root_dir("/monorepo/apps/web/src/index.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/monorepo/apps/web", "TypeScript project should return its root")
  end)
  
  -- Test 2: Monorepo scenario - File in Deno project should return nil for TypeScript
  test("TypeScript file in monorepo Deno project", function()
    local fs = test_helpers.create_monorepo_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_typescript_root_dir("/monorepo/tools/deno-scripts/build.ts", root_pattern)
    test_helpers.assert_root_is_nil(result, "Deno project should return nil for TypeScript LSP")
  end)
  
  -- Test 3: Pure TypeScript project
  test("TypeScript file in dedicated TypeScript project", function()
    local fs = test_helpers.create_typescript_only_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_typescript_root_dir("/ts-project/src/app.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/ts-project", "Pure TypeScript project should return project root")
  end)
  
  -- Test 4: Nested scenario - frontend should get TypeScript
  test("TypeScript file in nested frontend project", function()
    local fs = test_helpers.create_nested_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_typescript_root_dir("/workspace/frontend/components/Button.tsx", root_pattern)
    test_helpers.assert_root_equals(result, "/workspace/frontend", "Frontend project should return its root")
  end)
  
  print("\nDeno Root Directory Tests:")
  
  -- Test 5: Deno project should get Deno LSP
  test("Deno file in dedicated Deno project", function()
    local fs = test_helpers.create_deno_only_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_deno_root_dir("/deno-project/src/main.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/deno-project", "Deno project should return project root")
  end)
  
  -- Test 6: Monorepo Deno project
  test("Deno file in monorepo Deno project", function()
    local fs = test_helpers.create_monorepo_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_deno_root_dir("/monorepo/tools/deno-scripts/deploy.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/monorepo/tools/deno-scripts", "Monorepo Deno project should return its root")
  end)
  
  -- Test 7: TypeScript file in non-Deno project should return nil for Deno
  test("TypeScript file in non-Deno project", function()
    local fs = test_helpers.create_typescript_only_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_deno_root_dir("/ts-project/src/app.ts", root_pattern)
    test_helpers.assert_root_is_nil(result, "Non-Deno project should return nil for Deno LSP")
  end)
  
  -- Test 8: Nested scenario - backend should get closest Deno root
  test("Deno file in nested backend project", function()
    local fs = test_helpers.create_nested_scenario()
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_deno_root_dir("/workspace/backend/api/server.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/workspace/backend/api", "Should return closest Deno root")
  end)
  
  print("\nESLint Root Directory Tests:")
  
  -- Test 9: ESLint should work in TypeScript project
  test("ESLint in TypeScript project", function()
    local fs = test_helpers.create_typescript_only_scenario()
    fs["/ts-project"][#fs["/ts-project"] + 1] = ".eslintrc.json"
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_eslint_root_dir("/ts-project/src/app.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/ts-project", "TypeScript project should allow ESLint")
  end)
  
  -- Test 10: ESLint should be skipped in Deno project
  test("ESLint skipped in Deno project", function()
    local fs = test_helpers.create_deno_only_scenario()
    fs["/deno-project"][#fs["/deno-project"] + 1] = ".eslintrc.json"
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_eslint_root_dir("/deno-project/src/main.ts", root_pattern)
    test_helpers.assert_root_is_nil(result, "Deno project should skip ESLint")
  end)
  
  -- Test 11: Monorepo ESLint behavior
  test("ESLint in monorepo TypeScript project", function()
    local fs = test_helpers.create_monorepo_scenario()
    fs["/monorepo/apps/web"][#fs["/monorepo/apps/web"] + 1] = ".eslintrc.json"
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_eslint_root_dir("/monorepo/apps/web/src/index.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/monorepo/apps/web", "Monorepo TypeScript project should allow ESLint")
  end)
  
  -- Test 12: ESLint skipped in monorepo Deno project
  test("ESLint skipped in monorepo Deno project", function()
    local fs = test_helpers.create_monorepo_scenario()
    fs["/monorepo/tools/deno-scripts"][#fs["/monorepo/tools/deno-scripts"] + 1] = ".eslintrc.json"
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_eslint_root_dir("/monorepo/tools/deno-scripts/build.ts", root_pattern)
    test_helpers.assert_root_is_nil(result, "Monorepo Deno project should skip ESLint")
  end)
  
  print("\nEdge Cases:")
  
  -- Test 13: File with no project markers
  test("File with no project markers", function()
    local fs = {
      ["/orphan"] = {}
    }
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_typescript_root_dir("/orphan/file.ts", root_pattern)
    test_helpers.assert_root_is_nil(result, "File with no markers should return nil")
  end)
  
  -- Test 14: Multiple nested Deno projects (should find closest)
  test("Nested Deno projects", function()
    local fs = {
      ["/workspace"] = { ".git" },
      ["/workspace/outer"] = { "deno.json" },
      ["/workspace/outer/inner"] = { "deno.json" }
    }
    local root_pattern = test_helpers.create_mock_root_pattern(fs)
    
    local result = lsp_utils.get_deno_root_dir("/workspace/outer/inner/file.ts", root_pattern)
    test_helpers.assert_root_equals(result, "/workspace/outer/inner", "Should find closest Deno root")
  end)
  
  return {
    passed = tests_passed,
    failed = tests_failed,
    failures = failures
  }
end

return M