local set_keymap = function(lhs, rhs, opts)
  local mode = 'n'
  if opts and opts.mode then
    mode = opts.mode
    opts.mode = nil
  end
  opts = vim.tbl_extend('keep', opts, {
    replace_keycodes = false
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Leader Key --------------------------------------------------------
vim.cmd('nnoremap <space> <nop>')
vim.g.mapleader = ' '

-- Window movement ---------------------------------------------------
set_keymap('<c-h>', '<c-w>h', { desc = 'Go to the left window' })
set_keymap('<c-j>', '<c-w>j', { desc = 'Go to the down window' })
set_keymap('<c-k>', '<c-w>k', { desc = 'Go to the up window' })
set_keymap('<c-l>', '<c-w>l', { desc = 'Go to the right window' })

set_keymap('<a-h>', '<c-\\><c-n><c-w>h', { mode = { 'i', 't' } })
set_keymap('<a-j>', '<c-\\><c-n><c-w>j', { mode = { 'i', 't' } })
set_keymap('<a-k>', '<c-\\><c-n><c-w>k', { mode = { 'i', 't' } })
set_keymap('<a-l>', '<c-\\><c-n><c-w>l', { mode = { 'i', 't' } })

-- Editing -----------------------------------------------------------
-- Better indenting
set_keymap('<', '<gv', { mode = 'v' })
set_keymap('>', '>gv', { mode = 'v' })

-- Move selected line and block
set_keymap('<a-j>', ":m '>+1<cr>gv-gv", {
  mode = 'x',
  desc = 'Move selection down'
})

set_keymap('<a-k>', ":m '<-2<cr>gv-gv", {
  mode = 'x',
  desc = 'Move selection up'
})

-- Movement in insert mode
set_keymap('<c-a>', '<c-\\><c-n>0i', { mode = 'i' })
set_keymap('<a-a>', '<c-\\><c-n>^i', { mode = 'i' })
set_keymap('<c-e>', '<c-\\><c-n>$a', { mode = 'i' })
set_keymap('<c-n>', '<down>', { mode = 'i', noremap = true })
set_keymap('<c-p>', '<up>', { mode = 'i', noremap = true })
set_keymap('<c-f>', '<right>', { mode = 'i' })
set_keymap('<c-b>', '<left>', { mode = 'i' })

-- Commands in insert mode
set_keymap('<c-s>', '<cmd>:write<cr>', { mode = 'i' })
set_keymap('<c-z>', '<cmd>:undo<cr>', { mode = 'i' })

-- Buffers -----------------------------------------------------------
set_keymap('<leader>ee', '<cmd>enew<cr>', { desc = 'New buffer' })
set_keymap('d!', '<cmd>%bdelete<cr>', { desc = 'Delete all buffers' })
set_keymap('dq', '<cmd>Bdelete<cr>', { desc = 'Delete buffer (hold window)' })
set_keymap('dQ', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
set_keymap('<leader>dq', '<cmd>:cclose<cr>', { desc = 'Close the quickfix window' })

-- Tabs --------------------------------------------------------------
set_keymap('<leader>et', '<cmd>tabnew<cr>', { desc = 'New tab' })
set_keymap('<leader>dt', '<cmd>tabclose<cr>', { desc = 'Close tab' })
set_keymap('<leader>dT', '<cmd>tabo<cr>', { desc = 'Close all other tab pages' })

-- LSP ---------------------------------------------------------------
set_keymap('gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to definition [LSP]' })
set_keymap('gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Go to references [LSP]' })
set_keymap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Go to declaration [LSP]' })
set_keymap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Go to implementation [LSP]' })
set_keymap('K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover [LSP]' })
set_keymap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action [LSP]' })
set_keymap('<leader>cf', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Formatting [LSP]' })
set_keymap('<leader>cd', '<cmd>TroubleToggle<cr>', { desc = 'Diagnostic [LSP]' })
set_keymap('<leader>cs', '<cmd>Vista!!<cr>', { desc = 'Symbols [LSP]' })
set_keymap('<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename [LSP]' })
set_keymap('<leader>cg', '<cmd>Neogen<cr>', { desc = 'Neogen' })

-- Toggle Term -------------------------------------------------------
set_keymap('<c-\\>', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle terminal' })
set_keymap('<c-\\>', '<c-\\><c-n><cmd>ToggleTerm<cr>', { mode = 't' })
set_keymap('<esc>', '<c-\\><c-n>', { mode = 't' })

-- <leader>g -------------------------------------------------------------
set_keymap(
  '<leader>gt',
  function() require('telescope-tabs').list_tabs() end,
  {desc = 'List tabs'}
)
set_keymap('<leader>gb', '<cmd>Telescope buffers<cr>', { desc = 'List buffers' })
set_keymap('<leader>gg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
set_keymap('<leader>gf', '<cmd>Telescope find_files previewer=false<cr>', { desc = 'Find files' })
set_keymap('<leader>go', '<cmd>Telescope oldfiles<cr>', { desc = 'Old Files' })
set_keymap(
  '<leader>g!',
  '<cmd>lua require("telescope").extensions.asynctasks.all()<cr>',
  {desc = 'Run Tasks'}
)

-- Macros ------------------------------------------------------------
set_keymap('Q', '@q', { desc = 'Replay macro q' })
set_keymap('<c-z>', '<cmd>@:<cr>', { desc = 'Repeat the last command' })

-- Quick Setup -------------------------------------------------------
set_keymap('<leader>qq', '<cmd>nohl<cr>', { desc = 'Disable search highlight' })
set_keymap('<leader>qr', '<cmd>set relativenumber!<cr>', { desc = 'Toggle relative number' })
set_keymap('<leader>qw', '<cmd>set wrap!<cr>', { desc = 'Text wrap' })
set_keymap('<leader>qs', '<cmd>set spell!<cr>', { desc = 'Spell' })
set_keymap('<leader>ql', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>', { desc = 'Redraw'})

-- Git Signs ---------------------------------------------------------
set_keymap(']g', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Next hunk (git)' })
set_keymap('[g', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Previous hunk (git)' })

-- Misc --------------------------------------------------------------
set_keymap('<space>;', ':', { desc = 'Ex Command' })
set_keymap('<c-n>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })

-- Tools -------------------------------------------------------------
set_keymap('<F12>u', '<cmd>UndotreeToggle<cr>', { desc = 'Toggle Undotree' })
set_keymap('<F12>d', '<cmd>DiffviewOpen<cr>', { desc = 'Open Diffview' })
set_keymap('<F12>D', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' })
