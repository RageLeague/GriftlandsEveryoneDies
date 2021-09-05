local function OnLoad( mod )
end

return {
    version = "0.4.0",
    alias = "EVERYONE_DIES",

    OnLoad = OnLoad,
    OnPreLoad = OnPreLoad,
    OnNewGame = OnNewGame,

    mod_options = MOD_OPTIONS,

    title = "Everyone Dies",
    description = "This mod for Griftlands adds options to remove plot armor, allowing you to break the game.",
    previewImagePath = "preview.png",
}
