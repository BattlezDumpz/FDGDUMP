local SpawnedObjects = {}
local JobObjects = {}
local ClosestObject = nil
local ObjectsAmount = 0

Base.Objects = {}

Base.Objects.Create = function(model, x, y, z, heading, job, freeze, attached, noCollide)
    local objSettings = {model = model, coords = {x = x,  y = y, z = z}, heading = heading, job = job, freeze = freeze, attached = attached, noCollide = noCollide}
    
    if attached then
        if attached.target.."_obj_"..model then
            TriggerServerEvent("fdg_sync:Remove", "objectspawner", attached.target.."_obj_"..model)
            Wait(1000)
        end
        TriggerServerEvent("fdg_sync:Add", "objectspawner", attached.target.."_obj_"..model, objSettings)
    else
        ObjectsAmount = ObjectsAmount + 1
        TriggerServerEvent("fdg_sync:Add", "objectspawner", GetPlayerServerId(PlayerId()).."_obj_"..ObjectsAmount, objSettings)
    end
end

Base.Objects.Delete =  function(key)
    TriggerServerEvent("fdg_sync:Remove", "objectspawner", key)
end

RegisterNetEvent("fdg_objspawn:SpawnObj")
AddEventHandler("fdg_objspawn:SpawnObj", function(model, x, y, z, heading, job, freeze, attached)
    Base.Objects.Create(model, x, y, z, heading, job, freeze, attached)
end)

RegisterNetEvent("fdg_objspawn:DeleteObj")
AddEventHandler("fdg_objspawn:DeleteObj", function(key)
    Base.Objects.Delete(key)
end)

---------------------------------------------------------------------------
-- Create Objects --
---------------------------------------------------------------------------

local cachedObjects = {}

function SpawnObj(k,v)
    PlayerData = Base.GetPlayerData()

    if SpawnedObjects[k] then
        DeleteObject(SpawnedObjects[k])
    end

    local model = ""

    if type(v.model) == 'number' then
        model = v.model
    else
        model = GetHashKey(v.model)
    end

    local obj = CreateObject(model, v.coords.x, v.coords.y, v.coords.z, 0, 0, 1)
    SpawnedObjects[k] = obj

    if v.attached then
        local targetPlayer = GetPlayerFromServerId(v.attached.target)

        if not cachedObjects[v.attached.target] then cachedObjects[v.attached.target] = {} end
        cachedObjects[v.attached.target][k] = v

        if targetPlayer == -1 then 
            DeleteObject(obj)
            SpawnedObjects[k] = nil
            return
        end

        local playerPed = GetPlayerPed(-1)
        local target = GetPlayerPed(targetPlayer)
        local boneIndex = GetPedBoneIndex(target, v.attached.bone)
        FreezeEntityPosition(obj, false)
        AttachEntityToEntity(obj, target, boneIndex, v.attached.x, v.attached.y, v.attached.z, v.attached.xr, v.attached.yr, v.attached.zr, v.attached.p9, v.attached.useSoftPinning, v.attached.collision, v.attached.isPed, v.attached.vertexIndex, v.attached.fixedRot)
    else
        FreezeEntityPosition(obj, true)        
        SetEntityHeading(obj, v.heading)
        RequestCollisionAtCoord(v.coords.x, v.coords.y, v.coords.z)
        while not HasCollisionLoadedAroundEntity(obj) and SpawnedObjects[k] do
            Wait(100)
        end        
        PlaceObjectOnGroundProperly(obj)
        if not SpawnedObjects[k] then
            print("[Scripting] Object collisions loaded, but object was deleted! Removing locally")
            DeleteObject(obj)
        else
            print("[Scripting] Object placed successfully!")
        end    
    end

    SpawnedObjects[k] = obj

    if v.noCollide then
        SetEntityCollision(obj, false, true)
    end
    
    if PlayerData.job and PlayerData.job.name == v.job then
    
        if not JobObjects[PlayerData.job.name] then
            JobObjects[PlayerData.job.name] = {}
        end
        
        JobObjects[PlayerData.job.name][k] = obj
    end
