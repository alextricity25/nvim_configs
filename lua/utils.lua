local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.is_deno_project(root_dir)
    local markers = {
        "deno.json",
        "deno.jsonc",
        "deno.lock",
        "import_map.json"
    }

    for _, marker in ipairs(markers) do
        local path = root_dir .. "/" .. marker
        if vim.fn.filereadable(path) == 1 then
            return true
        end
    end

    return false
end

return utils
