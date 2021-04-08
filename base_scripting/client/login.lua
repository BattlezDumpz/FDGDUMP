-- Init Base Params
Base.PlayerData = {}
Base.PlayerLoaded = false

----------------------------------
-- VARIABLES FROM THE FRONT END --
----------------------------------
local spawn_point = nil
local sky_cam = nil
local last_location = {}

local sky_cams = {
    { x = 702.56,  y = 1205.49, z = 395.70, r = 148.67, d = 350.0 },
    { x = 789.40,  y =-2617.00, z = 90.60 , r = 28.67,  d = 350.0 },
    { x =-1691.8,  y =-1563.15, z = 164.40, r = 353.67, d = 350.0 },
    { x =-3351.92, y = 1524.89, z = 128.40, r = 196.17, d = 350.0 },
    { x = 1712.29, y = 3084.92, z = 164.40, r = 346.17, d = 350.0 },
    { x = 467.16,  y = 5597.43, z = 812.40, r = 51.17,  d = 320.0 },
    { x = 663.52,  y = 7025.93, z = 160.80, r = 73.67,  d = 350.0 },
    { x = 2376.44, y = 6226.74, z = 211.20, r = 188.67, d = 350.0 },
    { x = 2994.39, y = 2954.90, z = 200.40, r = 96.17,  d = 350.0 },
    { x = 1437.00, y = -441.05, z = 193.20, r = 108.67, d = 350.0 },
}

local spawn_points = {
    [1] = {x = -210.68, y = -1020.63, z = 30.14, r = 25.31, cam = -4.37},
    [2] = {x = -280.01, y = -1916.78, z = 29.95, r = 319.5, cam = -6.3 },
    [4] = {x = 1917.39, y = 3802.75,  z = 32.17, r = 152.5, cam = 3.8  },
    [5] = {x = -50.44,  y = 6348.4,   z = 31.30, r = 220.3, cam = -1.96},
}

local spawn_jobs = {
    ["police"] = {      
        [1] = {x = 1849.56, y = 3688.94, z = 33.30},
        [2] = {x = -447.36, y = 6009.4,  z = 30.82},
        [3] = {x = -1094.15, y = -830.02,  z = 14.28},
        [4] = {x = 455.99,  y = -991.11, z = 29.90},
        [5] = {x = -1623.16, y = -1033.54,  z = 13.14},
    },
    ["lses"] = {
        [1] = {x = 296.96,  y = -1446.56, z = 29.96, r = 320.45, cam = -0.52},    
        [2] = {x = 296.08,  y = -591.47, z = 43.37, r = 108.0, cam = -0.52},
        [3] = {x = 1808.98, y = 3677.14, z = 34.28, r = 84.50, cam = -2.09},
        [4] = {x = -493.04, y = -326.81, z = 34.50, r = 210.5, cam = -2.34},
        [5] = {x = -238.93, y = 6322.59, z = 32.42, r = 222.47, cam = -2.09},
    },
    ["gruppe6"] = {
        [1] = {x = 380.71, y = -1609.09, z = 29.29},
        [2] = {x = 0, y = 0, z = 71, r = 84.50, cam = -2.09},
        [3] = {x = 0, y = 0, z = 71, r = 84.50, cam = -2.09},
        [4] = {x = 0,  y = 0, z = 71, r = 108.0, cam = -0.52},
        [5] = {x = 1780.78,  y = 2547.86, z = 45.79},
    },
    ["bearcat"] = {
        [1] = {x = 0, y = 0, z = 71, r = 84.50, cam = -2.09},
        [2] = {x = 0,  y = 0, z = 71, r = 108.0, cam = -0.52},
        [3] = {x = 825.5, y = -1288.33, z = 28.24},
        [4] = {x = 0,  y = 0, z = 71, r = 108.0, cam = -0.52},
        [5] = {x = 0, y = 0, z = 71, r = 84.50, cam = -2.09},
    }
}

