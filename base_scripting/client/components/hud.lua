-- -- ui adjustments
-- local ui_text_adjust = 0.0
-- local ui_bars_adjust = 0.0

-- local show_ui = false
-- local show_hud = true
-- local admin_map = false
-- local belt_on   = false
-- local ultra_wide = false

-- local player_health = 0.0
-- local player_armour = 0.0
-- local player_breath = 0.0
-- local player_food   = 0.0
-- local player_water  = 0.0

-- local range_current = 1
-- local range_setting = {
-- 	[3] = 20,
-- 	[1] = 50,
-- 	[2] = 90,
-- }

-- -- for the hud
-- local aop = "city"
-- local face   = ""
-- local area 	 = ""
-- local street = ""
-- local aop_label = {['city'] = "~b~City", ['county'] = "~y~County", ['map'] = "~r~Map"}

-- RegisterNetEvent('updateaop')
-- AddEventHandler('updateaop', function(newaop) aop = newaop end)

-- local zones = { 
-- 	['AIRP'] = "Los Santos International Airport", 
-- 	['ALAMO'] = "Alamo Sea", 
-- 	['ALTA'] = "Alta", 
-- 	['ARMYB'] = "Fort Zancudo", 
-- 	['BANHAMC'] = "Banham Canyon Dr", 
-- 	['BANNING'] = "Banning", 
-- 	['BEACH'] = "Vespucci Beach", 
-- 	['BHAMCA'] = "Banham Canyon", 
-- 	['BRADP'] = "Braddock Pass", 
-- 	['BRADT'] = "Braddock Tunnel", 
-- 	['BURTON'] = "Burton", 
-- 	['CALAFB'] = "Calafia Bridge", 
-- 	['CANNY'] = "Raton Canyon", 
-- 	['CCREAK'] = "Cassidy Creek", 
-- 	['CHAMH'] = "Chamberlain Hills", 
-- 	['CHIL'] = "Vinewood Hills", 
-- 	['CHU'] = "Chumash", 
-- 	['CMSW'] = "Chiliad Mountain State Wilderness", 
-- 	['CYPRE'] = "Cypress Flats", 
-- 	['DAVIS'] = "Davis", 
-- 	['DELBE'] = "Del Perro Beach", 
-- 	['DELPE'] = "Del Perro", 
-- 	['DELSOL'] = "La Puerta", 
-- 	['DESRT'] = "Grand Senora Desert", 
-- 	['DOWNT'] = "Downtown", 
-- 	['DTVINE'] = "Downtown Vinewood", 
-- 	['EAST_V'] = "East Vinewood", 
-- 	['EBURO'] = "El Burro Heights", 
-- 	['ELGORL'] = "El Gordo Lighthouse", 
-- 	['ELYSIAN'] = "Elysian Island", 
-- 	['GALFISH'] = "Galilee", 
-- 	['GOLF'] = "GWC and Golfing Society", 
-- 	['GRAPES'] = "Grapeseed", 
-- 	['GREATC'] = "Great Chaparral", 
-- 	['HARMO'] = "Harmony", 
-- 	['HAWICK'] = "Hawick", 
-- 	['HORS'] = "Vinewood Racetrack", 
-- 	['HUMLAB'] = "Humane Labs and Research", 
-- 	['JAIL'] = "Bolingbroke Penitentiary", 
-- 	['KOREAT'] = "Little Seoul", 
-- 	['LACT'] = "Land Act Reservoir", 
-- 	['LAGO'] = "Lago Zancudo", 
-- 	['LDAM'] = "Land Act Dam", 
-- 	['LEGSQU'] = "Legion Square", 
-- 	['LMESA'] = "La Mesa", 
-- 	['LOSPUER'] = "La Puerta", 
-- 	['MIRR'] = "Mirror Park", 
-- 	['MORN'] = "Morningwood", 
-- 	['MOVIE'] = "Richards Majestic", 
-- 	['MTCHIL'] = "Mount Chiliad", 
-- 	['MTGORDO'] = "Mount Gordo", 
-- 	['MTJOSE'] = "Mount Josiah", 
-- 	['MURRI'] = "Murrieta Heights", 
-- 	['NCHU'] = "North Chumash", 
-- 	['NOOSE'] = "N.O.O.S.E", 
-- 	['OCEANA'] = "Pacific Ocean", 
-- 	['PALCOV'] = "Paleto Cove", 
-- 	['PALETO'] = "Paleto Bay", 
-- 	['PALFOR'] = "Paleto Forest", 
-- 	['PALHIGH'] = "Palomino Highlands", 
-- 	['PALMPOW'] = "Palmer-Taylor Power Station", 
-- 	['PBLUFF'] = "Pacific Bluffs", 
-- 	['PBOX'] = "Pillbox Hill", 
-- 	['PROCOB'] = "Procopio Beach", 
-- 	['RANCHO'] = "Rancho", 
-- 	['RGLEN'] = "Richman Glen", 
-- 	['RICHM'] = "Richman", 
-- 	['ROCKF'] = "Rockford Hills", 
-- 	['RTRAK'] = "Redwood Lights Track", 
-- 	['SANAND'] = "San Andreas", 
-- 	['SANCHIA'] = "San Chianski Mountain Range", 
-- 	['SANDY'] = "Sandy Shores", 
-- 	['SKID'] = "Mission Row", 
-- 	['SLAB'] = "Stab City", 
-- 	['STAD'] = "Maze Bank Arena", 
-- 	['STRAW'] = "Strawberry", 
-- 	['TATAMO'] = "Tataviam Mountains", 
-- 	['TERMINA'] = "Terminal", 
-- 	['TEXTI'] = "Textile City", 
-- 	['TONGVAH'] = "Tongva Hills", 
-- 	['TONGVAV'] = "Tongva Valley", 
-- 	['VCANA'] = "Vespucci Canals", 
-- 	['VESP'] = "Vespucci", 
-- 	['VINE'] = "Vinewood", 
-- 	['WINDF'] = "Ron Alternates Wind Farm", 
-- 	['WVINE'] = "West Vinewood", 
-- 	['ZANCUDO'] = "Zancudo River", 
-- 	['ZP_ORT'] = "Port of South Los Santos", 
-- 	['ZQ_UAR'] = "Davis Quartz"
-- }

