return {
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        enabled = false,
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
