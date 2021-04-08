------------------------------
-- Server Callbacks --
------------------------------

Base.CurrentRequestId = 0
Base.ServerCallbacks = {}

Base.TriggerServerCallback = function(name, cb, ...)
	Base.ServerCallbacks[Base.CurrentRequestId] = cb

	TriggerServerEvent('esx:triggerServerCallback', name, Base.CurrentRequestId, ...)

	if Base.CurrentRequestId < 65535 then
		Base.CurrentRequestId = Base.CurrentRequestId + 1
	else
		Base.CurrentRequestId = 0
	end
end

Base.TriggerLatentServerCallback = function(name, cb, ...)
	Base.ServerCallbacks[Base.CurrentRequestId] = cb

	TriggerServerEvent('esx:triggerLatentServerCallback', name, Base.CurrentRequestId, ...)

	if Base.CurrentRequestId < 65535 then
		Base.CurrentRequestId = Base.CurrentRequestId + 1
	else
		Base.CurrentRequestId = 0
	end
end

RegisterNetEvent('esx:serverCallback')
AddEventHandler('esx:serverCallback', function(requestId, ...)
	Base.ServerCallbacks[requestId](...)
	Base.ServerCallbacks[requestId] = nil
end)

------------------------------
-- Timeout Callbacks --
------------------------------

Base.TimeoutCallbacks = {}

Base.SetTimeout = function(msec, cb)
	table.insert(Base.TimeoutCallbacks, {
		time = GetGameTimer() + msec,
		cb   = cb
	})
	return #Base.TimeoutCallbacks
end

Base.ClearTimeout = function(i)
	Base.TimeoutCallbacks[i] = nil
end

Citizen.CreateThread(function()
	while true do Citizen.Wait(0)

		local currTime = GetGameTimer()

		for i=1, #Base.TimeoutCallbacks, 1 do
			if Base.TimeoutCallbacks[i] ~= nil and currTime >= Base.TimeoutCallbacks[i].time then
				Base.TimeoutCallbacks[i].cb()
				Base.TimeoutCallbacks[i] = nil
			end
		end
	end
end)

------------------------------
-- Client Callbacks --
------------------------------

Base.CurrentClientRequestId = 0
Base.ClientCallbacks = {}

Base.RegisterClientCallback = function(name, cb, ...)
	Base.ClientCallbacks[name] = cb
end

Base.TriggerClientCallback = function(name, cb, ...)
    if Base.ClientCallbacks[name] ~= nil then
        Base.ClientCallbacks[name](cb, ...)
    else
        print('TriggeClientCallback => [' .. name .. '] does not exist')
    end
end

RegisterNetEvent('scripting:triggerClientCallback')
AddEventHandler('scripting:triggerClientCallback', function(name, requestId, ...)
	Base.TriggerClientCallback(name, function(...)
		TriggerServerEvent('scripting:clientCallback', requestId, ...)
	end, ...)
end)