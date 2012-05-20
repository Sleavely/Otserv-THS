-- Reputation Starts here
-- For documentation, go to Hell

reputation = {}
reputation.factions = {}
reputation.monsters = {}
reputation.playerkills = {}
-- Edit Global Faction Data Here

reputation.AnnouncePlayerRepChange = MESSAGE_INFO_DESCR
reputation.AnnouncePlayerTierChange = MESSAGE_INFO_DESCR



reputation.addPlayerDeathFunction = function(f)
	if type(f) == "function" then
		table.insert(reputation.playerkills, f) 
	end
end

-- A callback example
-- function(player, monster, corpse, faction, options)
-- options = {rep = xxx, minrep = xxx, maxrep = xxx}

reputation.addMonster = function(monstername, faction, f, options)
	monstername = string.lower(monstername)
	if not reputation.monsters[monstername] then
		reputation.monsters[monstername] = {}
		reputation.monsters[monstername].callbacks = {}
		reputation.monsters[monstername].standardrep = {}
	end
	options = options or {}
	if not options.maxrep then
		options.maxrep = reputation.factions[faction].maxreputation
	end
	if not options.minrep then
		options.minrep = 0
	end
	if type(f) == "function" then
		table.insert(reputation.monsters[monstername].callbacks, {func=f, faction=faction,options=options})
	else
		table.insert(reputation.monsters[monstername].standardrep, {faction=faction, amount=f, options=options})
	end
	
end
reputation.runPlayerDeathFunctions = function(killer, victim, corpse)
	local i = 1
	while i <= #reputation.playerkills do
		reputation.playerkills[i](killer, victim, corpse)
		i = i + 1
	end
end
reputation.giveMonsterRep = function(player, monster, corpse)
	local mcid = monster
	if type(monster) == "number" then
		monster = string.lower(getCreatureName(monster))
	elseif type(monster) == "string" then
		monster = string.lower(monster)
	end

	if reputation.monsters[monster] then
		local i = 1

		while i <= #reputation.monsters[monster].standardrep do
			
			reputation.doPlayerAddReputation(
				player,
				reputation.monsters[monster].standardrep[i].faction,
				reputation.monsters[monster].standardrep[i].amount,
				reputation.monsters[monster].standardrep[i].options)
			i = i + 1
		end
		i = 1
--		while i <= #reputation[monsters][monster][callbacks] do
		while i <= #reputation.monsters[monster].callbacks do
			reputation.monsters[monster].callbacks[i].func(
				player,
				mcid,
				corpse,
				reputation.monsters[monster].callbacks[i].faction,
				reputation.monsters[monster].callbacks[i].options)
			i = i + 1
		end
	end
end

 
reputation.doPlayerAddReputation = function(player, faction, amount, options)
		if isPlayer(player) ~= TRUE then
			error("Player not found.")
		end
		if not reputation.factions[faction] then
			error("Faction not found")
		end
		if amount == 0 then
			doPlayerSendTextMessage(player, reputation.AnnouncePlayerTierChange, "Amount was 0")
			return
		end
		options = options or {}
		if not options.maxrep then
			options.maxrep = reputation.factions[faction].maxreputation
		end
		if not options.minrep then
			options.minrep = 0
		end
		local current = getPlayerStorageValue(player, reputation.factions[faction].storage)
		local a
		local result

		if current == -1 then
			current = reputation.factions[faction].startrep
		end
		
		a = current + amount
		
		if (current >= options.maxrep and amount > 0) or (current <= options.minrep and amount < 0) then
			return
		end
		result = math.max(math.min(options.maxrep,a),options.minrep)
		if result == current then
			return
		elseif result ~= current + amount then
			amount = result - current
		end
		local tier1, tier2 = reputation.getReputationTier(faction,result), reputation.getReputationTier(faction,current)
		setPlayerStorageValue(player, reputation.factions[faction].storage, result)
		
		if amount > 0 then
			doPlayerSendTextMessage(player, reputation.AnnouncePlayerRepChange, "You gained " .. amount .. " reputation with " .. reputation.factions[faction].namedescription .. ".")
			if tier1 ~= tier2 then
				doPlayerSendTextMessage(player, reputation.AnnouncePlayerTierChange, "You are now " .. tier1 .. " with " .. reputation.factions[faction].namedescription .. ".")
			end
		else
			doPlayerSendTextMessage(player, reputation.AnnouncePlayerRepChange, "You lost " .. -amount .. " reputation with " .. reputation.factions[faction].namedescription .. ".")
			if tier1 ~= tier2 then
				doPlayerSendTextMessage(player, reputation.AnnouncePlayerTierChange, "You are now " .. tier1 .. " with " .. reputation.factions[faction].namedescription .. ".")
			end
		end
end
reputation.getPlayerReputation = function(player, faction)
		if isPlayer(player) ~= TRUE then
			error("Player not found.")
		end
		if not reputation.factions[faction] then
			error("Faction not found")
		end
		local a = getPlayerStorageValue(player, reputation.factions[faction].storage)
		if a == -1 then
			return reputation.factions[faction].startrep, true
		else
			return a
		end
end
reputation.getPlayerReputationTier = function(player, faction)
		if isPlayer(player) ~= TRUE then
			error("Player not found.")
		end
		if not reputation.factions[faction] then
			error("Faction not found")
		end
		local a = getPlayerStorageValue(player, reputation.factions[faction].storage)
		if a == -1 then
			a = reputation.factions[faction].startrep
		end
		return reputation.getReputationTier(faction, a)
end
reputation.getReputationTier = function(faction, amount)
		local i = #reputation.factions[faction].tiers
		if not reputation.factions[faction] then
			error("Faction not found: " .. faction)
			return
		end
		
		while i > 0  do
			if amount >= reputation.factions[faction].tiers[i].repneeded then
				return reputation.factions[faction].tiers[i].name, i
			end
			i = i - 1
		end
end
do
	local factionindex = 0
	reputation.factions.newFaction = function ()
		factionindex = factionindex + 1
		reputation.factions[factionindex] = {}
		reputation.factions[factionindex].tiers = {}
		reputation.factions[factionindex].data = {}
		return factionindex
	end
end



