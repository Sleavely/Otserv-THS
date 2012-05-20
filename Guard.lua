dofile("data/npc/scripts/waypoints.lua")



GUARD_ACTION_PATROL = 1
GUARD_ACTION_CHAT = 2
GUARD_ACTION_DEFEND = 3
GUARD_ACTION_RETURN = 4
local waypoints = {}
local headingTo = -1
local comingFrom = -1
local amountOfWaypoints = 0
local guard_action = GUARD_ACTION_PATROL
local focus = 0
local talk_start = 0
local talk_state = 0
local returnPath = {}
local returnPathNumber = 0

local currentTargetCID = 0
local hasteAmount = 200
local dmgDistance = {min = 50, max = 100, shooteffect=CONST_ANI_ARROW, dmgtype=COMBAT_PHYSICALDAMAGE, hitEffect=CONST_ME_DRAWBLOOD}
local dmgMelee = {min = 100, max = 150, dmgtype=COMBAT_PHYSICALDAMAGE, hitEffect=CONST_ME_DRAWBLOOD}
local dmgModifier = 0
local dmgModIncrease = 10
local mycity = "Turin"
local talk_distance = 3
local target_not_reachable_counter = 0
local target_not_reachable_amount = 30
local imSpeeded = false
debugperson = 0
local init


local function getCreaturesInRange(position, radiusx, radiusy, showMonsters, showPlayers)
    local creaturesList = {}
    for x = -radiusx, radiusx do
        for y = -radiusy, radiusy do
            if not (x == 0 and y == 0) then
                creature = getTopCreature({x = position.x+x, y = position.y+y, z = position.z, stackpos = STACKPOS_TOP_CREATURE})
                if (creature.type == 1 and showPlayers == 1) or (creature.type == 2 and showMonsters == 1) then
                    table.insert(creaturesList, creature.uid)
                end
            end
        end
    end
    return creaturesList
end

local function distanceToWaypoint(wp)
	local _p1,_p2,_p3 = selfGetPosition()
	return math.max(math.abs(_p1-waypoints[wp].x),math.abs(_p2-waypoints[wp].y))
end


local function closestWaypoint()
	local c_wp, c_dist
	c_wp = -1
	c_dist = -1
	local c = 0
	for a,b in pairs(waypoints) do
		c = c + 1
		if(c_dist==-1 or distanceToWaypoint(a) < c_dist) then
			c_dist = distanceToWaypoint(a)
			c_wp = a
		end 
	end
	if (c_wp<0) then
		error('No close waypoint could be found, ' .. c .. ' waypoints checked.')
	end
	return c_wp
end

