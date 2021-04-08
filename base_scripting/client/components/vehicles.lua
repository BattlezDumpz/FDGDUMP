Base.Vehicles = {}

Base.Vehicles.Props = {}
Base.Vehicles.Damage = {}
Base.Vehicles.Custom = {}

Base.Vehicles.Labels = {}

Base.Vehicles.GetLabel = function(vehicle)
	if (type(vehicle) == "string") then vehicle = GetHashKey(vehicle) end
	if (Base.Vehicles.Labels[vehicle]) then return Base.Vehicles.Labels[vehicle] end
	return "Unk"
end

Base.Vehicles.GetClosestVehicle = function(ped, maxDistance, canReturnVehicleInside)
  local veh = nil
  local smallestDistance = maxDistance
  local pedCoords = GetEntityCoords(ped)

  if canReturnVehicleInside then
    if ( IsPedSittingInAnyVehicle( ped ) ) then 
      veh = GetVehiclePedIsIn( ped, false )
    else
      for vehicle in EnumerateVehicles() do
        local vehCoords = GetEntityCoords(vehicle)
        local dist = GetDistanceBetweenCoords(pedCoords, vehCoords, true)
        if dist < smallestDistance then
          smallestDistance = dist
          veh = vehicle
        end
      end
    end
  else
  	local inVehicle = -1
  	if (IsPedSittingInAnyVehicle(ped)) then 
      inVehicle = GetVehiclePedIsIn(ped, false)
    end

    for vehicle in EnumerateVehicles() do
      local vehCoords = GetEntityCoords(vehicle)
      local dist = GetDistanceBetweenCoords(pedCoords, vehCoords, true)
      if dist < smallestDistance and vehicle ~= inVehicle then
        smallestDistance = dist
        veh = vehicle
      end
    end
  end

  return veh, smallestDistance
end

Base.Vehicles.getPlayersInVehicle = function(vehicle)
	local ids = {}
	local playerPed = PlayerPedId()
	local vehicle = vehicle or GetVehiclePedIsUsing(playerPed)

	if DoesEntityExist(vehicle) then
		for i=-1, GetVehicleMaxNumberOfPassengers(vehicle) do
			local ped = GetPedInVehicleSeat(vehicle, i)
			if DoesEntityExist(ped) and ped ~= playerPed then
				table.insert(ids, GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped)))
			end
		end
	end

	return ids
end

Base.Vehicles.GetVehiclesInRadius = function(ped, radius)
  local vehs = {}
  local pedCoords = GetEntityCoords(ped)

  for vehicle in EnumerateVehicles() do
    local vehCoords = GetEntityCoords(vehicle)
    local dist = GetDistanceBetweenCoords(pedCoords, vehCoords, true)
    if dist < radius then
      table.insert(vehs, vehicle)
    end
  end

  return vehs
end

Base.Vehicles.Spawn = function(model, coords, cb, localFlag)
	if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		-- does model exist in files?
		if (not IsModelInCdimage(model)) then
			return
		end

		-- Load Model
	    RequestModel(model)
	    while not HasModelLoaded(model) do
	        Citizen.Wait(0)
	    end

		local vehicle

		-- Spawn Vehicle
		if localFlag then
			vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.r, false, false)
		else
			vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.r, true, true)

			NetworkRegisterEntityAsNetworked(vehicle)
		    local id = NetworkGetNetworkIdFromEntity(vehicle)
		    SetNetworkIdExistsOnAllMachines(id, true)
		    SetNetworkIdCanMigrate(id, true)
		end

	    -- Other Vehicle Setup
	    SetEntityAsMissionEntity(vehicle, true, false)
	    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	    SetVehicleNeedsToBeHotwired(vehicle, false)
	    SetModelAsNoLongerNeeded(model)
		SetVehRadioStation(vehicle, 'OFF')
		exports['core_vehicles']:SetVehicleFuel(vehicle, math.random(200, 800) / 10) -- just incase

	    -- Repair and set vehicle
	    SetVehicleOnGroundProperly(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0.0)

	    -- Load Collision
	    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
	    while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
	    end			    

		if cb ~= nil then
	      	cb(vehicle)
	    end
  	else
  	    TriggerEvent('fdg_ui:SendNotification', 'Vehicle Spawn is blocked.', {type = 'error', progressBar = false})
  	end
