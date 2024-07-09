return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  config = function()
    vim.opt.termguicolors = false
    vim.cmd.colorscheme 'kanagawa'
  end,
}
