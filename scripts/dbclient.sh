#!/bin/bash

nvim --cmd 'lua require("lazy").load({ plugins = { "vim-dadbod", "vim-dadbod-ui", "vim-dadbod-completion" } })' \
  --cmd 'au VimEnter * silent! unmap <leader>n | silent! unmap <leader>e' \
  -c 'DBUI'
