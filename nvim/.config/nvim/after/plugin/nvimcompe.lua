

if not pcall(require, 'compe') then
    print('Nvim Compe not isntalled')
    return
end

vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noselect,noinsert"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
    luasnip = true;
  };
}
vim.cmd[[highlight link CompeDocumentation NormalFloat]]
vim.cmd[[inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"]]
vim.cmd[[inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"]]
vim.cmd[[inoremap <expr> <c-space> compe#complete()]]
vim.cmd[[inoremap <expr> <c-e> compe#close("<c-e>")]]