local function dissectWaypointParam(p)
	local result = {}
	local a,b
	for w in string.gmatch(p, "[0-9%-]+") do

		if string.match(w, "%d+%-%d+") then
			a,b = string.match(w, "(%d+)%-(%d+)")
			a = tonumber(a)
			b = tonumber(b)
			while a <= b do
				result[#result + 1] = a
				a = a + 1
			end
			
		else
			
			result[#result + 1] = tonumber(w)
		end
	end
	if #result == 0 then
		error("Could not dissect waypoint parameter!")
	end
	return result
end

local function inRange(x1,y1,z1,x2,y2,z2, distance)
	if(math.abs(x1-x2) > distance) then
		return false
	end
	if(math.abs(y1-y2) > distance) then
		return false
	end
	if(not z1==z2) then
		return false
	end
	return true
end

-- OTServ event handling functions start
function onCreatureAppear(cid)

end

function onCreatureDisappear(cid)

end

function onCreatureSay(cid, type, msg)
	if getPlayerAccess(cid) > 0 then
		if(msgcontains(msg, 'debug_action')) then
			selfSay(tostring(guard_action))
		end
		if(msgcontains(msg, 'debug_nextwp')) then
			if(guard_action == GUARD_ACTION_PATROL) then
				selfSay(waypoints[headingTo].x .. " " .. waypoints[headingTo].y .. " " .. waypoints[headingTo].z)
			elseif(guard_action == GUARD_ACTION_RETURN) then
				selfSay(returnPath[headingTo].x .. " " .. returnPath[headingTo].y .. " " .. returnPath[headingTo].z)
			end
		end
		if (msgcontains(msg, 'debug_iteratewp')) then
			local p = {}
			p.cid = cid
			p.nwp = 1
			nextstop(p)
		end
		if (msgcontains(msg, 'debug_me')) then
			debugperson = cid
		end
	end
end

function nextstop(p)
	doPlayerSendTextMessage(p.cid,MESSAGE_STATUS_CONSOLE_BLUE, p.nwp .. " " .. #waypoints)
	if p.nwp < #waypoints then
		doPlayerSendTextMessage(p.cid,MESSAGE_STATUS_CONSOLE_BLUE, "Waypoint: " .. p.nwp)
		doTeleportThing(p.cid, waypoints[p.nwp])
		p.nwp = p.nwp + 1
		addEvent(nextstop, 200, p)
	else
		doPlayerSendTextMessage(p.cid,MESSAGE_STATUS_CONSOLE_BLUE, "End of Waypoints")
	end
end
local function searchForCriminals(pos)
	local players = getCreaturesInRange(pos, 6, 6, 0, 1)
	local i = 1
	local tp
	while i <= #players do
		tp = getCreaturePosition(players[i])
		if getTilePzInfo(tp) ~= TRUE then
			if getPlayerSkullType(players[i]) >= 3 or reputation.getPlayerReputationTier(players[i], FACTION_TURIN) == "Hostile" then 
				currentTargetCID = players[i]
				guard_action = GUARD_ACTION_DEFEND
				focus = 0
				dmgModifier = 0
				selfSay("Die Criminal!")
				if not imSpeeded then
					imSpeeded = true
					doChangeSpeed(getNpcCid(), hasteAmount)
				end
				return true
			
			end
		end
		i = i + 1
	end
	return false
end
local function stopDefend()
	guard_action = GUARD_ACTION_RETURN
	headingTo = returnPathNumber
	if imSpeeded then
		imSpeeded = false
		doChangeSpeed(getNpcCid(),-hasteAmount)
	end
end
function onThink()
	if(init) then
		init()
	end	
	local _p1,_p2,_p3 = selfGetPosition()
	local _t1,_t2,_t3
--selfSay(guard_action)
	if guard_action == GUARD_ACTION_PATROL then
		if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
			
			if (inRange(_p1, _p2, _p3, waypoints[headingTo].x,waypoints[headingTo].y,waypoints[headingTo].z, 7)) then
				selfMoveTo(waypoints[headingTo].x,waypoints[headingTo].y,waypoints[headingTo].z)
			elseif (inRange(_p1, _p2, _p3, waypoints[headingTo].x,waypoints[headingTo].y,waypoints[headingTo].z, 10)) then
				_t1 = ((_p1 - waypoints[headingTo].x) * 2) / math.abs(_p1 - waypoints[headingTo].x)
				_t2 = ((_p2 - waypoints[headingTo].y) * 2) / math.abs(_p2 - waypoints[headingTo].y)
				selfMoveTo(_p1 + _t1, _p2 + _t2, _p3)
				error("Waypoint too far away, trying to move towards it.")
			else
				doTeleportThing(getNpcCid(),waypoints[headingTo])
				--error("Waypoint is way off! Teleporting to waypoint.")				
			end
			target_not_reachable_counter = target_not_reachable_counter + 1
			if target_not_reachable_counter >= target_not_reachable_amount then
				doTeleportThing(getNpcCid(), waypoints[headingTo])
			end
			if (inRange(_p1, _p2, _p3, waypoints[headingTo].x,waypoints[headingTo].y,waypoints[headingTo].z, 1)) then
				target_not_reachable_counter = 0
				local next = comingFrom
				if (type(next) == "table") then
					error(type(next))
				end
				local connects = table.getn(waypoints[headingTo].connectsTo)
				if (connects > 1) then
					while (comingFrom == next) do
						next = waypoints[headingTo].connectsTo[math.random(1,connects)]
					end
				else
					next = waypoints[headingTo].connectsTo[1]
				end
				if(next) then
					comingFrom = headingTo
					headingTo = next
				else
		--			error('Walker Error: Next is nil')
				end
			else
				
			end
			
		end
	elseif guard_action == GUARD_ACTION_CHAT then
		if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
			doNpcSetCreatureFocus(focus)
			if focus > 0 then
				if (os.clock() - talk_start) > 15 then
					selfSay('Bye.')
					guard_action = GUARD_ACTION_PATROL
					focus = 0
				end
				if getDistanceToCreature(focus) > talk_distance then
					selfSay('Good bye then.')
					focus = 0
					guard_action = GUARD_ACTION_PATROL
				end
			end
		end
	elseif guard_action == GUARD_ACTION_DEFEND then
		if (isPlayer(currentTargetCID)~=1) then
			if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
				stopDefend()
			end
		else
			local tp = getCreaturePosition(currentTargetCID)
			if (type(tp)~="table") then
				
				if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
					stopDefend()
					return
				end
			end
			if getTilePzInfo(tp) == TRUE then
				stopDefend()
				return
			end
			if(returnPathNumber>0) then
				if(math.abs(_p1-returnPath[returnPathNumber].x)+math.abs(_p2-returnPath[returnPathNumber].y)>4) then
					returnPathNumber = returnPathNumber + 1
					returnPath[returnPathNumber] = {x=_p1,y=_p2,z=_p3}
				end
			else
				returnPathNumber = 1
				returnPath[returnPathNumber] = {x=_p1,y=_p2,z=_p3}
			end
			local dtc = getDistanceToCreature(currentTargetCID) 
			if tp.z ~= _p3 then
				stopDefend()

				return
			end
			if dtc <= 1 then
				doTargetCombatHealth(getNpcCid(), currentTargetCID, dmgMelee.dmgtype, -(dmgMelee.min + dmgModifier), -(dmgMelee.max + dmgModifier), dmgMelee.hitEffect)
				dmgModifier = dmgModifier + dmgModIncrease
			elseif dtc <= 7 then
				selfMoveTo(tp.x,tp.y,tp.z)
				doSendDistanceShoot(getCreaturePosition(getNpcCid()), getCreaturePosition(currentTargetCID), dmgDistance.shooteffect)
				doTargetCombatHealth(getNpcCid(), currentTargetCID, dmgDistance.dmgtype, -(dmgDistance.min + dmgModifier), -(dmgDistance.max + dmgModifier), dmgMelee.hitEffect)
				dmgModifier = dmgModifier + dmgModIncrease
			else
				if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
					stopDefend()
				end
			end
		end
	elseif guard_action == GUARD_ACTION_RETURN then
		if not searchForCriminals({x=_p1, y=_p2, z=_p3}) then
			local wp = closestWaypoint()
			if distanceToWaypoint(wp) > 5 then
				if(headingTo<1) then
					error("Could not return, headingTo is corrupt")
				end
				target_not_reachable_counter = target_not_reachable_counter + 1
				if target_not_reachable_counter >= target_not_reachable_amount then
					doTeleportThing(getNpcCid(), returnPath[headingTo])
				end
				if(inRange(_p1,_p2,_p3, returnPath[headingTo].x,returnPath[headingTo].y,returnPath[headingTo].z,1)) then
					target_not_reachable_counter = 0
					headingTo = headingTo - 1
					returnPath[returnPathNumber] = nil
					returnPathNumber = returnPathNumber - 1
					local rpi = 1
					while rpi < headingTo do
						if(inRange(_p1,_p2,_p3,returnPath[rpi].x,returnPath[rpi].y,returnPath[rpi].z,5)) then
							headingTo = rpi
							break
						end
						rpi = rpi + 1
					end
				end
				if(headingTo>0) then
					selfMoveTo(returnPath[headingTo].x,returnPath[headingTo].y,returnPath[headingTo].z)
				end
			else
				headingTo = wp
				comingFrom = -1
				guard_action = GUARD_ACTION_PATROL
				returnPath = {}
				returnPathNumber = 0
			end
		end
	end
		
end


init = function()
	
	mycity = tostring(getNpcParameter("city"))
	if not mycity then
		error("The city parameter is null!")
	end
	local afg = dissectWaypointParam(getNpcParameter("waypoints"))
	waypoints = getwaypoints(mycity,afg)
	
	headingTo = closestWaypoint()
	--selfSay(#waypoints .. " waypoints found. Heading to waypoint " .. headingTo)
	init = nil
end

