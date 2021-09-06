local patch_id = "CONVO_OVERRIDE_HELPER"
if rawget(_G, patch_id) then
    return
end
rawset(_G, patch_id, true)
print("Loaded patch:"..patch_id)

-- Get an existing state of the convo
function Convo:GetState(id)
    self.default_state = self.states[id]
    return self
end

-- Clear all functions under this convo
function Convo:ClearFn()
    assert(self.default_state, "NO STATE PUSHED")
    self.default_state.fns = {}
    return self
end
