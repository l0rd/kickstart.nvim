-- Extra Go debug configurations (on top of kickstart.plugins.debug / nvim-dap-go)
--
-- Debugging a prebuilt binary (e.g. the podman Windows client):
--   1. Build it without optimizations so breakpoints and variables work:
--        go build -gcflags="all=-N -l" -tags "remote exclude_graphdriver_btrfs containers_image_openpgp" `
--          -o bin/windows/podman-debug.exe ./cmd/podman
--      Keep it in bin/windows so podman finds gvproxy.exe / win-sshproxy.exe next to it.
--   2. Open nvim in the repo root, set breakpoints with <leader>b, press <F5> and
--      pick "Exec binary (prompt for args)".
--
-- Configurations in the repo's .vscode/launch.json are also listed by <F5>.

local ok, dap = pcall(require, 'dap')
if not ok then return end

-- VS Code accepts trailing commas in launch.json, nvim-dap's JSON parser doesn't: strip them.
require('dap.ext.vscode').json_decode = function(str, opts) return vim.json.decode((str:gsub(',(%s*[%]}])', '%1')), opts) end

local function default_binary()
  local candidate = vim.fs.joinpath(vim.fn.getcwd(), 'bin', 'windows', 'podman-debug.exe')
  if vim.uv.fs_stat(candidate) then return candidate end
  return vim.fn.getcwd() .. '/'
end

dap.configurations.go = dap.configurations.go or {}
table.insert(dap.configurations.go, {
  type = 'go',
  name = 'Exec binary (prompt for args)',
  request = 'launch',
  mode = 'exec',
  program = function() return vim.fn.input('Binary: ', default_binary(), 'file') end,
  args = function() return require('dap.utils').splitstr(vim.fn.input 'Args: ') end,
})
