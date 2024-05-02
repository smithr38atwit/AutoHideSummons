local function hideSummons(char)
    -- Hide Summons
    local summons = Osi.DB_PlayerSummons:Get(nil)
    for i, summon in pairs(summons) do
        local owner = Osi.CharacterGetOwner(summon[1])
        local length = string.len(char)
        if string.sub(char, length - 35) == owner and Osi.HasAppliedStatus(char, "SNEAKING") ~= Osi.HasAppliedStatus(summon[1], "SNEAKING") and not Ext.Entity.Get(summon[1]).BlockFollow then
            Osi.UseSpell(summon[1], "Shout_Hide", summon[1])
        end
    end
    -- Hide Extra Followers
    local followers = Osi.DB_PartyFollowers:Get(nil)
    for i, follower in pairs(followers) do
        local owner = Osi.CharacterGetOwner(follower[1])
        local length = string.len(char)
        if string.sub(char, length - 35) == owner and Osi.HasAppliedStatus(char, "SNEAKING") ~= Osi.HasAppliedStatus(follower[1], "SNEAKING") and not Ext.Entity.Get(follower[1]).BlockFollow then
            Osi.UseSpell(follower[1], "Shout_Hide", follower[1])
        end
    end
end

Ext.Osiris.RegisterListener("CastSpell", 5, "before", function(char, spell, type, school, int)
    if spell == "Shout_Hide" and Osi.IsInCombat(char) == 0 and Osi.IsSummon(char) == 0 and Osi.IsInForceTurnBasedMode(char) == 0 then
        hideSummons(char)
    end
end)
