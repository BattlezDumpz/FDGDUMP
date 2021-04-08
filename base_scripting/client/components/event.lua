local _key = nil

RegisterNetEvent("Base:setKey") 
AddEventHandler("Base:setKey", function(key)
	_key = key()
end)

Base.Event = function(event, server, ...)
	if (server) then
		TriggerServerEvent("Base:event", _key, event, ...)
	else
		TriggerEvent("Base:event", _key, event, ...)
	end
end

Base.RegisterEvent = function(event, ...)

end