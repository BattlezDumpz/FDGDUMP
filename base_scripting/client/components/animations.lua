Base.Animation = {}

Base.Animation.StartTimedAnimation = function()

end

-- Calculate the flag given the 3 parameters determined by the flag
Base.Animation.GetFlag = function(repeating, frozen, upperBodyOnly)
	if upperBodyOnly then
		if repeating and frozen then
			return 17
		elseif repeating and not frozen then
			return 49
		elseif not repeating and not frozen then
			return 48
		end
	else
		if repeating and frozen then 
			return 3
		elseif repeating and not frozen then
			return 34
		end
	end

	-- If settings are not applicable, return default flag
	return 0
end

-- Load Animation Library
Base.Animation.LoadDict = function(dict)
	RequestAnimDict(dict)
	local timeout = 1000
	while not HasAnimDictLoaded(dict) and timeout > 0 do
        Citizen.Wait(10)
    end    
    return HasAnimDictLoaded(dict)
end

Base.Animation.Clipset = nil
Base.Animation.InForcedClipset = false
Base.Animation.SetClipset = function(ped, clipset, save, forced)
	if not Base.Animation.InForcedClipset or clipset == "move_ped_crouched" then
		
		while ( not HasAnimSetLoaded(clipset) ) do
			RequestAnimSet(clipset)
			Wait(10)
		end

		SetPedMovementClipset(ped, clipset, 1.0)
		Base.Animation.InForcedClipset = forced

		if save then
			Base.Animation.Clipset = clipset
		end

	end
end

Base.Animation.ResetClipset = function(ped, reset, forced)
	if Base.Animation.InForcedClipset then
		if forced then
			Base.Animation.InForcedClipset = false
			if Base.Animation.Clipset then
				SetPedMovementClipset(ped, Base.Animation.Clipset, 1.0)
			else
				ResetPedMovementClipset(ped, 0.0)
			end
		end
	else
		if Base.Animation.Clipset and not reset then
			SetPedMovementClipset(ped, Base.Animation.Clipset, 1.0)
		else
			Base.Animation.Clipset = nil
			ResetPedMovementClipset(ped, 0.0)
		end
	end
end

Base.Animation.GetClipset = function()
	return Base.Animation.Clipset
end

-- Start a normal animation
Base.Animation.Start = function(ped, lib, anim, repeating, frozen, upperBodyOnly, animTime, customFlag)
	if ped ~= GetPlayerPed(-1) and IsPedAPlayer(ped) then
		TriggerServerEvent("fdg:StartAnim", GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped)), lib, anim, repeating, frozen, upperBodyOnly, animTime)
		return
	end

	if animTime == nil then
		animTime = -8.0
	end

	if not Base.Animation.IsInForcedAnim then
		if lib ~= "clipset" then
			-- Calculate the appropriate flag
			local flag = customFlag or Base.Animation.GetFlag(repeating, frozen, upperBodyOnly)
			--print("[FDG:Animations] Generated Flag: "..flag)

			-- Load the animation
			if lib ~= "scenario" then
				if not Base.Animation.LoadDict(lib) then
					--print("[FDG:Animations] Invalid Anim Lib")
					return
				end
			end

		    if lib ~= "scenario" then
				TaskPlayAnim(ped, lib, anim, math.abs(animTime), animTime, -1, flag, 0, 0, 0, 0)
		    else
		    	TaskStartScenarioInPlace(ped, anim, 0, -1)
		    end
		else
			-- clipsets use animation sets
			while ( not HasAnimSetLoaded(anim) ) do
				RequestAnimSet(anim)
				Wait(10)
			end
			SetPedMovementClipset(ped, anim, 1.0)
		end
	end
end

-- Stop the execution of a 
Base.Animation.Stop = function(ped, dict, anim)

	-- If the specified ped is another player
	if ped ~= GetPlayerPed(-1) and IsPedAPlayer(ped) then
		TriggerServerEvent("fdg:StopAnim", Base.Player.getSourceFromPed(ped))
		return
	end

	if not Base.Animation.IsInForcedAnim then
		if (dict and anim) then
			StopAnimTask(ped, dict, anim, -4.0)
		else
			StopAnimPlayback(ped, 0, 0)
			ClearPedSecondaryTask(ped)
			if IsPedUsingAnyScenario(ped) then
				ClearPedTasks(ped)
			end
		end
	end
end

