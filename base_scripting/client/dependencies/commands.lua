RegisterNetEvent('giveCoords')
AddEventHandler('giveCoords', function()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	TriggerEvent('chatMessage', "", {255, 0, 0}, "X: "..coords.x.." | Y: "..coords.y.." | Z: "..coords.z .. " | Dir: " .. GetEntityHeading(GetPlayerPed()))
end)

RegisterNetEvent('giveCoordsDB')
AddEventHandler('giveCoordsDB', function(label)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	TriggerEvent('chatMessage', "", {255, 255, 255}, "X: "..coords.x.." | Y: "..coords.y.." | Z: "..coords.z .. " | Dir: " .. GetEntityHeading(GetPlayerPed()) .. " | Label: " .. label)
	TriggerServerEvent('commands:logCoords', coords.x, coords.y, coords.z, GetEntityHeading(GetPlayerPed()), label)	
end)

RegisterNetEvent('command:sendStaffOOCMessage')
AddEventHandler('command:sendStaffOOCMessage', function(msg)
	TriggerServerEvent('command:sendStaffOOCMessage', msg)
end)

----- /SC CLIENT EVENT -----

AddEventHandler("properload", function()
	-- Let the server know that we just joined.
	-- Requests the server configs
	TriggerServerEvent( "properload")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerEvent('properload')
			return
		end
	end
end )

---- RANDOM FUNCTIONS ---------------

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(x,y,z)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], x, y, z, true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

-- AOP Sync
Citizen.CreateThread(function()
	Citizen.Wait(10000)
	TriggerServerEvent("commands:updateAOP")
end)

