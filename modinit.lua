local filepath = require "util/filepath"

local function OnNewGame( mod, game_state )
    -- Require this Mod to be installed to launch this save game.
    if TheGame:GetGameState():GetOptions().mutators then
        for id, data in pairs(TheGame:GetGameState():GetOptions().mutators) do
            local graft_data = Content.GetGraft(data)
            if graft_data and graft_data:GetModID() == mod.id then
                -- OVERRIDE_CHARACTER = MUTATORS[data].override_character
                game_state:RequireMod(mod)
                return
            end
        end
    end
end

local function OnGlobalEvent(mod, event_name, ...)
    if event_name == "calculate_agent_has_tag" then
        local params, agent, tag = ...
        if tag == "plot_armour" and Content.GetModSetting( mod.id, "ignore_plot_armour" ) then
            params.override_has_tag = true
        end
        if tag == "no_patron" and Content.GetModSetting( mod.id, "ignore_no_patron" ) then
            params.override_has_tag = true
        end
        if tag == "no_friends" and Content.GetModSetting( mod.id, "ignore_no_friends" ) then
            params.override_has_tag = true
        end
    end
end

local function OnLoad( mod )
    rawset(_G, "CURRENT_MOD_ID", mod.id)
    for k, filepath in ipairs( filepath.list_files( "EveryoneDies:patches/", "*.lua", true )) do
        local name = filepath:match( "(.+)[.]lua$" )
        -- print(name)
        if name then
            require(name)
        end
    end
    for k, filepath in ipairs( filepath.list_files( "EveryoneDies:convo_overrides/", "*.lua", true )) do
        local name = filepath:match( "(.+)[.]lua$" )
        -- print(name)
        if name then
            require(name)
        end
    end
    require "EveryoneDies:mutators"
    if Content.GetModSetting( mod.id, "readd_social_grafts" ) then
        return function( mod )
            require "EveryoneDies:readd_social_grafts"
        end
    end
end

local function OnPreLoad()
    for k, filepath in ipairs( filepath.list_files( "EveryoneDies:loc", "*.po", true )) do
        local name = filepath:match( "(.+)[.]po$" )
        local lang_id = name:match("([_%w]+)$")
        lang_id = lang_id:gsub("_", "-")
        -- require(name)
        print(lang_id)
        for id, data in pairs(Content.GetLocalizations()) do
            if data.default_languages and table.arraycontains(data.default_languages, lang_id) then
                Content.AddPOFileToLocalization(id, filepath)
            end
        end
    end
end

local function OnGameStart( mod )
    TheGame:GetEvents():ListenForEvents( mod, "calculate_agent_has_tag" )
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
    {
        title = "Ignore \"plot_armour\" Tag",
        spinner = true,
        key = "ignore_plot_armour",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. Characters with this tag always have plot armour by default.", data = false },
            { name="Enable", desc="Certain characters, such as Fssh and night merchants, no longer have plot armour by default.", data = true },
        }
    },
    {
        title = "Ignore \"no_patron\" Tag",
        spinner = true,
        key = "ignore_no_patron",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. Characters with this tag cannot patronize bars, ever.", data = false },
            { name="Enable", desc="People who normally cannot visit bars now can (other conditions apply).", data = true },
        }
    },
    {
        title = "Ignore \"no_friends\" Tag",
        spinner = true,
        key = "ignore_no_friends",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. Characters with this tag do not have friends automatically assigned to them (when some guy is killed).", data = false },
            { name="Enable", desc="People who normally don't have friends now can have friends to be sad about when they eventually die (other conditions apply).", data = true },
        }
    },
    {
        title = "Readd Impossible Boons/Banes",
        spinner = true,
        key = "readd_social_grafts",
        default_value = false,
        values =
        {
            { name="Disable (Default)", desc="Vanilla behaviour. Certain characters do not have boons/banes because it is impossible to get them in the base game (requires restart to apply).", data = false },
            { name="Enable", desc="All characters now have a boon/bane associated with them (requires restart to apply).", data = true },
        }
    },
}

return {
    version = "1.0.1",
    alias = "EveryoneDies",

    OnLoad = OnLoad,
    OnPreLoad = OnPreLoad,
    OnNewGame = OnNewGame,
    OnGameStart = OnGameStart,

    OnGlobalEvent = OnGlobalEvent,

    mod_options = MOD_OPTIONS,

    title = "Everyone Dies",
    description = "This mod for Griftlands adds options to remove plot armor, allowing you to break the game.",
    previewImagePath = "preview.png",
}
