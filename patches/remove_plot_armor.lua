local old_plot_armour_fn = AgentUtil.HasPlotArmour

function AgentUtil.HasPlotArmour(agent, ...)
    local plot_armour_data = {}
    TheGame:BroadcastEvent( "calculate_plot_armour", agent, plot_armour_data )
    if plot_armour_data.override_plot_armour ~= nil then
        return plot_armour_data.override_plot_armour
    end
    return old_plot_armour_fn(agent, ...)
end
