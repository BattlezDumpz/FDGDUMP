local isDead = false
local isCuffed = false

Base.Player = {}

Base.Player.getPlayersInRadius = function(coords, maxDist)
	local players = {}
	local playerCoords = GetEntityCoords(PlayerPedId())

	for i, player in pairs(GetActivePlayers()) do
		local dist = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, true)

		if dist < maxDist then
			table.insert(players, {
				source = GetPlayerServerId(player),
				ped = GetPlayerPed(player),
				dist = dist
			})
		end
	end

    return players
end

Base.Player.getClosestPlayer = function(coords, maxDist)
	local pped = GetPlayerPed(-1)
	local closestPlyr = -1
	local closestDist = maxDist	

	for i, player in ipairs(GetActivePlayers()) do
		if player ~= PlayerId() then
			local playerCoords = GetEntityCoords(GetPlayerPed(player))
			local dist = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, true)


			if dist < closestDist then
				closestPlyr = player
				closestDist = dist
			end
		end
	end

    return closestPlyr, closestDist
end

-- Called each frame to block actions listed in the function (does not prevent movement, except sprinting)
Base.Player.blockActions = function(toggle)
	Citizen.CreateThread(function()		
		DisableControlAction(2, 24, true)  -- Attack
		DisableControlAction(2, 257, true) -- Attack 2
		DisableControlAction(2, 25, true)  -- Aim
		DisableControlAction(2, 68, true)  -- Aim in car 2
		DisableControlAction(2, 91, true)  -- Aim in car 2
		DisableControlAction(2, 263, true) -- Melee Attack 1
		DisableControlAction(2, 45, true)  -- Reload ["R"] 
		DisableControlAction(2, 80, true)  -- Reload ["R"] 
		DisableControlAction(2, 140, true) -- Reload ["R"] 
		DisableControlAction(2, 250, true) -- Reload ["R"] 
		DisableControlAction(2, 263, true) -- Reload ["R"] 
		DisableControlAction(2, 310, true) -- Reload ["R"]
		DisableControlAction(2, 22, true)  -- Jump ['SPACE']
		DisableControlAction(2, 44, true)  -- Cover ["Q"] 
		DisableControlAction(2, 37, true)  -- Select Weapon ["TAB"]
		DisableControlAction(0, 23, true)  -- Also 'enter'?
		DisableControlAction(2, 288, true) -- Disable phone ["F1"]
		DisableControlAction(2, 289, true) -- Inventory ["F2"]
		DisableControlAction(2, 170, true) -- Animations ["F3"]
		DisableControlAction(2, 167, true) -- Disable F6 menu ["F6"]
		DisableControlAction(2, 323, true) -- Hands up while cuffed ["X"]
		DisableControlAction(2, 73, true)  -- Hands up while cuffed ["X"]
		DisableControlAction(2, 21, true)  -- Disables sprinting ["LEFTSHIFT"]
		DisableControlAction(2, 29, true)  -- Disables pointing ["B"]
		DisableControlAction(0,75,true)    -- disable exit vehicle
    	DisableControlAction(27,75,true)   -- disable exit vehicle
		if IsPedInAnyVehicle(ped) then
			DisableControlAction(0, 23, true) -- Also 'enter'?
		end
		if not allowSprint then
			DisableControlAction(2, 21, true) -- Disables sprinting ["LEFTSHIFT"]
		end
	end)
end

Base.Player.getSourceFromPed = function(ped)
	return GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
end

Base.Player.attachPlayerToEntity = function(ped, entity, bone, x, y, z, xr, yr, zr)
	TriggerServerEvent("fdg:AttachPlayerToEntity", Base.Player.getSourceFromPed(ped), NetworkGetNetworkIdFromEntity(entity), bone, x, y, z, xr, yr, zr)	
end

RegisterNetEvent("fdg:AttachPlayerToEntity")
AddEventHandler("fdg:AttachPlayerToEntity", function(entity, bone, x, y, z, xr, yr, zr)
	AttachEntityToEntity(GetPlayerPed(-1), NetworkGetEntityFromNetworkId(entity), bone, x, y, z, xr, xy, xz, false, false, false, false, 2, true)
end)

Base.Player.detachPlayer = function(ped)
	DetachEntity(GetPlayerPed(-1), true, false)
end