-- ------------------
-- -- DATA SETTING --
-- ------------------

-- RegisterNetEvent("setFood")
-- AddEventHandler("setFood", function(_food)
-- 	player_food = _food
-- end)

-- RegisterNetEvent("setWater")
-- AddEventHandler("setWater", function(_water)
-- 	player_water = _water
-- end)

-- RegisterNetEvent("setRange")
-- AddEventHandler("setRange", function(_range)
-- 	range_current = _range
-- end)

-- RegisterNetEvent("fdg_ui:UpdateBelt")
-- AddEventHandler("fdg_ui:UpdateBelt", function(_state)
-- 	belt_on = _state
-- end)

-- local directions = {[0] = 'North',[1] = 'North-West', [2] = 'West',[3] = 'South-West',[4] = 'South',[5] = 'South-East',[6] = 'East',[7] = 'North-East',[8] = 'North'}
-- local inAir = false
-- Citizen.CreateThread(function()
-- 	while true do
-- 		------- Player Stats --------
-- 		local ped = GetPlayerPed(-1)
-- 		if (show_hud) then
-- 			player_health = GetEntityHealth(ped)
-- 			player_armour = GetPedArmour(ped)
-- 			player_breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10

-- 			player_health = player_health - 100

-- 			if (player_health > 200) then
-- 				player_health = 0
-- 			end

-- 			-- ui_text_adjust = Base.Settings.Get("ui_text") or 0.0
-- 			-- ui_bars_adjust = Base.Settings.Get("ui_bars") or 0.0

-- 			------- Streets --------
-- 			local veh = GetVehiclePedIsIn(ped, false)
-- 			local inVeh = (veh ~= 0)
-- 			if (inVeh or show_ui) then
-- 				local veh_class = GetVehicleClass(veh)
-- 				inAir = ((veh_class == 15) or (veh_class == 16))

-- 				local x, y, z = table.unpack(GetEntityCoords(ped))
-- 				local street_1, street_2 = GetStreetNameAtCoord(x, y, z)
-- 				local face_t = directions[math.floor((GetEntityHeading(ped) + 22.5) / 45.0)]
-- 				if (face_t) then
-- 					face = face_t
-- 				end

-- 				local area_t = zones[GetNameOfZone(x, y, z)]
-- 				if (area_t) then
-- 					area = area_t
-- 				end

-- 		        if street_2 == 0 then
-- 		        	street = GetStreetNameFromHashKey(street_1)
-- 				else
-- 					street = GetStreetNameFromHashKey(street_1).." | "..GetStreetNameFromHashKey(street_2)
-- 				end

-- 				if inVeh or admin_map then
-- 					DisplayRadar(true)
-- 				else
-- 					DisplayRadar(false)
-- 				end
-- 			else
-- 				if (admin_map) then
-- 					DisplayRadar(true)
-- 				else
-- 					DisplayRadar(false)
-- 				end
-- 			end

-- 			DisplayCash(false)
-- 		end
-- 		Wait(300)
-- 	end
-- end)

-- -----------------
-- -- DRAW THREAD --
-- -----------------

