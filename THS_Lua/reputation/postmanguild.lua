

FACTION_POSTMAN = reputation.factions.newFaction()
reputation.factions[FACTION_POSTMAN].name = "Postmen Guild"
reputation.factions[FACTION_POSTMAN].namedescription = "the Postmen Guild"
reputation.factions[FACTION_POSTMAN].storage = 11021
reputation.factions[FACTION_POSTMAN].startrep = 39000
reputation.factions[FACTION_POSTMAN].maxreputation = 81000
reputation.factions[FACTION_POSTMAN].tiers[1] = {name = "Hostile", 	repneeded=0}
reputation.factions[FACTION_POSTMAN].tiers[2] = {name = "Unfriendly",	repneeded=36000}
reputation.factions[FACTION_POSTMAN].tiers[3] = {name = "Neutral",	repneeded=39000}
reputation.factions[FACTION_POSTMAN].tiers[4] = {name = "Friendly",	repneeded=42000}
reputation.factions[FACTION_POSTMAN].tiers[5] = {name = "Honored", 	repneeded=48000}
reputation.factions[FACTION_POSTMAN].tiers[6] = {name = "Revered", 	repneeded=60000}
reputation.factions[FACTION_POSTMAN].tiers[7] = {name = "Exalted", 	repneeded=81000}