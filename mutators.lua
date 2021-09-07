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
    GED_nowhere_to_hide =
    {
        name = "Nowhere To Hide!",
        desc = "Characters trying to hide from the player will simply fail to do so, and you may encounter characters where you are not expected to find them.",
        event_handlers =
        {
            calculate_in_hiding = function( self, params, agent )
                params.override_in_hiding = false
            end
        },
    },
}

for id, graft in pairs( MUTATORS ) do
    Content.AddMutatorGraft( id, graft )
end
