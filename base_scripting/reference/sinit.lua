-- Base Framework Init
Base = {}

baseLoaded = false

function onBaseReady(cb)
	Citizen.CreateThread(function()
		while not baseLoaded do Wait(0) end
		cb()
	end)

	AddEventHandler("base:reset", function(obj)
		baseLoaded = false
		Wait(100)		
		baseLoaded = true

		Base = obj
		cb()
	end)
end

function init()
	TriggerEvent('base:init', function(obj)
		Base = obj
		baseLoaded = true
	end)

	-- This line is here in case the script never calls onBaseReady
	AddEventHandler("base:reset", function(obj)	
		baseLoaded = false
		Wait(100)		
		baseLoaded = true
		Base = obj 
	end)
end

init()

-- Synchronised States
aop = 'map'
RegisterNetEvent('updateaop')
AddEventHandler('updateaop', function(newaop) aop = newaop end)

-- Export Shortcuts
fdgMenus   = exports["core_menu"]
fdgJobs    = exports["core_jobs"]
fdgVehicle = exports["core_vehicles"]

-- Developer Functions
debugmode = false
function dbgprint(msg)
	if debugmode then print("["..GetCurrentResourceName().."] "..msg) end
end

locale = {}
function _U(str, ...)
    if locale[str] then
        return string.format(locale[str], ...):gsub("^%l", string.upper)
    else
        return "Language option ["..str.."] not found"
    end
end

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