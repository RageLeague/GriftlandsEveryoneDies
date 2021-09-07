local patch_id = "REMOVE_PLOT_ARMOR"
if rawget(_G, patch_id) then
    return
end
rawset(_G, patch_id, true)
print("Loaded patch:"..patch_id)

local old_plot_armour_fn = AgentUtil.HasPlotArmour

function AgentUtil.HasPlotArmour(agent, ...)
    local plot_armour_data = {}
    TheGame:BroadcastEvent( "calculate_plot_armour", plot_armour_data, agent, ... )
    if plot_armour_data.override_has_plot_armour ~= nil then
        return plot_armour_data.override_has_plot_armour
    end
    return old_plot_armour_fn(agent, ...)
end