-- local floats = {}
-- Citizen.CreateThread(function()
-- 	while true do
-- 		-- Main Variables / Hud
-- 		if (show_hud) then
-- 			local ui = GetMinimapAnchor()
-- 			if ultra_wide then
-- 				ui.x = ui.x + 0.119
-- 			end

-- 			ui.x = ui.x + ui_bars_adjust

-- 			local health = {x = ui.x + 0.0015, 						y = (ui.y + ui.height) - 0.005, 					w = (ui.width/2) - 0.0025, 	h = -(ui.height/16)}
-- 			local armour = {x = (ui.x + (ui.width/2)) + 0.0005, 	y = (ui.y + ui.height) - 0.005, 					w = (ui.width/2) - 0.0020, 	h = -(ui.height/16)}

-- 			local food   = {x = ui.x + 0.0015, 						y = ((ui.y + ui.height) + (ui.height/16)) - 0.003, 	w = (ui.width/3) - 0.0025, 	h = -(ui.height/16)}
-- 			local water  = {x = (ui.x + (ui.width/3)) + 0.0005, 	y = ((ui.y + ui.height) + (ui.height/16)) - 0.003, 	w = (ui.width/3) - 0.002, 	h = -(ui.height/16)}
-- 			local voice  = {x = (ui.x + (ui.width/3*2)) + 0.0005,  	y = ((ui.y + ui.height) + (ui.height/16)) - 0.003, 	w = (ui.width/3) - 0.002, 	h = -(ui.height/16)}

-- 			-- Draw the main background boxes
-- 			drawRct(ui.x, (ui.y + ui.height) + 0.01, ui.width, -(ui.height/6), 0, 0, 0, 255)

-- 			drawRct(health.x, health.y, health.w, health.h, 0,  50, 0,   100)
-- 			drawRct(armour.x, armour.y, armour.w, armour.h, 20, 80, 130, 100)
-- 			drawRct(voice.x,  voice.y,  voice.w,  voice.h,  50, 50, 50,  200)

-- 			drawRct(food.x,  food.y,  food.w,  food.h, 150, 50,  30, 100)
-- 			drawRct(water.x, water.y, water.w, water.h, 40, 100, 150, 100)

-- 			-- Draw the current stats
-- 			drawRct(health.x, health.y, ((health.w/100) * player_health), health.h, 60, 160, 60,  100)
-- 			drawRct(armour.x, armour.y, ((armour.w/100) * player_armour), armour.h, 80, 109, 197, 100)
-- 			drawRct(voice.x,  voice.y,  ((voice.w/100)  * range_setting[range_current]),  voice.h, 255, 20, 147, 70)
-- 			drawRct(food.x,   food.y,   ((food.w/100)   * (player_food)),  food.h, 150, 50,  30, 100)
-- 			drawRct(water.x,  water.y,  ((water.w/100)  * (player_water)), water.h, 40, 100, 150, 100)

-- 			if NetworkIsPlayerTalking(PlayerId()) then
-- 				drawRct(voice.x,  voice.y,  voice.w,  voice.h,  255, 20, 147, 100)
-- 			end

-- 			-- Text Hud
-- 			local ped = PlayerPedId()

-- 			if (IsPedInAnyVehicle(ped, true)) then
-- 				local veh = GetVehiclePedIsIn(ped, false)
				
-- 				if (DoesEntityExist(veh) and GetVehicleClass(veh) ~= 13 or show_ui) then
-- 					local base_speed = GetEntitySpeed(veh)
-- 					local speed_km = base_speed * 3.6
-- 					local speed_kn = base_speed * 1.944
-- 					local fuel  = GetVehicleFuelLevel(veh)
-- 					local start = 0.665
-- 					if ultra_wide then
-- 						start = 0.785
-- 					end

-- 					start = start + ui_text_adjust

-- 					if (veh ~= 0) then
-- 						if (inAir) then -- 0.113 -- 0.094
-- 							local air_pos = GetEntityCoords(veh)
-- 							local air_height = (air_pos.z * 3.281)

-- 							if (speed_kn < 1) then
-- 								drawHudTxt(start, 1.37, 1.0, 1.0, 0.5,  "0", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start, 1.37, 1.0, 1.0, 0.5,  math.floor(speed_kn), 200, 200, 200, 255, 4)
-- 							end
-- 							drawHudTxt(start + 0.017, 1.375, 1.0, 1.0, 0.35, "knots", 200, 200, 200, 255, 4)

-- 							if (air_height < 1) then
-- 								drawHudTxt(start + 0.047, 1.37, 1.0, 1.0, 0.5,  "0", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start + 0.047, 1.37, 1.0, 1.0, 0.5,  math.floor(air_height), 200, 200, 200, 255, 4)
-- 							end
-- 							drawHudTxt(start + 0.068, 1.375, 1.0, 1.0, 0.35, "ALT", 200, 200, 200, 255, 4)

-- 							if (fuel < 1) then
-- 								drawHudTxt(start + 0.09, 1.37, 1.0, 1.0, 0.5, "0", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start + 0.09, 1.37, 1.0, 1.0, 0.5, math.floor(fuel), 200, 200, 200, 255, 4)
-- 							end
-- 							drawHudTxt(start + 0.109, 1.375, 1.0, 1.0, 0.35, "FUEL", 200, 200, 200, 255, 4)

-- 						else
-- 							if (speed_km < 1) then
-- 								drawHudTxt(start, 1.37, 1.0, 1.0, 0.5,  "0", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start, 1.37, 1.0, 1.0, 0.5,  math.floor(speed_km), 200, 200, 200, 255, 4)
-- 							end
-- 							drawHudTxt(start + 0.017, 1.375, 1.0, 1.0, 0.35, "km/h", 200, 200, 200, 255, 4)

-- 							if (fuel < 1) then
-- 								drawHudTxt(start + 0.047, 1.37, 1.0, 1.0, 0.5, "0", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start + 0.047, 1.37, 1.0, 1.0, 0.5, math.floor(fuel), 200, 200, 200, 255, 4)
-- 							end
-- 							drawHudTxt(start + 0.065, 1.375, 1.0, 1.0, 0.35, "FUEL", 200, 200, 200, 255, 4)

-- 							if (belt_on) then
-- 								drawHudTxt(start + 0.095, 1.37, 1.0, 1.0, 0.5, "~g~BELT", 200, 200, 200, 255, 4)
-- 							else
-- 								drawHudTxt(start + 0.095, 1.37, 1.0, 1.0, 0.5, "~r~BELT", 200, 200, 200, 255, 4)
-- 							end
-- 						end
-- 					end

-- 					drawHudTxt(start, 1.4125, 1.0, 1.0, 0.5, face.." | "..street, 200, 200, 200, 255, 4)
-- 					drawHudTxt(start, 1.455, 1.0, 1.0, 0.5, area.." | "..aop_label[aop or "city"], 200, 200, 200, 255, 4)
-- 				end
-- 			end
-- 		end

-- 		if (IsControlJustPressed(1, 19) and GetLastInputMethod(2)) then
-- 			show_ui = not show_ui
-- 		end

-- 		if (IsControlPressed(1, 19)) then
-- 			if (IsControlJustPressed(1, 74)) then
-- 				show_hud = not show_hud
-- 			end
-- 		end 

-- 		HideHudComponentThisFrame(3)
-- 		HideHudComponentThisFrame(4)
-- 		HideHudComponentThisFrame(6)
-- 		HideHudComponentThisFrame(7)
-- 		HideHudComponentThisFrame(8)
-- 		HideHudComponentThisFrame(9)

-- 		Wait(1)
-- 	end
-- end)

