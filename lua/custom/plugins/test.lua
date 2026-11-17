-- Test runner: neotest + neotest-golang
--
-- Keymaps (all under <leader>T, since <leader>t is taken by the [T]oggle group):
--   <leader>Tt  run the test nearest to the cursor
--   <leader>Tf  run all tests in the current file
--   <leader>Tl  re-run the last test
--   <leader>To  show output of the nearest test (floating window)
--   <leader>TO  toggle the output panel
--   <leader>Ts  toggle the summary tree
--   <leader>Tx  stop the running test
--   <leader>Td  debug the nearest test (via nvim-dap + delve)
--
-- NOTE: tests run on the host OS. Windows-only code (e.g. pkg/machine/wsl) cannot be
-- executed on macOS/Linux; use `GOOS=windows go vet ./pkg/machine/wsl/` to check it compiles.

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-neotest/nvim-nio',
  gh 'nvim-neotest/neotest',
  gh 'fredrikaverpil/neotest-golang',
}

local neotest = require 'neotest'
neotest.setup {
  adapters = {
    require 'neotest-golang' {
      -- Build tags used by the podman Makefile, so test files behind tags are discovered/compiled.
      go_test_args = { '-v', '-count=1', '-tags=remote,exclude_graphdriver_btrfs,containers_image_openpgp' },
    },
  },
}

vim.keymap.set('n', '<leader>Tt', function() neotest.run.run() end, { desc = '[T]est: run nearest' })
vim.keymap.set('n', '<leader>Tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = '[T]est: run [f]ile' })
vim.keymap.set('n', '<leader>Tl', function() neotest.run.run_last() end, { desc = '[T]est: run [l]ast' })
vim.keymap.set('n', '<leader>To', function() neotest.output.open { enter = true } end, { desc = '[T]est: [o]utput' })
vim.keymap.set('n', '<leader>TO', function() neotest.output_panel.toggle() end, { desc = '[T]est: [O]utput panel' })
vim.keymap.set('n', '<leader>Ts', function() neotest.summary.toggle() end, { desc = '[T]est: [s]ummary' })
vim.keymap.set('n', '<leader>Tx', function() neotest.run.stop() end, { desc = '[T]est: stop' })
vim.keymap.set('n', '<leader>Td', function() neotest.run.run { strategy = 'dap' } end, { desc = '[T]est: [d]ebug nearest' })
