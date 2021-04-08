local standardVolumeOutput = 1.0;

Base.Sound = {}
Base.Sound.soundId = 0
Base.Sound.sounds = {}


Base.Sound.PlaySound = function(soundFile, soundVolume)
    Base.Sound.soundId = Base.Sound.soundId + 1

    local sound = {
        soundID = Base.Sound.soundId,
        soundUrl = soundFile,
        playAudio = true
    }

    SendNUIMessage({soundID = sound.soundID, soundUrl = sound.soundUrl, playAudio = sound.playAudio})

    Base.Sound.sounds[Base.Sound.soundId] = sound
end

Base.Sound.PlayGlobal = function(soundFile, soundVolume)
    TriggerServerEvent("InteractSound_SV:PlayOnAll", soundFile, soundVolume)
end

Base.Sound.PlayOnCoords = function(coords, maxDistance, soundFile, soundVolume)
    TriggerServerEvent("InteractSound_SV:PlayOnCoords", coords, maxDistance, soundFile, soundVolume)
end

Base.Sound.PlayOnEntity = function(playOnEntity, maxDistance, soundFile, soundVolume)
    local sourceCoords = GetEntityCoords(playOnEntity)
    TriggerServerEvent("InteractSound_SV:PlayOnCoords", sourceCoords, maxDistance, soundFile, soundVolume)
end

RegisterNetEvent('InteractSound_CL:PlayOnOne')
AddEventHandler('InteractSound_CL:PlayOnOne', function(soundFile, soundVolume)
    Base.Sound.PlaySound(soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_CL:PlayOnAll')
AddEventHandler('InteractSound_CL:PlayOnAll', function(soundFile, soundVolume)
    TriggerServerEvent("InteractSound_SV:PlayOnAll", soundFile, soundVolume)
end)

RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playOnEntity, maxDistance, soundFile, soundVolume)
    local player = GetPlayerFromServerId(playOnEntity)
    if player ~= -1 then
        local sourceEntity = GetPlayerPed(player)
        local sourceCoords = GetEntityCoords(sourceEntity)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local distIs  = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sourceCoords.x, sourceCoords.y, sourceCoords.z, true)
        if(distIs <= maxDistance) then
            Base.Sound.PlaySound(soundFile, soundVolume)
        end
    end
end)

RegisterNetEvent("scripting:playOnCoords")
AddEventHandler("scripting:playOnCoords", function(sourceCoords, maxDist, soundFile)
    Base.Sound.soundId = Base.Sound.soundId + 1

    local sound = {
        soundID = Base.Sound.soundId,
        soundUrl = soundFile,
        playAudio = #(GetEntityCoords(PlayerPedId()) - sourceCoords) < maxDist,
        coords = sourceCoords,
        maxDist = maxDist
    }

    SendNUIMessage({soundID = sound.soundID, soundUrl = sound.soundUrl, playAudio = sound.playAudio})

    Base.Sound.sounds[Base.Sound.soundId] = sound
end)

-- Citizen.CreateThread(function()
--     while true do Wait(500)
--         local playerPed = PlayerPedId()
--         local playerCoords = GetEntityCoords(playerPed)

--         handleSoundDistance(playerCoords)
--     end
-- end)

function handleSoundDistance(coords)
    for id, sound in pairs(Base.Sound.sounds) do
        if (sound.coords) then
            if #(coords - sound.coords) < sound.maxDist and not sound.playAudio then
                -- SendNUIMessage({soundID = id, playAudio = true})
                -- sound.playAudio = true
            elseif #(coords - sound.coords) > sound.maxDist and sound.playAudio then
                -- SendNUIMessage({soundID = id, playAudio = false})
                -- sound.playAudio = false
            end

        elseif (sound.entity) then
            if #(coords - GetEntityCoords(sound.entity)) < sound.maxDist then
                -- SendNUIMessage({soundID = id, playAudio = true})
            else
                -- SendNUIMessage({soundID = id, playAudio = false})
            end

        end
    end
end

RegisterNUICallback("soundFinished", function(soundID)
    --Base.Sound.sounds[soundID] = nil
end)