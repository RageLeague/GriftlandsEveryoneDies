local CONVO = Content.GetConvoStateGraph("HATED_CHAT")

CONVO.hooks[HUB_STATE.HUB] = function(cxt, who)
    if who and who:GetRelationship() == RELATIONSHIP.HATED then
        local can_provoke_here = not cxt.location:HasTag("HQ")
        local can_provoke_this_person = not who:HasActiveQuestMembership() and not who:IsInPlayerParty() and not AgentUtil.HasPlotArmour(who)

        cxt:Opt("OPT_PROVOKE")
            :Dialog( "DIALOG_PROVOKE" )
            :ReqCondition(can_provoke_here, "REQ_CAN_NOT_PROVOKE_HERE")
            :ReqCondition(can_provoke_this_person, "REQ_CAN_NOT_PROVOKE_THIS_PERSON")
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