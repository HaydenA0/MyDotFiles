return {
    --         {
    --           "RedsXDD/neopywal.nvim",
    --           name = "neopywal",
    --           lazy = false,
    --           priority = 1000,
    --           opts = {},
    -- config = function ()
    --   local neopywal = require("neopywal")
    --   neopywal.setup()
    --   vim.cmd.colorscheme("neopywal")
    --
    -- end
    --         },
	{
		"xiyaowong/transparent.nvim",
	},
  -- Using Lazy
      {
        "webhooked/kanso.nvim",
        priority = 1000,
    config = function ()
      vim.cmd.colorscheme("kanso")
      require('kanso').setup({
        bold = true,
        italics = true,
        compile = false,
        undercurl = true,
        transparent = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = {},
      })
    end

      }
}


