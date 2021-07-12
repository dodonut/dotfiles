if not pcall(require, 'nvim-treesitter.configs') then
  print("Not loaded treesitter")
  return
end


require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "c",
    "cpp"
  },
}