end

Base.Vehicles.Delete = function(vehicle)
	Base.DeleteEntity(vehicle)
end

Base.Vehicles.Props.Get = function(vehicle, props)
	local color1, color2               = GetVehicleColours(vehicle)
  	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  	local extras = {}
  	for i=1, 30, 1 do
		if DoesExtraExist(vehicle, i) then
			if IsVehicleExtraTurnedOn(vehicle, i) then
				extras[i] = true
			else
				extras[i] = false
			end
		end
	end

  	return {

	    model             = GetEntityModel(vehicle),

	    plate             = GetVehicleNumberPlateText(vehicle),
	    plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

	    health            = GetVehicleEngineHealth(vehicle),
	    dirtLevel         = GetVehicleDirtLevel(vehicle),

	    color1            = color1,
	    color2            = color2,

	    pearlescentColor  = pearlescentColor,
	    wheelColor        = wheelColor,

	    wheels            = GetVehicleWheelType(vehicle),
	    windowTint        = GetVehicleWindowTint(vehicle),

	    neonEnabled       = {
	      IsVehicleNeonLightEnabled(vehicle, 0),
	      IsVehicleNeonLightEnabled(vehicle, 1),
	      IsVehicleNeonLightEnabled(vehicle, 2),
	      IsVehicleNeonLightEnabled(vehicle, 3),
	    },

	    neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
	    tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

	    modSpoilers       = GetVehicleMod(vehicle, 0),
	    modFrontBumper    = GetVehicleMod(vehicle, 1),
	    modRearBumper     = GetVehicleMod(vehicle, 2),
	    modSideSkirt      = GetVehicleMod(vehicle, 3),
	    modExhaust        = GetVehicleMod(vehicle, 4),
	    modFrame          = GetVehicleMod(vehicle, 5),
	    modGrille         = GetVehicleMod(vehicle, 6),
	    modHood           = GetVehicleMod(vehicle, 7),
	    modFender         = GetVehicleMod(vehicle, 8),
	    modRightFender    = GetVehicleMod(vehicle, 9),
	    modRoof           = GetVehicleMod(vehicle, 10),

	    modEngine         = GetVehicleMod(vehicle, 11),
	    modBrakes         = GetVehicleMod(vehicle, 12),
	    modTransmission   = GetVehicleMod(vehicle, 13),
	    modHorns          = GetVehicleMod(vehicle, 14),
	    modSuspension     = GetVehicleMod(vehicle, 15),
	    modArmor          = GetVehicleMod(vehicle, 16),

	    modTurbo          = IsToggleModOn(vehicle,  18),
	    modSmokeEnabled   = IsToggleModOn(vehicle,  20),
		modXenon          = IsToggleModOn(vehicle,  22),
		modLights 		  = GetVehicleXenonLightsColour(vehicle),

	    modFrontWheels    = GetVehicleMod(vehicle, 23),
	    modBackWheels     = GetVehicleMod(vehicle, 24),
	    modCustomTires    = GetVehicleModVariation(vehicle, 23),

	    modPlateHolder    = GetVehicleMod(vehicle, 25),
	    modVanityPlate    = GetVehicleMod(vehicle, 26),
	    modTrimA          = GetVehicleMod(vehicle, 27),
	    modOrnaments      = GetVehicleMod(vehicle, 28),
	    modDashboard      = GetVehicleMod(vehicle, 29),
	    modDial           = GetVehicleMod(vehicle, 30),
	    modDoorSpeaker    = GetVehicleMod(vehicle, 31),
	    modSeats          = GetVehicleMod(vehicle, 32),
	    modSteeringWheel  = GetVehicleMod(vehicle, 33),
	    modShifterLeavers = GetVehicleMod(vehicle, 34),
	    modAPlate         = GetVehicleMod(vehicle, 35),
	    modSpeakers       = GetVehicleMod(vehicle, 36),
	    modTrunk          = GetVehicleMod(vehicle, 37),
	    modHydrolic       = GetVehicleMod(vehicle, 38),
	    modEngineBlock    = GetVehicleMod(vehicle, 39),
	    modAirFilter      = GetVehicleMod(vehicle, 40),
	    modStruts         = GetVehicleMod(vehicle, 41),
	    modArchCover      = GetVehicleMod(vehicle, 42),
	    modAerials        = GetVehicleMod(vehicle, 43),
	    modTrimB          = GetVehicleMod(vehicle, 44),
	    modTank           = GetVehicleMod(vehicle, 45),
	    modWindows        = GetVehicleMod(vehicle, 46),
	    modLivery         = GetVehicleMod(vehicle, 48),
	    modLivery2        = GetVehicleLivery(vehicle),
	    modExtras         = extras,
  	}
