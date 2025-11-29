return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({})

    local Rule = require("nvim-autopairs.rule")


    npairs.add_rules({
      Rule("$", "$", "markdown")
        :with_move(function(opts) return opts.prev_char:match(".%$") ~= nil end)
        :with_pair(function() return true end),
    })



  end,
}

