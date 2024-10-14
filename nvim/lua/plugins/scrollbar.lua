return {
  {
    "petertriho/nvim-scrollbar",
    init = function()
      require("scrollbar").setup({
        handlers = { cursor = false },
      })
    end,
  },
}
