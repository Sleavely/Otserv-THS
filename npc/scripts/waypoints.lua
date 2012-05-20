_TripleHead_Waypoints = {}


function newWayPoint(_city, number, x, y, z, connects)
	_TripleHead_Waypoints[_city] = 	_TripleHead_Waypoints[_city] or {}
	_TripleHead_Waypoints[_city][number] = 	_TripleHead_Waypoints[_city][number] or {}

	_TripleHead_Waypoints[_city][number] = {x=x,y=y,z=z,connectsTo=connects}
end




function getwaypoints(_city, wp)
	local result = {}
	local wpct = {}
	_city = _city or "nil"
	if not _TripleHead_Waypoints[_city] then
		error("The city requested does not exist.")
	end
	for i,v in pairs(wp) do
		if _TripleHead_Waypoints[_city][v] then
			result[v] = {}
			result[v].x = _TripleHead_Waypoints[_city][v].x
			result[v].y = _TripleHead_Waypoints[_city][v].y
			result[v].z = _TripleHead_Waypoints[_city][v].z
			wpct = {}
			for i2,v2 in pairs(_TripleHead_Waypoints[_city][v].connectsTo) do
				for i3,v3 in pairs(wp) do
					if v2==v3 then
						table.insert(wpct,v2)
						break
					end
				end
			end
			result[v].connectsTo = wpct
		end
	end
	return result
end


