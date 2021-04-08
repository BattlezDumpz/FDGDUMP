-- Base.NPC = {}

-- Base.NPC.Static = {}

-- Base.NPC.Static.npcList = {}

-- local closeNPCs = {}
-- local controlsDisplayed = {}
-- local interactingNPC = false
-- local interactingEntity = false

-- local registeredControls = {}

-- Base.NPC.Static.registerControl = function(identifier, control, label, cb, displayCondition)
--     if not registeredControls[identifier] then registeredControls[identifier] = {} end

--     registeredControls[identifier][control.."_"..label] = {
--         identifier = identifier,
--         control = control,
--         label = label,
--         cb = cb,
--         displayCondition = displayCondition,
--     }
-- end

-- Citizen.CreateThread(function()
--     while true do Wait(100)
--         if interactingNPC then

--             -- If interacting with an NPC, loop through all registered controls!
--             for k, ctrl in pairs(registeredControls[interactingNPC.type] or {}) do

--                 -- Check the condition of the control (whether it should display)
--                 if (ctrl.displayCondition == nil or ctrl.displayCondition(interactingNPC, interactingEntity)) and GetEntityHealth(interactingEntity) > 0.0 then

--                     -- If the control isn't marked as already displaying
--                     if not controlsDisplayed[ctrl.identifier.."_"..ctrl.control] then

--                         -- Mark is as displaying
--                         controlsDisplayed[ctrl.identifier.."_"..ctrl.control] = {label = ctrl.label, control = ctrl.control}

--                         -- And display the control!
--                         Base.UI.setInstructionalButton(ctrl.label, ctrl.control, true, function()
--                             Citizen.CreateThread(function() ctrl.cb(interactingNPC, interactingEntity) end)
--                         end)
--                     end

--                 -- If the condition is false, and the control is visible, then hide the control
--                 elseif controlsDisplayed[ctrl.identifier.."_"..ctrl.control] then
--                     Base.UI.setInstructionalButton(ctrl.label, ctrl.control, false)
--                     controlsDisplayed[ctrl.identifier.."_"..ctrl.control] = nil
--                 end
--             end
--         else

--             -- If no NPC, clear all displayed controls!
--             for k, v in pairs(controlsDisplayed) do
--                 if v then
--                     Base.UI.setInstructionalButton(v.label, v.control, false)
--                     controlsDisplayed[k] = nil
--                 end
--             end
--         end
--     end
-- end)

-- Base.NPC.Static.requestPedSpawn = function(npc)
--     Base.TriggerServerCallback("scripting:checkStaticPedSpawn", function()
--         print("[scripting/npc] Spawning NPC "..npc.id)

--         RequestModel(GetHashKey(npc.hash))
--         while not HasModelLoaded(GetHashKey(npc.hash)) do Wait(1) end
--         local ped = CreatePed(4, GetHashKey(npc.hash), npc.x, npc.y, npc.z - 1.0, npc.r, 1, 1)

--         TaskSetBlockingOfNonTemporaryEvents(ped, true)
--         FreezeEntityPosition(ped, true)

--         if npc.skin then
--             exports["core_skin"]:ApplySkin(json.decode(npc.skin), false, ped)
--         end

--         Wait(100)

--         TriggerServerEvent("scriping:staticPedSpawned", npc.id, NetworkGetNetworkIdFromEntity(ped))
--     end, npc.id)
-- end

-- Base.Database.onClientData("npcs", GetCurrentResourceName(), function(npcList)
--     Base.NPC.Static.npcList = npcList
-- end)

-- Citizen.CreateThread(function()
--     while true do Wait(200)
--         local playerPed = PlayerPedId()
--         local coords = GetEntityCoords(playerPed)
--         closeNPCs = {}

--         for i, npc in ipairs(Base.NPC.Static.npcList) do
--             local dist = GetDistanceBetweenCoords(coords, npc.x, npc.y, npc.z, true)
--             if dist < 300.0 then
--                 if not npc.triedSpawning then
--                     print("[scripting/npc] Attempting to spawn NPC "..npc.id)
--                     npc.triedSpawning = true
--                     Base.NPC.Static.requestPedSpawn(npc)
--                 end

--                 if dist < 8.0 then
--                     table.insert(closeNPCs, npc)
--                 end

--             else

--                 if npc.triedSpawning then
--                     npc.triedSpawning = false
--                 end
--             end
--         end

--         local dist = 5.0
--         local camZoom = GetFollowPedCamZoomLevel()

--         if camZoom == 1 then
--             dist = 5.5
--         elseif camZoom == 2 then
--             dist = 6.25
--         end

--         entity = Target(dist, playerPed)
-- 		entityType = GetEntityType(entity)

-- 		-- If EntityType is Vehicle
-- 		Citizen.CreateThread(function()
--             if (entityType == 1) then
--                 local npc = getNPCFromPed(entity)

--                 if npc then
--                     interactingNPC = npc
--                     interactingEntity = entity
--                     exports["core_menu"]:Crosshair(true)
--                 end

--             elseif interactingNPC then
--                 interactingNPC = false
--                 interactingEntity = false
--                 exports["core_menu"]:Crosshair(false)
--             end
-- 		end)
--     end
-- end)

-- function getNPCFromPed(entity)
--     for i, npc in ipairs(closeNPCs) do
--         if GetDistanceBetweenCoords(GetEntityCoords(entity), npc.x, npc.y, npc.z, true) < 1.25 then
--             return npc
--         end
--     end
-- end