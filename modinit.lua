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

local MOD_OPTIONS =
{
    {
        title = "Allow Provoke Anywhere",
        spinner = true,
        key = "allow_provoke_anywhere",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. You cannot provoke a character in a location labelled \"HQ\".", data = false },
            { name="Enable", desc="Location restriction for provokation no longer applies, and you may provoke characters at HQs.", data = true },
        }
    },
    {
        title = "Allow Provoke Anyone",
        spinner = true,
        key = "allow_provoke_anyone",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. Plot armour characters, people in your party, and people involved in quests can't be provoked.", data = false },
            { name="Enable", desc="Everyone can be provoked given the right condition.", data = true },
        }
    },
    {
        title = "Allow Any Relation Provoking",
        spinner = true,
        key = "allow_any_relation_provoking",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. You can only provoke hated characters.", data = false },
            { name="Enable", desc="You can provoke anyone, from disliked to even loved (if you want for some reason).", data = true },
        }
    },
}

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