end

Base.Vehicles.Props.Set = function(vehicle, props)

	SetVehicleModKit(vehicle,  0)

	if props.plate ~= nil then
		SetVehicleNumberPlateText(vehicle,  props.plate)
	end

	if props.plateIndex ~= nil then
		SetVehicleNumberPlateTextIndex(vehicle,  props.plateIndex)
	end

	if props.health ~= nil then
		SetEntityHealth(vehicle,  props.health)
	end

	if props.dirtLevel ~= nil then
		SetVehicleDirtLevel(vehicle,  props.dirtLevel)
	end

	if props.color1 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if props.color2 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if props.pearlescentColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
	end

	if props.wheelColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
	end

	if props.wheels ~= nil then
		SetVehicleWheelType(vehicle,  props.wheels)
	end

	if props.windowTint ~= nil then
		SetVehicleWindowTint(vehicle,  props.windowTint)
	end

	if props.neonEnabled ~= nil then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end

	if props.neonColor ~= nil then
		SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if props.modSmokeEnabled ~= nil then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if props.tyreSmokeColor ~= nil then
		SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if props.modSpoilers ~= nil then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if props.modFrontBumper ~= nil then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if props.modRearBumper ~= nil then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if props.modSideSkirt ~= nil then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if props.modExhaust ~= nil then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if props.modFrame ~= nil then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if props.modGrille ~= nil then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if props.modHood ~= nil then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if props.modFender ~= nil then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if props.modRightFender ~= nil then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if props.modRoof ~= nil then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if props.modEngine ~= nil then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if props.modBrakes ~= nil then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if props.modTransmission ~= nil then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if props.modHorns ~= nil then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if props.modSuspension ~= nil then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if props.modArmor ~= nil then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if props.modTurbo ~= nil then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if props.modXenon ~= nil then
		ToggleVehicleMod(vehicle,  22, props.modXenon)
	end

	if props.modLights ~= nil then
		SetVehicleXenonLightsColour(vehicle, props.modLights)
	end

	if not props.modCustomTires then
		modCustomTires = false
	end

	if props.modFrontWheels ~= nil then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, props.modCustomTires)
	end

	if props.modBackWheels ~= nil then
		SetVehicleMod(vehicle, 24, props.modBackWheels, props.modCustomTires)
	end

	if props.modPlateHolder ~= nil then
		SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
	end

	if props.modVanityPlate ~= nil then
		SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
	end

	if props.modTrimA ~= nil then
		SetVehicleMod(vehicle, 27, props.modTrimA , false)
	end

	if props.modOrnaments ~= nil then
		SetVehicleMod(vehicle, 28, props.modOrnaments , false)
	end

	if props.modDashboard ~= nil then
		SetVehicleMod(vehicle, 29, props.modDashboard , false)
	end

	if props.modDial ~= nil then
		SetVehicleMod(vehicle, 30, props.modDial , false)
	end

	if props.modDoorSpeaker ~= nil then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
	end

	if props.modSeats ~= nil then
		SetVehicleMod(vehicle, 32, props.modSeats , false)
	end

	if props.modSteeringWheel ~= nil then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
	end

	if props.modShifterLeavers ~= nil then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
	end

	if props.modAPlate ~= nil then
		SetVehicleMod(vehicle, 35, props.modAPlate , false)
	end

	if props.modSpeakers ~= nil then
		SetVehicleMod(vehicle, 36, props.modSpeakers , false)
	end

	if props.modTrunk ~= nil then
		SetVehicleMod(vehicle, 37, props.modTrunk , false)
	end

	if props.modHydrolic ~= nil then
		SetVehicleMod(vehicle, 38, props.modHydrolic , false)
	end

	if props.modEngineBlock ~= nil then
		SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
	end

	if props.modAirFilter ~= nil then
		SetVehicleMod(vehicle, 40, props.modAirFilter , false)
	end

	if props.modStruts ~= nil then
		SetVehicleMod(vehicle, 41, props.modStruts , false)
	end

	if props.modArchCover ~= nil then
		SetVehicleMod(vehicle, 42, props.modArchCover , false)
	end

	if props.modAerials ~= nil then
		SetVehicleMod(vehicle, 43, props.modAerials , false)
	end

	if props.modTrimB ~= nil then
		SetVehicleMod(vehicle, 44, props.modTrimB , false)
	end

	if props.modTank ~= nil then
		SetVehicleMod(vehicle, 45, props.modTank , false)
	end

	if props.modWindows ~= nil then
		SetVehicleMod(vehicle, 46, props.modWindows , false)
	end

	if props.modLivery ~= nil then
		SetVehicleMod(vehicle, 48, props.modLivery , false)
	end

	if props.modLivery2 ~= nil then
		SetVehicleLivery(vehicle, props.modLivery2)
	end

	if props.modExtras then
		for i=0, #props.modExtras, 1 do
			if DoesExtraExist(vehicle, i) then
				if props.modExtras[i] == true then
					SetVehicleExtra(vehicle, i, 0)
				else
					SetVehicleExtra(vehicle, i, 1)
				end
			end
		end
	end
