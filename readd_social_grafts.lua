local grafts =
{
    ENDO =
    {
        loved_graft = "bio_feedback",
        hated_graft = "bad_faith",
    },
    RAKE =
    {
        loved_graft = "first_aid",
        hated_graft = "fragile_health",
    },
    PLOCKA =
    {
        loved_graft = "spark_visor",
        hated_graft = "faulty_armor",
    },
    HEBBEL =
    {
        loved_graft = "top_shelf",
        hated_graft = "tainted_supply",
    },
    BEASTMASTER =
    {
        loved_graft = "regimented",
        hated_graft = "brutality",
    },
    DODGY_SCAVENGER =
    {
        loved_graft = "bargaining",
        hated_graft = "thin_skin",
    },
    HESH_AUCTIONEER =
    {
        loved_graft = "bio_feedback",
        hated_graft = "bad_faith",
    },
    VIXMALLI =
    {
        loved_graft = "bio_feedback",
    },
    BISHOP_OF_FOAM =
    {
        hated_graft = "heathen",
    },
    FSSH =
    {
        hated_graft = "tainted_supply",
    },
    KASHIO =
    {
        -- The same as Arint mod
        loved_graft = "on_the_list",
    },
}
for id, data in pairs(grafts) do
    local character_def = Content.GetCharacterDef( id )
    if character_def then
        for type, graft_id in pairs(data) do
            if not character_def[type] or character_def[type] == "" then
                character_def[type] = graft_id
            end
        end
    end
end
