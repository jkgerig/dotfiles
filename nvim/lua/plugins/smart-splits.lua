return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup {
      -- Ignore these filetypes when detecting if vim is at an edge
      ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
      -- Ignore these buffer types when detecting if vim is at an edge
      ignored_buftypes = { 'NvimTree' },
      -- Default multiplexer integration (auto-detects tmux, wezterm, etc.)
      default_amount = 3,
      -- Cursor follows when moving between splits
      at_edge = 'wrap',
      -- Move cursor to the adjacent split when resizing
      move_cursor_same_row = false,
      -- Multiplexer integration (auto-detects)
      multiplexer_integration = nil, -- auto-detect
    }

    -- Navigation: Ctrl+hjkl (works across vim splits and tmux/wezterm panes)
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

    -- Resizing: Alt+hjkl
    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize split right' })

    -- Swap buffers between splits: Leader+hjkl (optional)
    vim.keymap.set('n', '<leader>bh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer left' })
    vim.keymap.set('n', '<leader>bj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
    vim.keymap.set('n', '<leader>bk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
    vim.keymap.set('n', '<leader>bl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer right' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
