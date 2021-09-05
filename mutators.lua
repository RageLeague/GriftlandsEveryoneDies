local MUTATORS =
{
    GED_no_more_plot_armour =
    {
        name = "No More Plot Armour!",
        desc = "Plot armour for characters simply do not exist.\n\nFssh can hate you, Hebbel can love you, Moreef can die, game can softlock. Choose this mutator at your own risk.",

        event_handlers =
        {
            calculate_plot_armour = function( self, agent, params )
                params.override_has_plot_armour = false
            end
        },
    },
}

for id, graft in pairs( MUTATORS ) do
    Content.AddMutatorGraft( id, graft )
end
