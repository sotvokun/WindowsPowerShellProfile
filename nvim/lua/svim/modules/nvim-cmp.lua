local use = require('svim.modules.package').use

-- Packages ----------------------------------------------------------
-- Completeion
use {'hrsh7th/nvim-cmp'}
use {'hrsh7th/cmp-vsnip'}
use {'hrsh7th/cmp-buffer'}
use {'hrsh7th/cmp-path'}

-- Snippets
use {'hrsh7th/vim-vsnip',
     setup =
     function ()
       vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
     end}
use {'rafamadriz/friendly-snippets'}

-- Apply -------------------------------------------------------------
local function feedkey(key, mode)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    mode,
    true
  )
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return (
    col ~= 0 and
    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil)
end

do
  local ok, cmp = pcall(require, 'cmp')
  if not ok then return end

  vim.o.completeopt = 'menu,menuone,noselect'

  -- Snippet
  local snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  }

  -- Sources
  local sources = {
    {name = 'vsnip'},
    {name = 'buffer', keyword_length = 7, dup = 0},
    {name = 'path'}
  }
  if pcall(require, 'cmp_nvim_lsp') then
    table.insert(sources, 1, {name = 'nvim_lsp'})
  end

  -- Keymap
  local keymap = {
    ['<up>'] = cmp.mapping.select_prev_item(),
    ['<down>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-c>'] = cmp.mapping.abort(),
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({
            behavior = cmp.SelectBehavior.Select
          })
        else
          cmp.confirm()
        end
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<s-tab>'] = cmp.mapping(function()
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, {'i', 's'})
  }

  -- Formatting
  local formatting = {
    format = function(entry, item)
      item.menu = string.format('[%s]', string.gsub(entry.source.name, 'nvim_', ''), item)
      return item
    end
  }

  cmp.setup({
    formatting = formatting,
    snippet = snippet,
    mapping = cmp.mapping.preset.insert(keymap),
    sources = cmp.config.sources(sources)
  })
end
