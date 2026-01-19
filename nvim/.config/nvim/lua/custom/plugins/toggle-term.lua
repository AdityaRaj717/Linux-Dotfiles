return {
  -- amongst your other plugins
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  -- or
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {--[[ things you want to change go here]]
    },

    config = function()
      require('toggleterm').setup {
        open_mapping = [[<A-i>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
        hide_numbers = true,
      }
    end,
  },
}
