return {
  "L3MON4D3/LuaSnip",
  keys = function()
    local luasnip = require("luasnip")
    return {
      {
        "<C-l>",
        function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<C-h>",
        function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end,
        mode = { "i", "s" },
      },
    }
  end,
}
