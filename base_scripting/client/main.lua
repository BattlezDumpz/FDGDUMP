------------------------------
-- Init Base Table --
------------------------------
Base = {}

function table.clone(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[table.clone(orig_key, copies)] = table.clone(orig_value, copies)
            end
            setmetatable(copy, table.clone(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

AddEventHandler('base:init', function(cb) cb(Base) end)
Citizen.CreateThread(function() Wait(100)
    TriggerEvent("base:reset", Base)
end)

Base.GetConfig = function()
  return Config
end

Base.IsPlayerLoaded = function()
  return Base.PlayerLoaded
end

Base.GetPlayerData = function()
  return Base.PlayerData
end

Base.SetPlayerData = function(key, val)
  Base.PlayerData[key] = val
end

Base.loadModule = function(key, val)
    Base[key] = val
end

local isDead = false

Citizen.CreateThread(function()
    while true do Wait(1000)
        isDead = exports["core_citizen"]:isPlayerDead()
    end
end)

------------------------------
-- Key Commands --
------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 51) then
			TriggerEvent("interact")
		end
	end
end)

------------------------------
-- Sync --
------------------------------

Citizen.CreateThread(function()
	Wait(1000)
	TriggerServerEvent("fdg_sync:Sync")
end)


Base.Log = function (name,message,color,channel)
    TriggerServerEvent('fdg_logs:log', title, message, color, channel)
end

-- global shit

Base.removeItem = function(item, count)
    TriggerServerEvent("base_scripting:removeItem", item, count or 1)
end