------------------------------
-- Handle player connection --
------------------------------

local awaitingSpawn = true
local _anticheat = nil
Citizen.CreateThread(function()

    repeat
        _anticheat = exports["core_admin"].getAntiCheat()
        Wait(10)
    until (json.encode(_anticheat) ~= "[]")
    _anticheat.start()

	while awaitingSpawn do
	    Citizen.Wait(50)
	    local playerPed = GetPlayerPed(-1)
	    if playerPed and playerPed ~= -1 then
            if NetworkIsPlayerActive(PlayerId()) then
                SwitchCharacter()
                awaitingSpawn = false
            end
	    end
	end
end)

RegisterNetEvent("fdg:swapCharacter") 
AddEventHandler("fdg:swapCharacter", function()
	SwitchCharacter()
end)

RegisterNetEvent("fdg:characterLoaded")
AddEventHandler('fdg:characterLoaded', function(data)
    Base.PlayerLoaded = true
    Base.PlayerData = data
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if (Base.PlayerData.accounts) then
        for i=1, #Base.PlayerData.accounts, 1 do
            if Base.PlayerData.accounts[i].name == account.name then
                Base.PlayerData.accounts[i] = account
            end
        end
    end

    if account.name == "money" then
        Base.PlayerData.money = account.money
    end
end)

RegisterNetEvent('esx:setICname')
AddEventHandler('esx:setICname', function(name)
  Base.PlayerData.icname = name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  Base.PlayerData.job = job
end)

RegisterNetEvent('esx:setSubJob')
AddEventHandler('esx:setSubJob', function(job)
    Base.PlayerData.subjob = job
end)

RegisterNetEvent("main_dispatch:SyncCallsign")
AddEventHandler("main_dispatch:SyncCallsign", function(callsign)
    PlayerData.callsign = callsign
end)

function SpawnCharacter(pos)
    SetPlayerControl(PlayerId(), true, 0)
    
    SetNuiFocus(false,false)
    if (pos == nil) then
        pos = {x = -542.57, y = -208.55, z = 37.65, r = 208.34, cam = 0.0}
    end

	SetCamActive(sky_cam, false)
	DestroyCam(sky_cam, false)
    RenderScriptCams(false, false, 500, true, true)
    SetTimecycleModifier('default')

    RequestCollisionAtCoord(pos.x, pos.y, pos.z)

    local ped = PlayerPedId()
    SetEntityCollision(ped, true)
    SetEntityVisible(ped, true, 0)
    SetPlayerInvincible(ped, false)
    SetEntityCoords(ped, pos.x, pos.y, pos.z - 0.9)
    SetEntityHeading(ped, pos.r)
    SetGameplayCamRelativeHeading(pos.cam)

    RemoveAllPedWeapons(ped, true)

    Wait(2000)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(500)
    Wait(150)

    StartScreenEffect("SwitchHUDMichaelOut", 1000, false)
    PlaySoundFrontend(-1, "QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET", 1)

    DisplayHud(true)
    Base.HUD.Toggle(true)
end

