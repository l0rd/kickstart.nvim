-- Git tooling: lazygit, fugitive/rhubarb, gh.nvim

local function gh(repo) return 'https://github.com/' .. repo end

-- [[ LazyGit ]]
-- Requires the `lazygit` executable. plenary.nvim (installed by Telescope) is used for window borders.
vim.pack.add { gh 'nvim-lua/plenary.nvim', gh 'kdheepak/lazygit.nvim' }
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- [[ Fugitive + Rhubarb (GitHub support for :GBrowse) ]]
vim.pack.add { gh 'tpope/vim-fugitive', gh 'tpope/vim-rhubarb' }
vim.keymap.set('n', 'gb', ':.GBrowse @upstream<cr>', { desc = '[G]it [B]rowse' })
vim.keymap.set('v', 'gb', ':GBrowse @upstream<cr>', { desc = '[G]it [B]rowse' })

-- [[ gh.nvim (GitHub PR reviews) ]]
vim.pack.add { gh 'ldelossa/litee.nvim', gh 'ldelossa/gh.nvim' }
require('litee.lib').setup()
require('litee.gh').setup()
