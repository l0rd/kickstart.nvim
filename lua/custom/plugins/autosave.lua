-- Automatically save buffers on InsertLeave / TextChanged (toggle with :ASToggle)

vim.pack.add { { src = 'https://github.com/okuuva/auto-save.nvim', version = vim.version.range '1.*' } }

require('auto-save').setup {}
