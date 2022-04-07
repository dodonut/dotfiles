vim.g.UltiSnipsEditSplit="vertical"
local dir = string.format('%s/site/pack/packer/start/', vim.fn.stdpath('data'))
vim.g.UltiSnipsSnippetDirectories={dir .. "vim-snippets/UltiSnips"}
