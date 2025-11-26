return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = false,
        term_colors = true, -- Sets terminal colors (e.g. `g:terminal_color_0`)
        styles = {
          comments = {},
          conditionals = {},
        },
        integrations = {
          blink_cmp = true,
          gitsigns = true,
          mini = { enabled = true },
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