newWayPoint("Turin",  0,2403,2495,7,{1,11})		--Southern Gate, SW
newWayPoint("Turin",  1,2408,2495,7,{0,2})	
newWayPoint("Turin",  2,2413,2495,7,{1,3})	
newWayPoint("Turin",  3,2416,2493,7,{2,4})		--Southern Gate, SE
newWayPoint("Turin",  4,2416,2488,7,{3,5})	
newWayPoint("Turin",  5,2416,2483,7,{4,6})		
newWayPoint("Turin",  6,2416,2479,7,{5,7})		--Southern Gate, NE
newWayPoint("Turin",  7,2410,2479,7,{6,8,45})		--Southern Gate, WNE
newWayPoint("Turin",  8,2406,2479,7,{7,9})
newWayPoint("Turin",  9,2402,2479,7,{8,10,12})		--Southern Gate, ESW
newWayPoint("Turin", 10,2402,2484,7,{9,11})		
newWayPoint("Turin", 11,2402,2489,7,{10,0})
newWayPoint("Turin", 12,2397,2479,7,{9,13})
newWayPoint("Turin", 13,2391,2479,7,{12,14,38})		--Junction WNE
newWayPoint("Turin", 14,2386,2479,7,{13,15})
newWayPoint("Turin", 15,2381,2479,7,{14,16})	
newWayPoint("Turin", 16,2378,2479,7,{15,17,20})		--Junction ESW
newWayPoint("Turin", 17,2378,2484,7,{16,18})
newWayPoint("Turin", 18,2378,2488,7,{17,19})
newWayPoint("Turin", 19,2378,2493,7,{18})		--Dead End, alley
newWayPoint("Turin", 20,2374,2479,7,{16,21})	
newWayPoint("Turin", 21,2370,2479,7,{20,22})
newWayPoint("Turin", 22,2366,2479,7,{21,23})
newWayPoint("Turin", 23,2371,2479,7,{22,24})
newWayPoint("Turin", 24,2371,2474,7,{23,25})
newWayPoint("Turin", 25,2371,2469,7,{24,26})	
newWayPoint("Turin", 26,2371,2465,7,{25,27})
newWayPoint("Turin", 27,2371,2460,7,{26,28,32,68})	--Junction +
newWayPoint("Turin", 28,2366,2459,7,{27,29})
newWayPoint("Turin", 29,2360,2459,7,{28,30})
newWayPoint("Turin", 30,2360,2455,7,{29,31})	
newWayPoint("Turin", 31,2360,2452,7,{30})		--Dead end, shore house
newWayPoint("Turin", 32,2376,2461,7,{27,33})
newWayPoint("Turin", 33,2381,2461,7,{32,34})
newWayPoint("Turin", 34,2386,2461,7,{33,35})
newWayPoint("Turin", 35,2391,2461,7,{34,36,39})		--Junction -
newWayPoint("Turin", 36,2391,2466,7,{35,37})
newWayPoint("Turin", 37,2391,2471,7,{36,38})
newWayPoint("Turin", 38,2391,2475,7,{37,13})
newWayPoint("Turin", 39,2396,2461,7,{35,40})
newWayPoint("Turin", 40,2399,2461,7,{39,41,60})		--Junction -
newWayPoint("Turin", 41,2404,2461,7,{40,42})
newWayPoint("Turin", 42,2409,2461,7,{41,43,46})		--Junction -
newWayPoint("Turin", 43,2409,2466,7,{42,44})
newWayPoint("Turin", 44,2409,2471,7,{43,45})
newWayPoint("Turin", 45,2409,2475,7,{44,7})		
newWayPoint("Turin", 46,2414,2461,7,{42,47})
newWayPoint("Turin", 47,2419,2461,7,{46,48})
newWayPoint("Turin", 48,2423,2461,7,{47,49})
newWayPoint("Turin", 49,2428,2461,7,{48,50,208})	--Junction -
newWayPoint("Turin", 50,2428,2456,7,{49,51})
newWayPoint("Turin", 51,2428,2451,7,{50,52})
newWayPoint("Turin", 52,2428,2447,7,{51,53,86,188})	--Junction NESW
newWayPoint("Turin", 53,2423,2447,7,{52,54})
newWayPoint("Turin", 54,2418,2447,7,{53,55})
newWayPoint("Turin", 55,2413,2447,7,{54,56})
newWayPoint("Turin", 56,2408,2447,7,{55,57})
newWayPoint("Turin", 57,2403,2447,7,{56,58})
newWayPoint("Turin", 58,2399,2447,7,{57,59,61})		--Junction +
newWayPoint("Turin", 59,2401,2452,7,{58,60})
newWayPoint("Turin", 60,2401,2457,7,{59,40})
newWayPoint("Turin", 61,2394,2447,7,{58,62})
newWayPoint("Turin", 62,2389,2447,7,{61,63})
newWayPoint("Turin", 63,2385,2447,7,{62,64})
newWayPoint("Turin", 64,2381,2447,7,{63,65})
newWayPoint("Turin", 65,2376,2447,7,{64,66})
newWayPoint("Turin", 66,2372,2447,7,{65,67,69})		--Junction NES
newWayPoint("Turin", 67,2372,2452,7,{66,68})
newWayPoint("Turin", 68,2372,2456,7,{67,27})
newWayPoint("Turin", 69,2372,2442,7,{66,70})
newWayPoint("Turin", 70,2372,2437,7,{69,71})
newWayPoint("Turin", 71,2372,2433,7,{70,72})
newWayPoint("Turin", 72,2377,2433,7,{71,73})
newWayPoint("Turin", 73,2382,2433,7,{72,74})
newWayPoint("Turin", 74,2387,2433,7,{73,75})
newWayPoint("Turin", 75,2392,2433,7,{74,76,103})	--Junction SWN
newWayPoint("Turin", 76,2398,2434,7,{75,77,79})		--Junction ESW
newWayPoint("Turin", 77,2401,2439,7,{76,78})
newWayPoint("Turin", 78,2401,2443,7,{77,58})
newWayPoint("Turin", 79,2401,2434,7,{76,80})		
newWayPoint("Turin", 80,2406,2434,7,{79,81})
newWayPoint("Turin", 81,2412,2434,7,{80,82,94})		--Junction WNE
newWayPoint("Turin", 82,2417,2434,7,{81,83})
newWayPoint("Turin", 83,2422,2434,7,{82,84})
newWayPoint("Turin", 84,2428,2434,7,{83,85,87})		--Junction SWN
newWayPoint("Turin", 85,2428,2439,7,{84,86})
newWayPoint("Turin", 86,2428,2443,7,{85,52})
newWayPoint("Turin", 87,2428,2429,7,{84,88})
newWayPoint("Turin", 88,2428,2424,7,{87,89})
newWayPoint("Turin", 89,2424,2422,7,{88,90,119})	--Junction WNE
newWayPoint("Turin", 90,2419,2422,7,{89,91})
newWayPoint("Turin", 91,2415,2422,7,{90,92})
newWayPoint("Turin", 92,2412,2422,7,{91,93,95})		--Junction ESW
newWayPoint("Turin", 93,2412,2427,7,{92,94})
newWayPoint("Turin", 94,2412,2431,7,{93,81})
newWayPoint("Turin", 95,2412,2422,7,{92,96})
newWayPoint("Turin", 96,2407,2422,7,{95,97})
newWayPoint("Turin", 97,2402,2422,7,{96,100})
newWayPoint("Turin", 98,2402,2427,7,{97,})
newWayPoint("Turin", 99,2402,2431,7,{79})
newWayPoint("Turin",100,2397,2422,7,{97,101})
newWayPoint("Turin",101,2392,2422,7,{100,102,104})	--Junction NES
newWayPoint("Turin",102,2392,2427,7,{101,103})
newWayPoint("Turin",103,2392,2430,7,{102,75})
newWayPoint("Turin",104,2391,2419,7,{101,105,107})	--Junction SWN
newWayPoint("Turin",105,2387,2419,7,{104,106})
newWayPoint("Turin",106,2383,2419,7,{105})		--Dead End Shop area
newWayPoint("Turin",107,2391,2415,7,{104,108})
newWayPoint("Turin",108,2395,2415,7,{107,109})
newWayPoint("Turin",109,2395,2410,7,{108,110})
newWayPoint("Turin",110,2395,2405,7,{109,111})
newWayPoint("Turin",111,2399,2402,7,{110,112,120})	--Junction WNE
newWayPoint("Turin",112,2404,2402,7,{111,113})
newWayPoint("Turin",113,2409,2402,7,{112,114})
newWayPoint("Turin",114,2414,2402,7,{113,115})
newWayPoint("Turin",115,2419,2402,7,{114,116,127})	--Junction WNE
newWayPoint("Turin",116,2424,2403,7,{115,117,144})	--Junction ESW
newWayPoint("Turin",117,2424,2408,7,{116,118})
newWayPoint("Turin",118,2424,2413,7,{117,119})
newWayPoint("Turin",119,2424,2418,7,{118,89})
newWayPoint("Turin",120,2399,2396,7,{111,121})
newWayPoint("Turin",121,2401,2391,7,{120,122})
newWayPoint("Turin",122,2406,2391,7,{121,123})
newWayPoint("Turin",123,2411,2391,7,{122,124})
newWayPoint("Turin",124,2416,2391,7,{123,125})
newWayPoint("Turin",125,2419,2391,7,{124,126,128})	--Junction SWN
newWayPoint("Turin",126,2419,2396,7,{125,127})
newWayPoint("Turin",127,2419,2400,7,{126,115})
newWayPoint("Turin",128,2419,2386,7,{125,129})
newWayPoint("Turin",129,2422,2381,7,{128,130})
newWayPoint("Turin",130,2425,2378,7,{129,131,})
newWayPoint("Turin",131,2426,2378,7,{130,132})
newWayPoint("Turin",132,2426,2377,7,{131,133})
newWayPoint("Turin",133,2426,2375,7,{132,134,136})	--Junction ESW
newWayPoint("Turin",134,2423,2374,7,{133,135})
newWayPoint("Turin",135,2423,2369,7,{134})		--Dead End NorthWest city
newWayPoint("Turin",136,2431,2375,7,{133,137})
newWayPoint("Turin",137,2437,2376,7,{136,138,158})	--Junction ESW
newWayPoint("Turin",138,2437,2381,7,{137,139})
newWayPoint("Turin",139,2437,2386,7,{138,140})
newWayPoint("Turin",140,2437,2391,7,{139,141})
newWayPoint("Turin",141,2437,2396,7,{140,142})
newWayPoint("Turin",142,2437,2402,7,{141,143,145})	--Junction WNE
newWayPoint("Turin",143,2432,2402,7,{142,144})
newWayPoint("Turin",144,2428,2402,7,{143,116})
newWayPoint("Turin",145,2442,2402,7,{142,146})
newWayPoint("Turin",146,2447,2402,7,{145,147})
newWayPoint("Turin",147,2452,2402,7,{146,148})
newWayPoint("Turin",148,2457,2402,7,{147,149,151})	--Junction SWN
newWayPoint("Turin",149,2457,2407,7,{148,150})
newWayPoint("Turin",150,2457,2412,7,{149,212})		--Dead End Citadel North
newWayPoint("Turin",151,2457,2397,7,{148,152})
newWayPoint("Turin",152,2457,2392,7,{151,153})
newWayPoint("Turin",153,2457,2388,7,{152,154,159})	--Junction NES
newWayPoint("Turin",154,2457,2383,7,{153,155})
newWayPoint("Turin",155,2457,2377,7,{154,156})
newWayPoint("Turin",156,2452,2377,7,{155,157})
newWayPoint("Turin",157,2447,2377,7,{156,158})
newWayPoint("Turin",158,2442,2377,7,{157,137})
newWayPoint("Turin",159,2462,2388,7,{153,160})
newWayPoint("Turin",160,2467,2388,7,{159,161})
newWayPoint("Turin",161,2471,2388,7,{160,162})
newWayPoint("Turin",162,2474,2388,7,{161,163})
newWayPoint("Turin",163,2474,2393,7,{162,164})
newWayPoint("Turin",164,2474,2398,7,{163,165})
newWayPoint("Turin",165,2474,2403,7,{164,166})
newWayPoint("Turin",166,2474,2408,7,{165,167})
newWayPoint("Turin",167,2474,2413,7,{166,168})
newWayPoint("Turin",168,2474,2418,7,{167,169,170})	--Junction SWN
newWayPoint("Turin",169,2469,2419,7,{168,209})
newWayPoint("Turin",170,2474,2423,7,{168,171})
newWayPoint("Turin",171,2479,2423,7,{170,172})
newWayPoint("Turin",172,2484,2423,7,{171,173})
newWayPoint("Turin",173,2484,2428,7,{172,174})
newWayPoint("Turin",174,2479,2428,7,{173,175})
newWayPoint("Turin",175,2477,2431,7,{174,176})
newWayPoint("Turin",176,2477,2435,7,{175,177})
newWayPoint("Turin",177,2476,2438,7,{176,178})
newWayPoint("Turin",178,2472,2439,7,{177,179})
newWayPoint("Turin",179,2472,2443,7,{178,180})
newWayPoint("Turin",180,2472,2447,7,{179,181,189})	--Junction SWN
newWayPoint("Turin",181,2467,2447,7,{180,182})
newWayPoint("Turin",182,2462,2447,7,{181,183})
newWayPoint("Turin",183,2457,2447,7,{182,184})
newWayPoint("Turin",184,2452,2447,7,{183,185})
newWayPoint("Turin",185,2447,2447,7,{184,186})
newWayPoint("Turin",186,2442,2446,7,{185,187})
newWayPoint("Turin",187,2437,2446,7,{186,188})
newWayPoint("Turin",188,2432,2446,7,{187,52})
newWayPoint("Turin",189,2472,2450,7,{180,190})
newWayPoint("Turin",190,2472,2455,7,{189,191})
newWayPoint("Turin",191,2472,2460,7,{190,192})
newWayPoint("Turin",192,2472,2464,7,{191,193})
newWayPoint("Turin",193,2472,2468,7,{192,194})
newWayPoint("Turin",194,2467,2468,7,{193,195})
newWayPoint("Turin",195,2462,2468,7,{194,196})
newWayPoint("Turin",196,2457,2468,7,{195,197})
newWayPoint("Turin",197,2452,2468,7,{196,198})
newWayPoint("Turin",198,2447,2468,7,{197,199,204})	--Junction ESW
newWayPoint("Turin",199,2447,2473,7,{198,200})
newWayPoint("Turin",200,2447,2478,7,{199,201})
newWayPoint("Turin",201,2442,2478,7,{200,202})
newWayPoint("Turin",202,2438,2478,7,{201,203})
newWayPoint("Turin",203,2438,2483,7,{202})		--Dead End SouthEast City
newWayPoint("Turin",204,2442,2468,7,{198,205})
newWayPoint("Turin",205,2437,2468,7,{204,206})
newWayPoint("Turin",206,2432,2470,7,{205,207})
newWayPoint("Turin",207,2434,2466,7,{206,208})
newWayPoint("Turin",208,2434,2461,7,{207,49})
newWayPoint("Turin",209,2465,2419,7,{169,210})
newWayPoint("Turin",210,2460,2419,7,{209,211})
newWayPoint("Turin",211,2455,2419,7,{210,212})
newWayPoint("Turin",212,2456,2415,7,{211,150})

newWayPoint("Krynn",1,3627,2443,7,{2}) 	-- Boat
newWayPoint("Krynn",2,3627,2448,7,{1,3})
newWayPoint("Krynn",3,3627,2453,7,{2,4})
newWayPoint("Krynn",4,3627,2458,7,{3,5})
newWayPoint("Krynn",5,3632,2458,7,{4,6})
newWayPoint("Krynn",6,3637,2460,7,{5,7}) -- Market
newWayPoint("Krynn",7,3642,2461,7,{6,8})
newWayPoint("Krynn",8,3643,2466,7,{7,9})
newWayPoint("Krynn",9,3643,2472,7,{8,10,12}) -- Crossroad
newWayPoint("Krynn",10,3637,2473,7,{9,11})
newWayPoint("Krynn",11,3632,2473,7,{10}) 	-- Town Exit
newWayPoint("Krynn",12,3649,2473,7,{9})  -- Temple