-- -------------
-- -- METHODS --
-- -------------

-- function drawRct(x,y,width,height,r,g,b,a)
-- 	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
-- end

-- function drawHudTxt(x, y, width, height, scale, text, r, g, b, a, font)
--     SetTextFont(font)
--     SetTextProportional(0)
--     SetTextScale(scale, scale)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(2, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x - width/2, y - height/2 + 0.005)
-- end

-- function GetMinimapAnchor()
--     -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
--     -- 0.05 * ((safezone - 0.9) * 10)
--     local safezone = GetSafeZoneSize()
--     local safezone_x = 1.0 / 20.0
--     local safezone_y = 1.0 / 20.0
--     local aspect_ratio = GetAspectRatio(0)
--     local res_x, res_y = GetActiveScreenResolution()
--     local xscale = 1.0 / res_x
--     local yscale = 1.0 / res_y
--     local Minimap = {}
--     Minimap.width = xscale * (res_x / (4 * aspect_ratio))
--     Minimap.height = yscale * (res_y / 5.674)
--     Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
--     Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
--     Minimap.right_x = Minimap.left_x + Minimap.width
--     Minimap.top_y = Minimap.bottom_y - Minimap.height
--     Minimap.x = Minimap.left_x
--     Minimap.y = Minimap.top_y
--     Minimap.xunit = xscale
--     Minimap.yunit = yscale
--     return Minimap
-- end

-- RegisterNetEvent('fdg_ui:toggleAdmin')
-- AddEventHandler('fdg_ui:toggleAdmin', function(toggle)
-- 	admin_map = toggle
-- end)

-- RegisterNetEvent("fdg_ui:toggleUltraWide")
-- AddEventHandler("fdg_ui:toggleUltraWide", function()
-- 	ultra_wide = not ultra_wide
-- end)