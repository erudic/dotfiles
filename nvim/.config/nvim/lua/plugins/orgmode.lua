return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" }, --, lazy = true },
  },
  -- event = "VeryLazy",
  config = function()
    -- Setup treesitter
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      ensure_installed = { "org" },
      additional_vim_regex_highlighting = { "org" },
    })

    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/orgfiles/*",
      org_default_notes_file = "~/orgfiles/refile.org",
      org_todo_keywords = { "TODO(t)", "WAITING(w)", "LATER(l)", "|", "DONE(d)", "DELEGATED(g)", "CANCELLED(c)" },
    })
  end,
}
