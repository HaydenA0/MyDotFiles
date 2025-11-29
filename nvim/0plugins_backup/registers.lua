-- ~/.config/nvim/lua/plugins/neoclip.lua
return {
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      -- Uncomment one of these if you plan to use a picker:
      { "nvim-telescope/telescope.nvim" },
      -- { "ibhagwan/fzf-lua" },
    },
    config = function()
      require("neoclip").setup({
        history = 1000,
        enable_persistent_history = true,
        length_limit = 1048576,
        continuous_sync = false,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        preview = true,
        default_register = '"',
        enable_macro_history = true,
      })
    end,
  },
}

