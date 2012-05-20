
function onDeath(cid, corpse, killer)
	local killerisplayer = 0
	if isPlayer(killer) == 1 then
		killerisplayer = 1
	end
	local victimisplayer = 0
	if isPlayer(cid) == 1 then
		victimisplayer = 1
	end
	local victimname = getCreatureName(cid)
	local killername = "Unknown"
	if not (killer == false or killer == 0) then
		killername = getCreatureName(killer)  
	end
	
	local deathtime = os.time()
	local playerpos = getCreaturePosition(cid)
	if victimisplayer == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You are dead.")
	end
	if victimisplayer == 0 and killerisplayer == 1 then
		reputation.giveMonsterRep(killer, cid, corpse)
		if string.lower(victimname) == 'mad hero' then
			doPlayerSendTextMessage(killer, MESSAGE_STATUS_CONSOLE_BLUE, "You have killed the mad hero.")
		end
	elseif victimisplayer == 1 then
		reputation.runPlayerDeathFunctions(killer, cid, corpse)
	end
	return TRUE
end
