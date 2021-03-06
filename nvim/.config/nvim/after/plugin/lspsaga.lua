
if not pcall(require, 'lspsaga') then
    print('lspsaga not installed')
    return
end


local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
 code_action_icon = ' ',
 code_action_prompt = {
   enable = true,
   sign = true,
   sign_priority = 20,
   virtual_text = true,
 },
 finder_action_keys = {
   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
 },
 code_action_keys = {
   quit = 'q',exec = '<CR>'
 },
 rename_action_keys = {
   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
 },
 max_preview_lines = 15, -- preview lines of lsp_finder and definition preview
}

local sc = vim.api.nvim_set_keymap

local opts = { noremap=true, silent=true }
                
sc('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
sc('i', '<c-k>', '<cmd>Lspsaga signature_help<cr>', opts)
-- sc('n', 'gr', '<cmd>Lspsaga lsp_finder<cr>', opts)
sc('n', ',rn', '<cmd>Lspsaga rename<cr>', opts)
sc('n', ',ca', '<cmd>Lspsaga code_action<cr>', opts)
sc('n', 'gdn', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
sc('n', '<c-t>', '<cmd>Lspsaga open_floaterm<cr>', opts)
sc('t', '<c-t>', '<cmd>Lspsaga close_floaterm<cr>', opts)

