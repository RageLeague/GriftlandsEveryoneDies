local MUTATORS =
{
    GED_no_more_plot_armour =
    {
        name = "No More Plot Armour!",
        desc = "Plot armour for characters simply do not exist.\n\nFssh can hate you, Hebbel can love you, Moreef can die, game can softlock. Choose this mutator at your own risk.",

        event_handlers =
        {
            calculate_plot_armour = function( self, params, agent )
                params.override_has_plot_armour = false
            end
        },
    },
    GED_no_innate_plot_armour =
    {
        name = "No Innate Plot Armour",
        desc = "Certain characters, such as Fssh and night merchants, no longer have plot armour by default.",

        event_handlers =
        {
            calculate_agent_has_tag = function( self, params, agent, tag )
                if tag == "plot_armour" then
                    params.override_has_plot_armour = false
                end
            end
        },
    },
    GED_everyone_actually_gets_thirsty =
    {
        name = "Everyone Actually Gets Thirsty",
        desc = "People who normally cannot visit now can (other conditions apply).",

        event_handlers =
        {
            calculate_agent_has_tag = function( self, params, agent, tag )
                if tag == "no_patron" then
                    params.override_has_plot_armour = false
                end
            end
        },
    },
    GED_no_man_is_an_island =
    {
        name = "No Man Is An Island",
        desc = "People who normally don't have friends now can have friends to be sad about when they eventually die (other conditions apply).",

        event_handlers =
        {
            calculate_agent_has_tag = function( self, params, agent, tag )
                if tag == "no_friends" then
                    params.override_has_plot_armour = false
                end
            end
        },
    },
}

for id, graft in pairs( MUTATORS ) do
    Content.AddMutatorGraft( id, graft )
end
