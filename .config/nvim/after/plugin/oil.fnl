(let [oil (require :oil)]
  (oil.setup))

(vim.keymap.set "n" "-" :<cmd>Oil<cr> {:desc "Open parent directory"})
