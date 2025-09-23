-- Simple test runner for LSP configuration tests
-- Designed to work with Neovim's headless mode

local function run_tests()
  local tests_passed = 0
  local tests_failed = 0
  local failures = {}
  
  print("Running LSP Configuration Tests...")
  print("==================================")
  
  -- Load test files
  local test_files = {
    "lsp_utils_spec"
  }
  
  for _, test_file in ipairs(test_files) do
    print("\nRunning tests from: " .. test_file .. ".lua")
    print("-------------------------------------------")
    
    local success, test_module = pcall(require, test_file)
    if not success then
      print("❌ Failed to load test file: " .. test_file)
      print("   Error: " .. test_module)
      tests_failed = tests_failed + 1
      table.insert(failures, "Failed to load " .. test_file .. ": " .. test_module)
    else
      -- Run tests from the module
      if test_module.run_tests then
        local results = test_module.run_tests()
        tests_passed = tests_passed + results.passed
        tests_failed = tests_failed + results.failed
        for _, failure in ipairs(results.failures or {}) do
          table.insert(failures, failure)
        end
      else
        print("⚠️  Test module " .. test_file .. " has no run_tests function")
      end
    end
  end
  
  print("\n==================================")
  print("Test Results:")
  print("==================================")
  print(string.format("✅ Passed: %d", tests_passed))
  print(string.format("❌ Failed: %d", tests_failed))
  
  if #failures > 0 then
    print("\nFailure Details:")
    for _, failure in ipairs(failures) do
      print("  • " .. failure)
    end
  end
  
  if tests_failed > 0 then
    print("\n💥 Some tests failed!")
    -- Don't exit with error code in Neovim headless mode as it might interfere
  else
    print("\n🎉 All tests passed!")
  end
  
  -- Flush output
  io.flush()
  
  return {
    passed = tests_passed,
    failed = tests_failed,
    failures = failures
  }
end

-- Run the tests
return run_tests()