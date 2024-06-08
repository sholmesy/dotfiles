-- Diagnostics popup in Quickfix window
return {
    "folke/trouble.nvim",
    config = function ()
        local trouble = require("trouble")
        vim.keymap.set("n", "<C-t>", function() trouble.toggle({mode="diagnostics"}) end, {})
    end
}
