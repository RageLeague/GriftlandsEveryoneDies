local CONVO = Content.GetConvoStateGraph("HATED_CHAT")
local MODID = CURRENT_MOD_ID

CONVO.hooks[HUB_STATE.HUB] = function(cxt, who)
    if who and (Content.GetModSetting( MODID, "allow_any_relation_provoking" ) or who:GetRelationship() == RELATIONSHIP.HATED) then
        local can_provoke_here = not cxt.location:HasTag("HQ")
        local can_provoke_this_person = not who:HasActiveQuestMembership() and not who:IsInPlayerParty() and not AgentUtil.HasPlotArmour(who)

        cxt:Opt("OPT_PROVOKE")
            :Dialog( "DIALOG_PROVOKE" )
            :ReqCondition(Content.GetModSetting( MODID, "allow_provoke_anywhere" ) or can_provoke_here, "REQ_CAN_NOT_PROVOKE_HERE")
            :ReqCondition(Content.GetModSetting( MODID, "allow_provoke_anyone" ) or can_provoke_this_person, "REQ_CAN_NOT_PROVOKE_THIS_PERSON")
            :PostText("TT_PROVOKE")
            :Negotiation{
                flags = NEGOTIATION_FLAGS.PROVOCATION,
                reason_fn = function(minigame)
                    return loc.format(cxt:GetLocString("NEGOTIATION_REASON") )
                end,

                on_success = function(cxt, minigame)
                    cxt:Dialog("DIALOG_WIN_NEGOTIATION_FIGHT")

                    cxt:Opt("OPT_DEFEND")
                        :Battle{
                            flags = BATTLE_FLAGS.SELF_DEFENCE | BATTLE_FLAGS.ISOLATED | BATTLE_FLAGS.NO_BYSTANDERS | BATTLE_FLAGS.NO_SURRENDER,
                            on_win = function(cxt)
                                if cxt:GetAgent():IsDead() then
                                    cxt:Dialog("DIALOG_KILLED_AGENT")
                                else
                                    cxt:Dialog("DIALOG_DID_NOT_KILL_AGENT")
                                end
                                StateGraphUtil.AddEndOption(cxt)
                            end,
                            on_runaway = StateGraphUtil.DoRunAway,
                        }
                end,

                on_fail = function(cxt)
                    cxt:Dialog("DIALOG_LOSE_NEGOTIATION")
                    StateGraphUtil.AddEndOption(cxt)
                end,
            }
    end
end