-- Add new Factions here

FACTION_CERSI = reputation.factions.newFaction()
reputation.factions[FACTION_CERSI].name = "Cersi"
reputation.factions[FACTION_CERSI].namedescription = "the Cersi"
reputation.factions[FACTION_CERSI].storage = 11021
reputation.factions[FACTION_CERSI].startrep = 39000
reputation.factions[FACTION_CERSI].maxreputation = 81000
reputation.factions[FACTION_CERSI].tiers[1] = {name = "Hostile", 	repneeded=0}
reputation.factions[FACTION_CERSI].tiers[2] = {name = "Unfriendly",	repneeded=36000}
reputation.factions[FACTION_CERSI].tiers[3] = {name = "Neutral",	repneeded=39000}
reputation.factions[FACTION_CERSI].tiers[4] = {name = "Friendly",	repneeded=42000}
reputation.factions[FACTION_CERSI].tiers[5] = {name = "Honored", 	repneeded=48000}
reputation.factions[FACTION_CERSI].tiers[6] = {name = "Revered", 	repneeded=60000}
reputation.factions[FACTION_CERSI].tiers[7] = {name = "Exalted", 	repneeded=81000}


-- Add custom reputation functions here


-- Add monsters that give rep here