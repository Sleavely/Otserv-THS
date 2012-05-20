


FACTION_TURIN = reputation.factions.newFaction()
reputation.factions[FACTION_TURIN].name = "Turin"
reputation.factions[FACTION_TURIN].namedescription = "the city of Turin"
reputation.factions[FACTION_TURIN].storage = 11014
reputation.factions[FACTION_TURIN].startrep = 39000
reputation.factions[FACTION_TURIN].maxreputation = 81000
reputation.factions[FACTION_TURIN].tiers[1] = {name = "Hostile", 	repneeded=0,	buydiscount =-0.10,	selldiscount = -0.10}
reputation.factions[FACTION_TURIN].tiers[2] = {name = "Unfriendly",	repneeded=36000,buydiscount =-0.05,	selldiscount = -0.05}
reputation.factions[FACTION_TURIN].tiers[3] = {name = "Neutral",	repneeded=39000,buydiscount = 0,	selldiscount =  0}
reputation.factions[FACTION_TURIN].tiers[4] = {name = "Friendly",	repneeded=42000,buydiscount = 0.05,	selldiscount =  0.05}
reputation.factions[FACTION_TURIN].tiers[5] = {name = "Honored", 	repneeded=48000,buydiscount = 0.10,	selldiscount =  0.10}
reputation.factions[FACTION_TURIN].tiers[6] = {name = "Revered", 	repneeded=60000,buydiscount = 0.15,	selldiscount =  0.15}
reputation.factions[FACTION_TURIN].tiers[7] = {name = "Exalted", 	repneeded=81000,buydiscount = 0.20,	selldiscount =  0.20}



reputation.factions[FACTION_TURIN].data["TurinKills"] = function (player, monster, corpse, faction, options)
	local pos = getCreaturePosition(monster)
	local cn = getCreatureName(monster)
	if pos.z >= 7 then
		if pos.x > 2250 and pos.x < 2585 and pos.y > 2220 and pos.y < 2740 then
			reputation.doPlayerAddReputation(player, faction, options.rep, options)
			return
		end
	else
		if pos.x > 2315 and pos.x < 2610 and pos.y > 2270 and pos.y < 2710 then
			reputation.doPlayerAddReputation(player, faction, options.rep, options)
			return
		end
	end
end

reputation.addPlayerDeathFunction(
function (killer, victim, corpse)
	local pos = getCreaturePosition(victim)
	if isPlayer(killer) == 0 then
		return
	end
	if getPlayerSkullType(victim) ~= 0 then
		return
	end
	if pos.x > 2350 and pos.x < 2500 and pos.y > 2355 and pos.y < 2500 and pos.z <= 8 then
		reputation.doPlayerAddReputation(killer, FACTION_TURIN, -1000)
	end

end
)
reputation.addMonster("Rat", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 				{minrep=0,maxrep=42000, rep=1})
reputation.addMonster("Orc", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 				{minrep=0,maxrep=42000, rep=4})
reputation.addMonster("Orc Spearman", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=42000, rep=5})
reputation.addMonster("Orc Warrior", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=42000, rep=6})
reputation.addMonster("Swamp Troll", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=42000, rep=5})
reputation.addMonster("Troll", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=42000, rep=5})
reputation.addMonster("Bridge Troll", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=42000, rep=6})
reputation.addMonster("Rotworm", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=48000, rep=5})
reputation.addMonster("Dirtworm", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=48000, rep=5})
reputation.addMonster("Giant Spider", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=nil,	rep=30})
reputation.addMonster("Dragon", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=60000,	rep=20})
reputation.addMonster("Dragon Lord", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=nil,	rep=30})
reputation.addMonster("Amazon", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=42000,	rep=5})
reputation.addMonster("Valkyrie", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=48000, rep=7})
reputation.addMonster("Witch", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"],			{minrep=0,maxrep=48000, rep=10})
reputation.addMonster("Smuggler", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=48000, rep=6})
reputation.addMonster("Wild Warrior", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=48000, rep=6})
reputation.addMonster("Bandit", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=48000, rep=6})
reputation.addMonster("Elf", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 				{minrep=0,maxrep=42000, rep=5})
reputation.addMonster("Elf Scout", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"],	 	{minrep=0,maxrep=48000, rep=7})
reputation.addMonster("Elf Arcanist", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=48000, rep=12})
reputation.addMonster("Skeleton", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=42000, rep=4})
reputation.addMonster("Ghoul", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=48000, rep=7})
reputation.addMonster("Necromancer", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=48000, rep=12})
reputation.addMonster("Demon Skeleton", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=48000, rep=10})
reputation.addMonster("Slime", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=48000, rep=9})
reputation.addMonster("Beholder", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 		{minrep=0,maxrep=48000, rep=12})
reputation.addMonster("Black Knight", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 	{minrep=0,maxrep=nil,	rep=30})
reputation.addMonster("Hero", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=nil,	rep=30})
reputation.addMonster("Cyclops", FACTION_TURIN, reputation.factions[FACTION_TURIN].data["TurinKills"], 			{minrep=0,maxrep=48000,	rep=10})
