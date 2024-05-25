require('nvim-treesitter.configs').setup {
  ensure_installed = { "graphql", "json", "http" },
  highlight = {
    enable = true,
  },
}
