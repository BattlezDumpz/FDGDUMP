Base.Markers = {}

local inMarker = false
local markers = {}
local nearbymarkers = {}
local currentBlipIdentifier = nil
local currentBlipData = nil
local currentBlipMessage = nil

Base.Markers.Create = function(identifier, coords, colour, text, data, callback, inVehicle)
    if markers[identifier] then

    end

    if colour ~= "none" then
        markers[identifier] = {
            x = coords.x-0.001, y = coords.y-0.001, z = coords.z-0.001, 
            size = coords.size or 1.5,
            cr = (colour.r), cg = (colour.g), cb = (colour.b), 
            text = text,
            data = data,
            callback = callback,
            veh = inVehicle or false,
            marker = coords.marker or 27,
            bobbing = coords.bobbing or false,
            noLower = coords.noLower or false
        } 
    else
        markers[identifier] = {
            x = coords.x-0.001, y = coords.y-0.001, z = coords.z-0.001,
            size = coords.size or 1.5,
            text = text,
            data = data,
            callback = callback,
            veh = inVehicle or false,
        } 
    end

    --print("created marker: "..identifier)
end

AddEventHandler("fdg:CreateMarker", function(identifier, coords, colour, text, data, callback, inVehicle)
    markers[identifier] = {
        x = coords.x-0.001, y = coords.y-0.001, z = coords.z-0.001,
        size = coords.size or 1.5,
        cr = (colour.r or 0), cg = (colour.g or 255), cb = (colour.b or 0), 
        text = text,
        data = data,
        callback = callback,
        veh = inVehicle or false,
        marker = coords.marker or 27,
        bobbing = coords.bobbing or false,
        noLower = coords.noLower or false
    }
end)

Base.Markers.Delete = function(identifier)
    markers[identifier] = nil
end

AddEventHandler("fdg:DeleteMarker", function(identifier)
    markers[identifier] = nil
end)

Citizen.CreateThread(function()
    while true do
        Wait(500)

        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)
        local inVehicle = IsPedInAnyVehicle(playerPed, true)
        local closestDist = -1

        nearbymarkers = {}
        currentBlipIdentifier = nil
        currentBlipData = nil
        currentBlipMessage = nil

        for identifier, blip in pairs(markers) do
            local dist = GetDistanceBetweenCoords(coords,  blip.x,  blip.y,  blip.z - 0.98, true)
            local size = blip.size
            if (blip.size < 1.3) then size = 1.3 end

            if dist < 50 then
                if not blip.veh or ( blip.veh and inVehicle ) then
                    table.insert(nearbymarkers, blip)
                    if dist < closestDist or closestDist == -1 then
                        closestDist = dist
                        if dist < size then
                            inMarker = true
                            currentBlipMessage    = '[~g~G~s~] ' .. blip.text
                            currentBlipData       = blip
                            currentBlipIdentifier = identifier
                        elseif dist < size*3 then
                            currentBlipMessage = blip.text
                            currentBlipData    = blip
                        end
                    end
                end
            end
        end

        if inMarker and closestDist > 1.5 then
            Base.UI.Menu.CloseAll()
            inMarker = false
        end
    end
end)

-- Draw Blips 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if currentBlipIdentifier and currentBlipData then
            if IsControlJustPressed(0, 47) then
                if currentBlipData.callback then
                    Citizen.CreateThread(function() currentBlipData.callback(currentBlipData.data) end)
                end
            end
        end

        if currentBlipMessage and currentBlipData then
            Base.DrawText(currentBlipData.x, currentBlipData.y, currentBlipData.z, currentBlipMessage)
        end

        for i=1, #nearbymarkers, 1 do
            if nearbymarkers[i].cr then
                local z = nearbymarkers[i].z - 0.95
                if (nearbymarkers[i].noLower) then z = nearbymarkers[i].z end
                DrawMarker(nearbymarkers[i].marker or 27, nearbymarkers[i].x, nearbymarkers[i].y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, nearbymarkers[i].size, nearbymarkers[i].size, nearbymarkers[i].size, nearbymarkers[i].cr, nearbymarkers[i].cg, nearbymarkers[i].cb, 100, nearbymarkers[i].bobbing or false, (nearbymarkers[i].bobbing == false), 2, nearbymarkers[i].bobbing or false, false, false, false)
            end
        end
    end
end)