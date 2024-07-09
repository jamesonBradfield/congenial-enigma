vim.keymap.set({ 'o', 'x', 'n' }, '<leader>R', function()
  if package.loaded[string.match(vim.fn.expand '%:r', '.-/([^/]+)$', 1)] ~= nil then
    package.loaded[string.match(vim.fn.expand '%:r', '.-/([^/]+)$', 1)] = nil
  end
  require(string.match(vim.fn.expand '%:r', '.-/([^/]+)$', 1))
end, { desc = '[R]eload lazy-plugin-reloader plugin' })
vim.keymap.set({ 'n', 'x', 'o' }, '<C-s>', function()
  vim.cmd 'sb'
end, { desc = '[s]plit' })
vim.keymap.set({ 'n', 'x', 'o' }, '<C-S-s>', function()
  vim.cmd 'vsplit'
end, { desc = 'V[S]plit' })
vim.keymap.set({ 'n', 'x', 'o' }, '<leader><leader>s', function()
  vim.cmd 'w'
  vim.cmd 'source %'
  local plugin = string.match(vim.fn.expand '%:p:h', '.-/([^/]+)$', 1)
  vim.cmd('Lazy reload ' .. plugin)
end, { desc = '[s]ource file' })

return {}
