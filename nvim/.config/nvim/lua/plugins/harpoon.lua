return {
  "ThePrimeagen/harpoon",
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    local keymap = {
      [1] = "j",
      [2] = "k",
      [3] = "l",
      [4] = ";",
    }

    for i = 1, 4 do
      table.insert(keys, {
        "<leader>" .. keymap[i],
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
