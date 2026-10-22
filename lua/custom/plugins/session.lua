-- Automatic session save/restore per directory

vim.pack.add { 'https://github.com/rmagatti/auto-session' }

---@module "auto-session"
---@type AutoSession.Config
require('auto-session').setup {
  suppressed_dirs = { '~/' },
  -- log_level = 'debug',
}
