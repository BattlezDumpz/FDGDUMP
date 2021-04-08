-- Base Framework Init
Base = {}
PlayerData = {}

baseLoaded = false
isDead = false
isCuffed = false
isInTrunk = false
betaTester = false
subduty = true
duty = true
aop = 'map'

local callbacks = {}
local moduleCbs = {}

function onBaseModuleReady(moduleName, cb)
    moduleCbs[moduleName] = cb
end

function onBaseReady(cb)
	if baseLoaded then Citizen.CreateThread(cb) end
	table.insert(callbacks, cb)
end

function loadExports(tbl)
    for k, v in pairs(tbl) do
        if type(v) == "function" then exports(k, v) end
    end
end

local function loadModule(moduleName, moduleResource)
    Base.Modules[moduleName] = exports[moduleResource]
    if moduleCbs[moduleName] then Citizen.CreateThread(moduleCbs[moduleName]) end
end

local function loadBaseObj(obj)
	baseLoaded = false
	Wait(100)

	-- Load
	Base = obj
    PlayerData = Base.GetPlayerData()

	-- Load exported modules
	Base.Modules = {}
    loadModule("Tablet", "main_tablet")

	-- Trigger onBaseReady callbacks
    baseLoaded = true
    for i, cb in ipairs(callbacks) do Citizen.CreateThread(cb) end
end

AddEventHandler("base:reset", loadBaseObj)
TriggerEvent('base:init', loadBaseObj)

-- Synchronised States
RegisterNetEvent('updateaop')
AddEventHandler('updateaop', function(newaop) aop = newaop end)

RegisterNetEvent('toggleBeta')
AddEventHandler('toggleBeta', function(state) betaTester = state end)

RegisterNetEvent('esx:toggleDuty')
AddEventHandler('esx:toggleDuty', function(state, sub) if (sub) then subduty = state else duty = state end end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) PlayerData.job = job end)

RegisterNetEvent('esx:setSubJob')
AddEventHandler('esx:setSubJob', function(job) PlayerData.subjob = job end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	duty = PlayerData.duty
end)

RegisterNetEvent("main_dispatch:SyncCallsign")
AddEventHandler("main_dispatch:SyncCallsign", function(callsign) PlayerData.callsign = callsign end)

AddEventHandler("playerTrunk", function(state) isInTrunk = state end)

-- Export Variables
Citizen.CreateThread(function()
	while true do
		if exports["core_citizen"]["isPlayerDead"] and exports["core_citizen"]:isPlayerDead() then isDead = true else isDead = false end
		if exports["core_citizen"]["isPlayerCuffed"] and exports["core_citizen"]:isPlayerCuffed() then isCuffed = true else isCuffed = false end
		Wait(1000)
	end
end)

-- Export Shortcuts
fdgMenus   = exports["core_menu"]
fdgJobs    = exports["core_jobs"]
fdgVehicle = exports["core_vehicles"]
fdgCitizen = exports["core_citizen"]

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