weapons = {
    { weaponname = "Pistol", hash = 453432689 },
    { weaponname = "Combat Pistol", hash = 1593441988 },
    { weaponname = "AP Pistol", hash = 584646201 },
    { weaponname = "Micro SMG", hash = 324215364 },
    { weaponname = "SMG", hash = 736523883 },
    { weaponname = "Assault SMG", hash = 4024951519 },
    { weaponname = "Heavy Pistol", hash = 3523564046 },
    { weaponname = "SNS Pistol", hash = 3218215474 },
    { weaponname = "Vintage Pistol", hash = 137902532 },
    { weaponname = "Combat PDW", hash = 171789620 },
    { weaponname = "Machine Pistol", hash = 3675956304 },
    { weaponname = "Revolver", hash = 3249783761 },
    { weaponname = "Mini SMG", hash = 3173288789 },
    { weaponname = "Marksman Pistol", hash = 3696079510 },
    { weaponname = ".50 Pistol", hash = 2578377531 },
    { weaponname = "Assault Rifle", hash = 3220176749 },
    { weaponname = "Carbine Rifle", hash = 2210333304 },
    { weaponname = "Advanced Rifle", hash = 2937143193 },
    { weaponname = "MG", hash = 2634544996 },
    { weaponname = "Combat MG", hash = 2144741730 },
    { weaponname = "Gusenberg", hash = 1627465347 },
    { weaponname = "Special Carbine", hash = 3231910285 },
    { weaponname = "Bullpup Rifle", hash = 2132975508 },
    { weaponname = "Compact Rifle", hash = 1649403952 },
    { weaponname = "Sniper Rifle", hash = 100416529 },
    { weaponname = "Marksman Rifle", hash = 3342088282 },
    { weaponname = "Heavy Sniper", hash = 205991906 },
    { weaponname = "Pump Shotgun", hash = 487013001 },
    { weaponname = "Sawn Off Shotgun", hash = 2017895192 },
    { weaponname = "Assault Shotgun", hash = 3800352039 },
    { weaponname = "Heavy Shotgun", hash = 984333226 },
    { weaponname = "D/B Shotgun", hash = 4019527611 },
    { weaponname = "Auto Shotgun", hash = 317205821 },
    { weaponname = "Knife", hash = 2578778090 },
    { weaponname = "Nightstick", hash = 1737195953 },
    { weaponname = "Hammer", hash = 1317494643 },
    { weaponname = "Bat", hash = 2508868239 },
    { weaponname = "Golfclub", hash = 1141786504 },
    { weaponname = "Crowbar", hash = 2227010557 },
    { weaponname = "Bottle", hash = 4192643659 },
    { weaponname = "Dagger", hash = 2460120199 },
    { weaponname = "Knuckle", hash = 3638508604 },
    { weaponname = "Hatchet", hash = 4191993645 },
    { weaponname = "Machete", hash = 3713923289 },
    { weaponname = "Switch Blade", hash = 3756226112 },
    { weaponname = "Battle Axe", hash = 3441901897 },
    { weaponname = "Pipebomb", hash = 3125143736 },
    { weaponname = "Wrench", hash = 419712736 },
    { weaponname = "Pool cue", hash = 2484171525 },
    { weaponname = "Grenade", hash = 2481070269 },
    { weaponname = "Sticky Bomb", hash = 741814745 },
    { weaponname = "Explosion", hash = 539292904 },
    { weaponname = "Non-lethal Shotgun", hash = 2640438543 },
    { weaponname = "Tazer", hash = 911657153 },
    { weaponname = "Animal", hash = 4194021054 },
    { weaponname = "Cougar", hash = 148160082 },
    { weaponname = "BZ Gas", hash = 2694266206 },
    { weaponname = "Smoke Grenade", hash = 4256991824 },
    { weaponname = "Molotov", hash = 615608432 },
    { weaponname = "Petrol Can", hash = 883325847 },
    { weaponname = "Flare", hash = 1233104067 },
    { weaponname = "Fire", hash = 3750660587 },
    { weaponname = "Flaregun", hash = 1198879012 },
    { weaponname = "Fire Extinguisher", hash = 101631238 },
    { weaponname = "Digiscanner",   hash = 4256881901 },
    { weaponname = "Briefcase", hash = 2294779575 },
    { weaponname = "Briefcase", hash = 28811031 },
    { weaponname = "Ball", hash = 600439132 },
    { weaponname = "Fireworks", hash = 2138347493 },
    { weaponname = "Snowball", hash = 126349499 },
    { weaponname = "Garbage Bag", hash = 3794977420 },
    { weaponname = "Hand Cuffs", hash = 3494679629 },
    { weaponname = "Drowned", hash = 4284007675 },
    { weaponname = "Bleeding", hash = 2339582971 },
    { weaponname = "Electric Fence", hash = 2461879995 },
    { weaponname = "Barbed Wire", hash = 1223143800 },
    { weaponname = "Fall", hash = 3452007600 },
    { weaponname = "Exhaustion", hash = 910830060 },
    { weaponname = "Bare Fists", hash = 2725352035 },
    { weaponname = "Drowned in vehicle", hash = 1936677264 },
    { weaponname = "Hit by Water Cannon", hash = 3425972830 },
    { weaponname = "Rammed by Car", hash = 133987706 },
    { weaponname = "Run over by Car", hash = 2741846334 },
    { weaponname = "Heli Crash", hash = 341774354 },
    { weaponname = "Remote Sniper", hash = 856002082 },
    { weaponname = "Grenade Launcher", hash = 2726580491 },
    { weaponname = "Grenade Launcher (Smoke)", hash = 1305664598 },
    { weaponname = "RPG", hash = 2982836145 },
    { weaponname = "Passenger Rocket", hash = 375527679 },
    { weaponname = "Air Strike Rocket", hash = 324506233 },
    { weaponname = "Stinger", hash = 1752584910 },
    { weaponname = "Minigun", hash = 1119849093 },
    { weaponname = "Vehicle Rocket", hash = 3204302209 },
    { weaponname = "Musket", hash = 2828843422 },
    { weaponname = "Homing Launcher", hash = 1672152130 },
    { weaponname = "Proxmine", hash = 2874559379 },
    { weaponname = "Railgun", hash = 1834241177 },
    { weaponname = "Air Defense Gun", hash = 738733437 },
    { weaponname = "Compact Launcher", hash = 125959754 },
}

function GetPlayerByEntityID(id)
    for i=0,255 do
        if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
    end
    return nil
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
