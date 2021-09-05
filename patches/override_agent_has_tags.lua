local old_fn = Agent.HasTag

function Agent:HasTag( tag, ... )
    local data = {}
    TheGame:BroadcastEvent( "calculate_agent_has_tag", data, self, tag, ... )
    if data.override_has_tag ~= nil then
        return data.override_has_tag
    end
    return old_fn(self, tag, ...)
end