-- Handle the player when they first connect to the server
function SwitchCharacter()
    Base.PlayerLoaded = false

    local ran_cam = sky_cams[math.random(1, #sky_cams)]

    -- forces loading screen shutdown
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    -- DoScreenFadeOut(10)
    -- while not IsScreenFadedOut() do
    --     Citizen.Wait(10)
    -- end
    SetTimecycleModifier('hud_def_blur')

    local ped = PlayerPedId()
    SetEntityCoords(ped, ran_cam.x, ran_cam.y, 0.0, 0.0, 0.0, 0.0, false)
    FreezeEntityPosition(ped, true)
    SetEntityCollision(ped, false)
    SetEntityVisible(ped, false, 0)
    SetPlayerInvincible(ped, true)
    RemoveAllPedWeapons(ped, true)

    sky_cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", ran_cam.x, ran_cam.y, ran_cam.z, ran_cam.d, 0.0, ran_cam.r, 50.0, false, 0)

    SetCamActive(sky_cam, true)
    RenderScriptCams(true, false, 0, 1, 0)
    TriggerServerEvent("fdg:playerConnected")
    SetNuiFocus(false, false)
    Base.HUD.Toggle(false)
end

--------------------------------
-- Character Selection Screen --
--------------------------------
function SpawnDefaultPed(male)
    local _model

    if male then
        _model = GetHashKey('mp_m_freemode_01')
    else
        _model = GetHashKey('mp_f_freemode_01');
    end

    RequestModel(_model)
    while not HasModelLoaded(_model) do
        RequestModel(_model)
        Wait(0)
    end

    if IsModelInCdimage(_model) and IsModelValid(_model) then
        SetPlayerModel(PlayerId(), _model)
        SetPedDefaultComponentVariation(PlayerPedId())
    end

    SetModelAsNoLongerNeeded(_model)
end

RegisterNetEvent("scripting:openCharMenu")
AddEventHandler("scripting:openCharMenu", function(chars, maxCharacters)
    last_location = {}
	for k,v in pairs(chars) do

        if (v.position) then
     		last_location["spawn_"..v.charid] = json.decode(v.position)
        else
            last_location["spawn_"..v.charid] = {x = -542.57, y = -208.55, z = 37.65, r = 208.34, cam = 0.0}
        end
    end
    
    if (not IsScreenFadedIn()) then
        DoScreenFadeIn(1000)
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = chars,
        maxCharacters = maxCharacters,
    })

    while (not Base.PlayerLoaded) do Wait(500)
        local pid = PlayerId()
        SetNuiFocus(true, true)
    	DisplayHud(false)
        DisplayRadar(false)        
        for i, p in pairs(GetActivePlayers()) do if p ~= pid then NetworkConcealPlayer(p, true, 0) end end
    end

    SetNuiFocus(false, false)
    for i, p in pairs(GetActivePlayers()) do if p ~= pid then NetworkConcealPlayer(p, false, 0) end end
end)

RegisterNUICallback("CreateCharacter", function(data, cb)
    spawn_point = nil

    TriggerServerEvent('fdg:createCharacter', data) 

    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(50) end

    -- Destory the sky cam
    SetCamActive(sky_cam, false)
    DestroyCam(sky_cam, false)
    RenderScriptCams(false, false, 500, true, true)

    -- Reset the camera affect (remove the blur)
    SetTimecycleModifier('default')

    -- Fade out the screen and wait until the character is selected
    DoScreenFadeIn(1000)
    while not IsScreenFadedIn() do Wait(0) end
end)

RegisterNUICallback("LoadCharacter", function(data)
    print("[BASE] Character Selected: "..data.charId)
    local spawn = tonumber(data.spawn)
    if (data.job == "dead" ) then
        spawn_point = spawn_jobs["lses"][2]
    else
        if (data.job == "police" or data.job == "lses" or data.job == "gruppe6" or  data.job == "bearcat") then
            spawn_point = spawn_jobs[data.job][spawn]
        else 
            if (spawn == 3) then
                spawn_point = last_location["spawn_"..data.charId]
                spawn_point.r = 0.0
                spawn_point.cam = 0.0
            else
                spawn_point = spawn_points[spawn]
            end
        end
    end 

    TriggerServerEvent('fdg:selectCharacter', data.charId)

    local loc_int = GetInteriorAtCoords(spawn_point.x, spawn_point.y, spawn_point.z)
    if (loc_int ~= 0) then
        LoadInterior(loc_int)
    end

    DoScreenFadeOut(1000)
    while (not IsScreenFadedOut()) do
        Wait(5)
    end

    SpawnCharacter(spawn_point)
end)

RegisterNUICallback("DeleteCharacter", function(data, cb)
	TriggerServerEvent('fdg:deleteCharacter', data.charId)
    cb("ok")
end)