-- Forced Animation (Will overide all other animations)
-- If repeating is true, the animation will play until Base.Animation.StopForcedAnim() is called
Base.Animation.IsInForcedAnim = false
Base.Animation.StartForcedAnim = function(ped, lib, anim, repeating, frozen, upperBodyOnly, allowSprint)
	-- If the specified ped is another player
	if ped ~= GetPlayerPed(-1) and IsPedAPlayer(ped) then
		TriggerServerEvent("fdg:StartForcedAnim", Base.Player.getSourceFromPed(ped), lib, anim, repeating, frozen, upperBodyOnly)
		return
	end

	-- Cancel existing animations
	if Base.Animation.IsInForcedAnim then
		Base.Animation.StopForcedAnim()
	end

	-- Calculate the appropriate flag
	local flag = Base.Animation.GetFlag(repeating, frozen, upperBodyOnly)
	--print("[FDG:Animations] Generated Flag: "..flag)

	-- Load the animation
	if lib ~= "scenario" then
		if not Base.Animation.LoadDict(lib) then
			--print("[FDG:Animations] Invalid Anim Lib")
			return
		end
	end

	-- Clear existing tasks (this anim is priority)
	ClearPedTasks(ped)
    ClearPedSecondaryTask(ped)

    -- Play the anim
    Base.Animation.IsInForcedAnim = true

    if lib ~= "scenario" then
    	TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
    else
    	TaskStartScenarioInPlace(ped, anim, 0, true)
    end

    Base.Decors.set("PlayerSurrendered", false, 3)

    -- Detection Loop
	Citizen.CreateThread(function()
		while Base.Animation.IsInForcedAnim do
			Wait(1)
			ped = GetPlayerPed(-1)
			Base.Player.blockActions(allowSprint)

			-- Check if the ped is still playing the anim
			if ((lib ~= "scenario" and not IsEntityPlayingAnim(ped, lib, anim, 3)) or (lib == "scenario" and not IsPedUsingScenario(ped, anim))) and not IsPedFalling(ped) and not (IsPedCuffed(ped) and IsPedRagdoll(ped)) then
				if repeating then
					-- If anim is repeating restart the anim
					ClearPedTasksImmediately(ped)
	      			ClearPedSecondaryTask(ped)
	      			if lib ~= "scenario" then
	      				TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
	      			else
	      				TaskStartScenarioInPlace(ped, anim, 0, true)
	      			end
					--print("[FDG:Animations] Restarting anim")
				else
					-- If it isn't repeated, report anim is over
					Base.Animation.IsInForcedAnim = false
					break
				end
			end
		end
	end)
end

-- Stop the execution of a 
Base.Animation.StopForcedAnim = function(ped)

	-- If the specified ped is another player
	if ped ~= GetPlayerPed(-1) and IsPedAPlayer(ped) then
		TriggerServerEvent("fdg:StopForcedAnim", Base.Player.getSourceFromPed(ped), lib)
		return
	end

	Base.Animation.IsInForcedAnim = false
	Wait(100)
	StopAnimPlayback(ped, 0, 0)
	ClearPedSecondaryTask(ped)
	if IsPedUsingAnyScenario(ped) then
		ClearPedTasks(ped)
	end
end

Base.Animation.ActionAnimation = function(lib, anim, repeating, frozen, upperBodyOnly, time, onComplete, onCancel)
	
	if Base.Animation.IsInForcedAnim then
		TriggerEvent("fdg_ui:SendNotification", "You are already doing a task")
		return
	end

	local ped = GetPlayerPed(-1)

	Base.Animation.StartForcedAnim(ped, lib, anim, repeating, frozen, upperBodyOnly, true)

	local inTask = true
	local cancelled = false

	Citizen.CreateThread(function()
		while time > 0 and not cancelled do
			Wait(1000)
			time = time - 1
		end

		inTask = false

		-- This is in a citizen thread incase the callback fails.
		Citizen.CreateThread(function()
			if not cancelled then
				-- Task Cancelled
				if onComplete then
					onComplete()
				end
			else
				-- Task Completed
				if onCancel then
					onCancel()
				end
			end
		end)

		Base.Animation.StopForcedAnim(GetPlayerPed(-1))
	end)

	Citizen.CreateThread(function()
		while inTask and not cancelled do
			Wait(1)
			if (IsControlPressed(1, 73) or IsDisabledControlPressed(1, 73)) and GetLastInputMethod(2) then
				cancelled = true
			end
		end
	end)
end

RegisterNetEvent("fdg:ActionAnimation")
AddEventHandler("fdg:ActionAnimation", function(actionId, lib, anim, repeating, frozen, upperBodyOnly, time)
	Base.Animation.ActionAnimation(lib, anim, repeating, frozen, upperBodyOnly, time, 
		function()
			TriggerServerEvent("fdg:ActionAnimation", actionId, true)
		end, 
		function()
			TriggerServerEvent("fdg:ActionAnimation", actionId, false)
		end
	)
end)

Base.Animation.InForcedAnim = function()
	return Base.Animation.IsInForcedAnim
end

-- Citizen.CreateThread(function()
-- 	Base.Animation.StartForcedAnim("combat@drag_ped@", "injured_drag_plyr", false, false, false)
-- 	Wait(10000)
-- 	Base.Animation.StopForcedAnim()
-- end)

RegisterNetEvent("fdg:StartForcedAnim")
AddEventHandler("fdg:StartForcedAnim", function(lib, anim, repeating, frozen, upperBodyOnly)
	Base.Animation.StartForcedAnim(GetPlayerPed(-1), lib, anim, repeating, frozen, upperBodyOnly)
end)

RegisterNetEvent("fdg:StopForcedAnim")
AddEventHandler("fdg:StopForcedAnim", function()
	Base.Animation.StopForcedAnim(GetPlayerPed(-1))
end)

RegisterNetEvent("fdg:StartAnim")
AddEventHandler("fdg:StartAnim", function(lib, anim, repeating, frozen, upperBodyOnly)
	Base.Animation.Start(GetPlayerPed(-1), lib, anim, repeating, frozen, upperBodyOnly)
end)

RegisterNetEvent("fdg:StopAnim")
AddEventHandler("fdg:StopAnim", function()
	Base.Animation.Stop(GetPlayerPed(-1))
end)