end

RegisterNetEvent("fdg_sync:Sync")
AddEventHandler("fdg_sync:Sync", function(values)
    local resourcevalues = values["objectspawner"] or {}
    for k, v in pairs(resourcevalues) do
        SpawnObj(k,v)
    end
end)

RegisterNetEvent("fdg_sync:Add")
AddEventHandler("fdg_sync:Add", function(resourcename, key, value)
    if resourcename == "objectspawner" then
        SpawnObj(key,value)
    end
end)

---------------------------------------------------------------------------
-- Remove Objects --
---------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(50)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local closestDist = 0.0
        local closestObject = nil

        if PlayerData and PlayerData.job and JobObjects[PlayerData.job.name] then
            for key, object in pairs(JobObjects[PlayerData.job.name]) do
                local dist = GetDistanceBetweenCoords(coords, GetEntityCoords(object), true)

                if dist < closestDist or closestDist == 0.0 then
                    closestDist = dist
                    closestObject = key
                end
            end

            if closestDist < 2.0 and closestObject then
                ClosestObject = closestObject
            else
                ClosestObject = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if ClosestObject then
            if JobObjects[PlayerData.job.name] then
                local coords = GetEntityCoords(JobObjects[PlayerData.job.name][ClosestObject])
                DrawText3Ds(coords.x, coords.y, coords.z, "[~g~G~s~]  Pick up object")

                if IsControlJustPressed(1, 47) then
                    TriggerServerEvent("fdg_sync:Remove", "objectspawner", ClosestObject)
                end
            end
        end
    end
end)

RegisterNetEvent("fdg_sync:Remove")
AddEventHandler("fdg_sync:Remove", function(resourcename, key, source)
    if resourcename == "objectspawner" then
        if cachedObjects[source] then
            cachedObjects[source][key] = nil
        end

        ClosestObject = nil

        if SpawnedObjects[key] then
            DeleteObject(SpawnedObjects[key])
        end
    end
end)

RegisterNetEvent("onPlayerDropped")
AddEventHandler("onPlayerDropped", function(source, name, player)
    Wait(500)
    if cachedObjects[source] then
        for k, v in pairs(cachedObjects[source]) do
            if SpawnedObjects[k] then
                DeleteObject(SpawnedObjects[k])
            end
        end
    end
end)

RegisterNetEvent("onPlayerJoining")
AddEventHandler("onPlayerJoining", function(source, name, player)
    Wait(500)
    if cachedObjects[source] then
        for k, v in pairs(cachedObjects[source]) do
            SpawnObj(k,v)
        end
    end
end)

----------------------------------------------------------------------
-- Closest Objects --
----------------------------------------------------------------------
local ObjTypes = {}
local ObjStore = {}

Base.Objects.AddType = function(_type, obj_hashes)
    if (_type and obj_hashes) then
        ObjStore[_type] = {}
        for k,v in pairs(obj_hashes) do
            ObjTypes[v] = _type
        end
    end
end

Base.Objects.GetType = function(_type)
    if (ObjStore[_type]) then
        return ObjStore[_type]
    end
end

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local handle, object = FindFirstObject()

        for k,v in pairs(ObjStore) do ObjStore[k] = {} end

        repeat
            if (DoesEntityExist(object)) then
                local object_model = GetEntityModel(object)
                if (ObjTypes[object_model] ~= nil) then
                    local obj_pos = GetEntityCoords(object)
                    obj_pos = vector3(obj_pos.x, obj_pos.y, obj_pos.z + 1.0)
                    
                    local dist = #(pos - obj_pos)
                    ObjStore[ObjTypes[object_model]][object] = dist
                end
            end
            success, object = FindNextObject(handle, object)
        until not success

        EndFindObject(handle)

        for obj_name, _table in pairs(ObjStore) do
            for i, dist in pairs(_table) do
                if (tonumber(dist) > 50.0) then
                    ObjStore[obj_name][i] = nil
                end
            end
        end

        Wait(500)
    end
end)