end

Base.Vehicles.Damage.Get = function(vehicle)
	local damage = {
		-- basic stuff
		['engine'] = 1000.0,
		
		-- doors
		['door0'] = 0, ['door1'] = 0, ['door2'] = 0, ['door3'] = 0, ['door4'] = 0, ['door5'] = 0, ['door6'] = 0,
		
		-- windows
		['wind0'] = 0, ['wind1'] = 0, ['wind2'] = 0, ['wind3'] = 0, ['wind4'] = 0, ['wind5'] = 0, ['wind6'] = 0, ['wind7'] = 0,
		
		-- tyres
		['tyre0'] = 0, ['tyre1'] = 0, ['tyre2'] = 0, ['tyre3'] = 0, ['tyre4'] = 0, ['tyre5'] = 0,
	}

	damage['engine'] = GetVehicleEngineHealth(vehicle)
	damage['fuel'] = exports["core_vehicles"]:GetVehicleFuel(vehicle)

	-- saves door/hood/trunk damage
	for i=0, 6, 1 do
		if DoesVehicleHaveDoor(vehicle, i) then
			if IsVehicleDoorDamaged(vehicle, i) == false then
				damage["door"..i] = 0
			else
				damage["door"..i] = IsVehicleDoorDamaged(vehicle, i)
			end
		end
	end

	-- saves window damage
	for i=0, 7, 1 do
		if IsVehicleWindowIntact(vehicle, i) then
			damage['wind'..i] = 0
		else
			damage['wind'..i] = 1
		end
	end

	-- save tires damage
	for i=0, 5, 1 do
		if IsVehicleTyreBurst(vehicle, i, false) then
			damage['tyre'..i] = 1
		else
			damage['tyre'..i] = 0
		end
	end

	return damage
end

