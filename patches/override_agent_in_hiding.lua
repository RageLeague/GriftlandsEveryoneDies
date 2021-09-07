local patch_id = "OVERRIDE_AGENT_IN_HIDING"
if rawget(_G, patch_id) then
    return
end
rawset(_G, patch_id, true)
print("Loaded patch:"..patch_id)

local old_fn = AgentUtil.IsInHiding

function AgentUtil.IsInHiding(agent, ...)
    local data = {}
    TheGame:BroadcastEvent( "calculate_in_hiding", data, agent, ... )
    if data.override_in_hiding ~= nil then
        return data.override_in_hiding
    end
    return old_fn(agent, ...)
end
