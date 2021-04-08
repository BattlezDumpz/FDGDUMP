isInsideInstance = false
mutedPlayers = {}
instancedPlayers = {}

-- peds
pedsInInstance = {}
pedsInYourInstance = {}

-- vehicles
vehiclesInInstance = {}
vehiclesInYourInstance = {}

local instancedEntities = {}

function isInstanced()
	return (isInsideInstance ~= false)
end

function getInstance()
	return isInsideInstance
end

-- This event handles the local player when they first join an instance
RegisterNetEvent("instance:enteredInstance")
AddEventHandler("instance:enteredInstance", function(instance, voice)
	isInsideInstance = instance
	local playerPed = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed, true) then
		-- toggleVehicleInstanceState(instance, true)
	end
end)

-- This event handles the local player when they leave the instance
RegisterNetEvent("instance:exitedInstance")
AddEventHandler("instance:exitedInstance", function()
	isInsideInstance = false
	local playerPed = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed, true) then 
		-- toggleVehicleInstanceState(isInsideInstance, false)
	end

	-- This wait ensure the instance loop breaks before resetting
	Wait(3000)

	-- This shouldn't even be needed, but it might help with the voice issue when players exit an instance.
	for source, value in pairs(mutedPlayers) do
		print("Reset volume (on exit)", source)
		Base.Voice.setPlayerVolume(source, -1.0)
	end

	mutedPlayers = {}

	Base.Voice.resetPlayerVolumes()
	revealAllPlayers()
	revealAllPeds()
	-- revealAllVehicles()
end)

-- This event is triggered on players already in the instance, when a player joins an instance
RegisterNetEvent("instance:syncInstance")
AddEventHandler("instance:syncInstance", function(players, vehicles, peds)
	Wait(1000)
	local players = convertServerIdListToPlayerList(players)

	instancedPlayers = {}
	for i, player in ipairs(players) do 
		instancedPlayers[player] = true
	end

	Wait(500)

	concealAllPlayers()
	revealFromList(convertServerIdListToPlayerList(players))

	pedsInYourInstance = peds
	vehiclesInYourInstance = vehicles
end)

-- RegisterNetEvent("instance:setVehicleInstance")
-- AddEventHandler("instance:setVehicleInstance", function(vehicle, state)
-- 	if state then
-- 		table.insert(vehiclesInInstance, vehicle)
-- 	else
-- 		for i=1, #vehiclesInInstance do
-- 			if vehiclesInInstance[i] == vehicle then
-- 				table.remove(vehiclesInInstance, i)				
-- 			end
-- 		end
-- 	end
	
-- 	NetworkConcealEntity(NetworkGetEntityFromNetworkId(vehicle), state)
-- end)

RegisterNetEvent("instance:setPedInstance")
AddEventHandler("instance:setPedInstance", function(ped, state)
	if state then
		table.insert(pedsInInstance, ped)
	else
		for i=#pedsInInstance, 1, -1 do
			if pedsInInstance[i] == ped then
				table.remove(pedsInInstance, i)				
			end
		end
	end

	NetworkConcealEntity(NetworkGetEntityFromNetworkId(ped), state)
end)

function concealAllPlayers()
	local PlayerId = PlayerId()

	local coords = GetEntityCoords(PlayerPedId())

	for _, player in ipairs(GetActivePlayers()) do
		local sID = GetPlayerServerId(player)
		mutedPlayers[sID] = true
		if player ~= PlayerId and not instancedPlayers[player] then
			NetworkConcealPlayer(player, true, 0)
			Base.Voice.setPlayerVolume(sID, 0.0)
	    else
			NetworkConcealPlayer(player, false, 0)
			Base.Voice.setPlayerVolume(GetPlayerServerId(player), -1.0)
	    end
	end
end

function revealAllPlayers()
	local PlayerId = PlayerId()
	for _, player in ipairs(GetActivePlayers()) do
		if player ~= PlayerId then
	    	NetworkConcealPlayer(player, false, 0)
	    end
	end
end

function convertServerIdListToPlayerList(players)
	local playerIds = {}

	for i=1, #players do
		table.insert(playerIds, GetPlayerFromServerId(players[i]))
    end

    return playerIds
end

function revealFromList(players)
	for _, player in ipairs(GetActivePlayers()) do
		for i=1, #players do
			if players[i] == player then
				NetworkConcealPlayer(player, false, 0)
				Base.Voice.setPlayerVolume(GetPlayerServerId(player), -1.0)
	    	end
	    end
	end
end

-- Peds
function cleanupPeds(peds)
	for i = #peds, 1, -1 do
		if (NetworkGetEntityFromNetworkId(peds[i]) == 0) then
			print("Cleaning Up Ped: " .. peds[i])
			table.remove(peds, i)
		end
	end
end

function revealPedsFromList(peds)
	for i, ped in ipairs(pedsInInstance) do
		if (ped ~= nil) then
			local netId = NetworkGetEntityFromNetworkId(ped)
			if (netId ~= 0) then
				local found = false
				for i=1, #peds do
					if (peds[i] == ped) then
						found = true
						NetworkConcealEntity(netId, false)
					end
				end

				if (not found) then
					NetworkConcealEntity(netId, true)
				end

			end
		end
	end
end

function revealAllPeds()
	for _, ped in ipairs(pedsInInstance) do
		NetworkConcealEntity(NetworkGetEntityFromNetworkId(ped), false)
	end
end

-- Vehicles
function revealVehiclesFromList(vehicles)
	for _, vehicle in ipairs(vehicles) do
		local found = false

		for i=1, #vehicles do
			if (vehicles[i] == vehicle) then
				found = true
				NetworkConcealEntity(NetworkGetEntityFromNetworkId(vehicle), false)
			end

			if (not found) then
				NetworkConcealEntity(NetworkGetEntityFromNetworkId(vehicle), true)
			end
		end

	end
end

function revealAllVehicles()
	for _, vehicle in ipairs(vehiclesInInstance) do
		NetworkConcealEntity(NetworkGetEntityFromNetworkId(vehicle), false)
	end
end

function toggleVehicleInstanceState(instance, state)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if (GetPedInVehicleSeat(veh, -1) == ped) then
		local seats = GetVehicleModelNumberOfSeats(GetEntityModel(veh))

		for i=0, seats do
			local tgt = GetPedInVehicleSeat(veh, i)
			if (tgt ~= 0 and tgt ~= ped) then
				if (state) then
					TriggerServerEvent("instance:enterInstance", instance, Base.Player.getSourceFromPed(ped))
				else
					TriggerServerEvent("instance:leaveInstance", instance, Base.Player.getSourceFromPed(ped))
				end
			end
		end

		local netId = NetworkGetNetworkIdFromEntity(veh)

		if state then
			TriggerServerEvent("instance:addVehicle", instance, netId)
		else
			TriggerServerEvent("instance:removeVehicle", instance, netId)
		end

	end

end

-- AddEventHandler("instance:toggleVehicleInstanceState", toggleVehicleInstanceState)

Citizen.CreateThread(function()
	while true do Wait(500)
		if isInstanced() then
			concealAllPlayers()
			revealFromList(convertServerIdListToPlayerList(instancedPlayers))

			--cleanupPeds(pedsInInstance)
			revealPedsFromList(pedsInYourInstance)
			-- revealVehiclesFromList(vehiclesInYourInstance)
		else
			revealAllPlayers()
		end
	end
end)