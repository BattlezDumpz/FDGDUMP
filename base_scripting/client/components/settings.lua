AccountSettings = nil

function UpdateSettings()
	TriggerServerEvent("base_scripting:UpdatePlayerSettings", AccountSettings)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	Base.TriggerServerCallback("base_scripting:GetPlayerSettings", function(_settings)
		AccountSettings = _settings
	end)
end)

-- Settings Shit

Base.Settings = {}

Base.Settings.All = function()
	return AccountSettings
end

Base.Settings.Get = function(set_name)
	if (AccountSettings) then
		if AccountSettings[set_name] then
			return AccountSettings[set_name]
		end
	end
	return nil
end

Base.Settings.Set = function(set_name, value)
	AccountSettings[set_name] = value
	UpdateSettings()
end