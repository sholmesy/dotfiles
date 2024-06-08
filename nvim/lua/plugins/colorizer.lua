-- Highlights hex colors e.g: #f44f44
return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        local colorizer = require("colorizer")
        colorizer.setup({ "*" }, {
            mode = "background"
        })
    end
}
