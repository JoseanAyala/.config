return {
  "nvimdev/dashboard-nvim",
  opts = function()
    local logo = [[
              ▀████▀▄▄              ▄█
                █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
        ▄        █          ▀▀▀▀▄  ▄▀
       ▄▀ ▀▄      ▀▄              ▀▄▀
      ▄▀    █     █▀   ▄█▀▄      ▄█
      ▀▄     ▀▄  █     ▀██▀     ██▄█
       ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
        █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
       █   █  █      ▄▄           ▄▀
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "lua LazyVim.pick()()",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = 'lua LazyVim.pick("oldfiles")()',
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = function()
              LazyVim.lazygit({ cwd = LazyVim.root.git() })
            end,
            desc = " Git",
            icon = "󰊢 ",
            key = "g",
          },

          {
            action = "ene | DBUIToggle",
            desc = " Database Explorer",
            icon = " ",
            key = "d",
          },
          {
            action = "lua LazyVim.pick.config_files()()",
            desc = " Config",
            icon = " ",
            key = "c",
          },
          {
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          return {}
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
