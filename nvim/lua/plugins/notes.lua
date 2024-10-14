return {
  "dhananjaylatkar/notes.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    root = os.getenv("HOME") .. "/notes/",
    picker = "telescope",
  },
  init = function()
    require("which-key").add({
      { "<leader>n", group = "notes" },
    })
  end,
  keys = {
    { "<leader>nf", ":NotesFind<CR>", desc = "Find notes in root dir" },
    { "<leader>ng", ":NotesGrep<CR>", desc = "Grep notes in root dir" },
    { "<leader>nn", ":NotesNew<CR>", desc = "Create new note in root dir" },
    {
      "<leader>ne",
      function()
        vim.cmd("Neotree focus filesystem dir=" .. require("notes").opts.root)
      end,
      desc = "Open Neo-tree",
    },
  },
}
