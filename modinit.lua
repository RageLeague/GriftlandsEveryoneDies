local filepath = require "util/filepath"

local function OnLoad( mod )
    for k, filepath in ipairs( filepath.list_files( "EveryoneDies:patches/", "*.lua", true )) do
        local name = filepath:match( "(.+)[.]lua$" )
        -- print(name)
        if name then
            require(name)
        end
    end
    require "EveryoneDies:mutators"
end

return {
    version = "0.0.1",
    alias = "EveryoneDies",

    OnLoad = OnLoad,
    OnPreLoad = OnPreLoad,
    OnNewGame = OnNewGame,

    mod_options = MOD_OPTIONS,

    title = "Everyone Dies",
    description = "This mod for Griftlands adds options to remove plot armor, allowing you to break the game.",
    previewImagePath = "preview.png",
}
