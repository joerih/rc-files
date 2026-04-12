local data_path = vim.fn.stdpath("data")

local lazy_path = data_path .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true -- Show line numbers in a the left margin.
vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 5 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.
vim.o.confirm = true -- Confirm unsaved changes.
vim.opt.showmode = false -- Hide the mode from the neovim command status line; lualine already shows it.

-- Show highlighting when yanking (copying) text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Sync clipboard between OS and Neovim. Schedule the setting
-- after `UIEnter` because it can increase startup-time.
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Define and set data directories.
local dirs = {
  backup = data_path .. "/backup//",
  swap = data_path .. "/swap//",
  undo = data_path .. "/undo//",
  session = data_path .. "/session/",
}
for _, dir in pairs(dirs) do
  vim.fn.mkdir(dir, "p")
end
vim.opt.backup = true
vim.opt.backupdir = dirs.backup
vim.opt.backupext = ".bak"
vim.opt.swapfile = true
vim.opt.directory = dirs.swap
vim.opt.undofile = true
vim.opt.undodir = dirs.undo
vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize"

-- Load the lualine plugin.
require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
    config = function()
      require("lualine").setup()
    end,
  },
})

