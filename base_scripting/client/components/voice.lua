-- local showRangeCircle   = true
-- local showChatMessage   = false
-- local showNotification  = true
-- local circleDisplayTime = 450
-- local voiceSettings = {
-- 	Whisper = 3.5,
-- 	Normal  = 6.0,
-- 	Shout   = 12.5,
-- 	Megaphone = 35.0,
-- 	Phone = 0.0,
-- }

-- -- Do not edit below this line
-- local voiceRange = 6.0
-- local showCircle = true
-- local megaphone  = false

-- Citizen.CreateThread(function()
-- 	NetworkSetTalkerProximity(voiceRange)

-- 	while true do
-- 		Wait(0)
-- 		if IsControlJustPressed(0, 243) then
-- 			if voiceRange == voiceSettings["Whisper"] then
-- 				setTalkerDistance("Normal")
-- 				TriggerEvent("setRange", 1)
-- 			elseif voiceRange == voiceSettings["Normal"] then
-- 				setTalkerDistance("Shout")
-- 				TriggerEvent("setRange", 2)
-- 			elseif voiceRange == voiceSettings["Shout"] then
-- 				setTalkerDistance("Whisper")
-- 				TriggerEvent("setRange", 3)
-- 			end
-- 		end
-- 	end
-- end)

-- function setTalkerDistance(range)
-- 	-- Preset voice ranges
-- 	if voiceSettings[range] then
-- 		alertVoiceRangeChange(range, voiceSettings[range])
-- 		NetworkSetTalkerProximity(voiceSettings[range])
-- 		voiceRange = voiceSettings[range]
-- 	else
-- 		alertVoiceRangeChange("Custom", range)
-- 		NetworkSetTalkerProximity(range)
-- 		voiceRange = range
-- 	end
-- end

-- function setTempTalkerDistance(range)
-- 	if voiceSettings[range] then
-- 		alertVoiceRangeChange(range, voiceSettings[range])
-- 		NetworkSetTalkerProximity(voiceSettings[range])
-- 	else
-- 		alertVoiceRangeChange("Custom", range)
-- 		NetworkSetTalkerProximity(range)
-- 	end
-- end

-- function resetTalkerDistance()
-- 	NetworkSetTalkerProximity(voiceRange)
-- end

-- function alertVoiceRangeChange(label, distance)
-- 	local diameter = distance * 2

-- 	if showChatMessage then
-- 		TriggerEvent("chatMessage", "Voice Range", {0,124,35},  "Voice range set to "..label)
-- 	end

-- 	if showRangeCircle then
-- 		showCircle = true
-- 		local playerPed  = PlayerPedId()

-- 		Citizen.CreateThread(function()
-- 			Wait(circleDisplayTime)
-- 			showCircle = false
-- 		end)

-- 		Citizen.CreateThread(function()
-- 			while showCircle do
-- 				Wait(0)
-- 				local coords = GetEntityCoords(playerPed)
-- 				DrawMarker(1, coords.x, coords.y, coords.z-0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, diameter, diameter, 0.25, 0, 124, 35, 50, false, false, 2, true, false, false, false)
-- 			end
-- 		end)
-- 	end

-- 	if showNotification then
-- 		TriggerEvent("fdg_ui:SendNotification", "Voice range set to "..label, {layout = "topRight", timeout = 500})
-- 	end
-- end

-- RegisterCommand("megaphone", function()
-- end)