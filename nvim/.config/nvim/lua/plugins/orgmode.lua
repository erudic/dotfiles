return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" }, --, lazy = true },
  },
  -- event = "VeryLazy",
  config = function()
    -- Load treesitter grammar for org
    require("orgmode").setup_ts_grammar()

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
      org_agenda_files = "~/orgfiles/projects/*",
      org_default_notes_file = "~/orgfiles/refile.org",
      org_todo_keywords = { "TODO", "WAITING", "LATER", "|", "DONE", "DELEGATED" },
    })
  end,
}