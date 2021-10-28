
if not pcall(require, 'lspsaga') then
    return
end


local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
 -- code_action_icon = ' ',
 -- code_action_prompt = {
 --   enable = true,
 --   sign = true,
 --   sign_priority = 20,
 --   virtual_text = true,
 -- },
 finder_action_keys = {
   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
 },
 code_action_keys = {
   quit = 'q',exec = '<CR>'
 },
 rename_action_keys = {
   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
 },
 max_preview_lines = 30, -- preview lines of lsp_finder and definition preview
}

local sc = vim.api.nvim_set_keymap

local opts = { noremap=true, silent=true }


sc('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
sc('i', '<c-k>', '<cmd>Lspsaga signature_help<cr>', opts)
sc('n', 'gR', '<cmd>Lspsaga lsp_finder<cr>', opts)
sc('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
-- sc('n', '<leader>cA', '<cmd>Lspsaga code_action<cr>', opts)
sc('n', 'gdn', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
sc('n', 'gdp', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
sc('n', '<s-t>', '<cmd>Lspsaga open_floaterm<cr>', opts)
sc('t', '<s-t>', '<cmd>Lspsaga close_floaterm<cr>', opts)