Base.Vehicles.Damage.Set = function(vehicle, damage)
	-- apply engine damage
	SetVehicleEngineHealth(vehicle, damage['engine'] -0.01)
	if (damage['fuel']) then
		exports['core_vehicles']:SetVehicleFuel(vehicle, damage['fuel'] -0.01)
	end

	-- apply panel damage
	for i=0, 6, 1 do
		if damage['door'..i] == 1 then
			SetVehicleDoorBroken(vehicle, i, damage['door'..i])
		end
	end

	-- apply window damage
	for i=0, 7, 1 do
		if damage['wind'..i] == 1 then
			RemoveVehicleWindow(vehicle, i)
		end
	end

	for i=0, 5, 1 do
		if damage['tyre'..i] == 1 then
			SetVehicleTyreBurst(vehicle, i, true, 1000.0)
		end
	end
end

Base.Vehicles.Custom.Get = function(vehicle)
	return {
		-- nos
		nos  = DecorGetBool(vehicle, "nos"),
		nosAmount = DecorGetFloat(vehicle, "nosAmount"),

		-- custom damage
		damage = {
			tank = DecorGetFloat(vehicle, "tank"),
			axle = DecorGetFloat(vehicle, "axle"),
			
			brakes = DecorGetFloat(vehicle, "brakes"),
			clutch = DecorGetFloat(vehicle, "clutch"),

			radiator = DecorGetFloat(vehicle, "radiator"),
			transmission = DecorGetFloat(vehicle, "transmission"),
		}
	}
end

Base.Vehicles.Custom.Set = function(vehicle, mods)
	-- nos
	DecorSetBool(vehicle, "nos", mods.nos or false)
	if (mods.nos) then DecorSetFloat(vehicle, "nosAmount", mods.nosAmount or 0.0) end

	local damage = mods.damage or {}
	DecorSetFloat(vehicle, "tank", damage.tank)
	DecorSetFloat(vehicle, "axle", damage.axle)
	DecorSetFloat(vehicle, "brakes", damage.brakes)
	DecorSetFloat(vehicle, "clutch", damage.clutch)
	DecorSetFloat(vehicle, "radiator", damage.radiator)
	DecorSetFloat(vehicle, "transmission", damage.transmission)
end



RegisterNetEvent('fdg:spawnVehicle')
AddEventHandler('fdg:spawnVehicle', function(model, coords, heading, cb)
	coords.r = heading
	Base.Vehicles.Spawn(model, coords, cb)
end)

RegisterNetEvent("scripting:deleteEntity")
AddEventHandler("scripting:deleteEntity", function(netid)
	Base.DeleteEntity(NetworkGetEntityFromNetworkId(netid))
end)

RegisterNetEvent("fdg:spawnVehicleOnPed")
AddEventHandler("fdg:spawnVehicleOnPed", function(model)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local coordsTable = {x = coords.x, y = coords.y, z = coords.z, r = GetEntityHeading(GetPlayerPed(-1))}

	Base.Vehicles.Spawn(model, coordsTable, function(vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
	end)
end)

-- decor shit
function registerVehicleDecor(name, type)
	if ( not DecorIsRegisteredAsType(name, type) ) then
		DecorRegister(name, type)
	end
end

Citizen.CreateThread(function()
	registerVehicleDecor("nos", 2)
	registerVehicleDecor("nosAmount", 1)

	registerVehicleDecor("tank", 1)
	registerVehicleDecor("axle", 1)
	registerVehicleDecor("brakes", 1)
	registerVehicleDecor("clutch", 1)
	registerVehicleDecor("radiator", 1)
	registerVehicleDecor("transmission", 1)

	registerVehicleDecor("engineOn", 2)
	registerVehicleDecor("engineForceOff", 2)
	registerVehicleDecor("indicatorLeft", 2)
	registerVehicleDecor("indicatorRight", 2)
	registerVehicleDecor("hazzards", 2)

	registerVehicleDecor("siren", 1)
    registerVehicleDecor("sirenMode", 3)
	registerVehicleDecor("sirenHorn", 2)
	registerVehicleDecor("vehicleFuel", 1)


	Base.Database.onClientData("base:vehicle_labels", GetCurrentResourceName(), function(data)
		Base.Vehicles.Labels = data
	end)
end)
