local settings = {
  theme = 'neofusion', -- ayu|gruvbox|neofusion
  indentChar = '│', -- │, |, ¦, ┆, ┊
  separatorChar = '-', -- ─, -, .
  aspect = 'clean', -- normal|clean
  lualine_separator = 'rect', -- rect|triangle|semitriangle|curve
  cmp_style = 'nvchad', -- default|nvchad
  cmp_icons_style = 'vscode', -- devicons|vscode
  transparent_mode = false,
}

return {
  {
    'diegoulloao/neofusion.nvim',
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },
    priority = 1000,
    config = function()
      require('neofusion').setup {
        italic = {
          strings = false,
        },
        transparent_mode = settings.transparent_mode,
      }

      vim.o.background = 'dark'
      vim.cmd [[ colorscheme neofusion ]]
    end,
    opts = ...,
  },
}
