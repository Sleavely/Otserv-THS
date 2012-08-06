THS' Otserv Lua scripts
=======================

This repository contains scripts for some of the features that were contained in World 7, such as *reputation*, *NPC waypoints*, and *town guards*. (Looking for the [OpenTibia repo](https://github.com/opentibia)?)

Load the THS library
--------------------

To enable these features you will need to modify your `data/global.lua` and add the following at the bottom:

```lua
dofile("data/THS_Lua/index.lua")
```

Reputation
----------

The reputation module is used by the town guards to determine whether to attack you on sight. You gain reputation mainly from killing monsters, but any script can be used to alter your reputation.

To get started, you need to add the [register_death.lua](https://github.com/Sleavely/Otserv-THS/blob/master/creaturescripts/scripts/register_death.lua) creaturescript for handling death events, like so:

```xml
<event type="death" name="REGISTER_DEATH" script="register_death.lua"/>
```

and probably add some factions to actually get reputation for:

1. Create a file such as [turin.lua](https://github.com/Sleavely/Otserv-THS/blob/master/THS_Lua/reputation/turin.lua) in the `THS_Lua/reputation/` folder
2. Add a reference to your new file in the reputation index at `THS_Lua/reputation/index.lua`
3. PROFIT!

Town guards
-----------

To get started, simply create an XML file like [the example](https://github.com/Sleavely/Otserv-THS/blob/master/npc/\(Turin\) Guard.xml). You define in the XML file which waypoints it should follow (you can have one guard for just a part of town, and another that patrols all of it).

Town guards use the reputation system, but this can be easily disabled by editing the line that contains `reputation.getPlayerReputationTier` in [Guard.lua](https://github.com/Sleavely/Otserv-THS/blob/master/npc/scripts/Guard.lua).

For a demonstration of the guard behaviour, see [this video](http://www.youtube.com/watch?v=Kw7_AuGTisQ&feature=player_embedded/ "World 7 Town Guards").