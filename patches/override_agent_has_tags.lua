local patch_id = "OVERRIDE_AGENT_HAS_TAGS"
if rawget(_G, patch_id) then
    return
end
rawset(_G, patch_id, true)
print("Loaded patch:"..patch_id)

local old_fn = Agent.HasTag

function Agent:HasTag( tag, ... )
    local data = {}
    TheGame:BroadcastEvent( "calculate_agent_has_tag", data, self, tag, ... )
    if data.override_has_tag ~= nil then
        return data.override_has_tag
    end
    return old_fn(self, tag, ...)
end
