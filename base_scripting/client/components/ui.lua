------------------------------
-- Menus --
------------------------------

Base.UI                        = {}
Base.UI.HUD                    = {}
Base.UI.HUD.RegisteredElements = {}
Base.UI.Menu                   = {}
Base.UI.Menu.RegisteredTypes   = {}
Base.UI.Menu.Opened            = {}


Base.UI.Menu.RegisterType = function(type, open, close)
	Base.UI.Menu.RegisteredTypes[type] = {
		open   = open,
		close  = close,
	}
end

local _type = type

Base.UI.Menu.Open = function(type, namespace, name, data, submit, cancel, change, close)

	local menu = {}

	menu.type      = type
	menu.namespace = namespace
	menu.name      = name
	menu.data      = data
	menu.submit    = submit
	menu.cancel    = cancel
	menu.change    = change

	menu.close = function()

		Base.UI.Menu.RegisteredTypes[type].close(namespace, name)

		for i=1, #Base.UI.Menu.Opened, 1 do

			if Base.UI.Menu.Opened[i] ~= nil then
				if Base.UI.Menu.Opened[i].type == type and Base.UI.Menu.Opened[i].namespace == namespace and Base.UI.Menu.Opened[i].name == name then
					Base.UI.Menu.Opened[i] = nil
				end
			end

		end

		if close ~= nil then
			close()
		end

	end

	menu.update = function(query, newData)

		local updated = false

		for i=1, #menu.data.elements, 1 do

			local match = true

			for k,v in pairs(query) do
				if menu.data.elements[i][k] ~= v then
					match = false
				end
			end

			if match then
				for k,v in pairs(newData) do
					menu.data.elements[i][k] = v
					updated = true
				end
			end

		end

		if not updated then
			table.insert(menu.data.elements, newData)
		end

	end

	menu.refresh = function()
		Base.UI.Menu.RegisteredTypes[type].open(namespace, name, menu.data)
	end

	menu.setElement = function(i, key, val)
		menu.data.elements[i][key] = val
	end

	table.insert(Base.UI.Menu.Opened, menu)

	Base.UI.Menu.RegisteredTypes[type].open(namespace, name, data)

	return menu
end

Base.UI.Menu.Close = function(type, namespace, name)

	for i=1, #Base.UI.Menu.Opened, 1 do
		if Base.UI.Menu.Opened[i] ~= nil then
			if Base.UI.Menu.Opened[i].type == type and Base.UI.Menu.Opened[i].namespace == namespace and Base.UI.Menu.Opened[i].name == name then
				Base.UI.Menu.Opened[i].close()
				Base.UI.Menu.Opened[i] = nil
			end
		end
	end
end

Base.UI.Menu.CloseAll = function()

	for i=1, #Base.UI.Menu.Opened, 1 do
		if Base.UI.Menu.Opened[i] ~= nil then
			Base.UI.Menu.Opened[i].close()
			Base.UI.Menu.Opened[i] = nil
		end
	end
end

Base.UI.Menu.GetOpened = function(type, namespace, name)

	for i=1, #Base.UI.Menu.Opened, 1 do
		if Base.UI.Menu.Opened[i] ~= nil then
			if Base.UI.Menu.Opened[i].type == type and Base.UI.Menu.Opened[i].namespace == namespace and Base.UI.Menu.Opened[i].name == name then
				return Base.UI.Menu.Opened[i]
			end
		end
	end
end

Base.UI.Menu.GetOpenedMenus = function()
	return Base.UI.Menu.Opened
end

Base.UI.Menu.IsOpen = function(type, namespace, name)
	return Base.UI.Menu.GetOpened(type, namespace, name) ~= nil
end

------------------------------
-- Notifications --
------------------------------

Base.Notification = function(text, settings)
	TriggerEvent("fdg_ui:SendNotification", text, settings or {})
end

Base.ClearNotifications = function(queue)
	TriggerEvent("fdg_ui:ClearNotifications", queue)
end

Base.ShowNotification = function(msg)
	Base.Notification(msg)
end

Base.ShowHelpNotification = function(msg)
	if not IsHelpMessageOnScreen() then
		SetTextComponentFormat('STRING')
		AddTextComponentString(msg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end
end

RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', function(msg)
	Base.ShowNotification(msg)
end)

RegisterNetEvent('esx:showHelpNotification')
AddEventHandler('esx:showHelpNotification', function(msg)
	Base.ShowHelpNotification(msg)
end)

------------------------------
-- 3D Text --
------------------------------
Base.DrawText = function(x,y,z, text)
	DrawText3Ds(x,y,z, text)
end

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
    SetTextEdge(3, 0, 0, 0, 255)
 	SetTextOutline() 
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

local actionComplete = false

RegisterNetEvent("fdg:sendTextToPlayer")
AddEventHandler("fdg:sendTextToPlayer", function(target, text, time)
	local actionComplete = false     
	Citizen.CreateThread(function()
		while not actionComplete do
			local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
			Base.DrawText(coords.x, coords.y, coords.z + 1.0, text)
			Wait(0)
		end
	end)
	Citizen.CreateThread(function()
		Wait(time)
		actionComplete = true
	end)
end)

---------
-- HUD --
---------
local hud_state = true

Base.HUD = {}

Base.HUD.Toggle = function(toggle)
	if toggle ~= nil then
		hud_state = toggle
		TriggerEvent("core_hud:toggle", hud_state)
	end
end

Base.HUD.State = function()
	return hud_state
end

--[[
		INSTRUCTION BUTTONS
		BY ILLUSIVETEA
		GITHUB https://gist.github.com/IllusiveTea/c9e33f678586b02f68315c7ca3ceec33
]]

local function ButtonMessage(text)
	BeginTextCommandScaleformString(text)
	EndTextCommandScaleformString()
end

local function Button(ControlButton)
	N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform, data)
	local scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	for n, btn in next, data do
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(n-1)
		Button(GetControlInstructionalButton(2, btn.control, true))
		ButtonMessage(btn.name)
		PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

local form = nil
local data = {}

local entries = {}

function SetInstructions()
	form = setupScaleform("instructional_buttons", entries)
end

Citizen.CreateThread(function()
	while true do
		if form then
			DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
		end

		for k, entry in next, entries do
			if entry.cb then
				if IsControlJustPressed(0, entry.control) then
					entry.cb()
				end
			end
		end
		Wait(0)
	end
end)

local labels = {}

Base.UI.setInstructionalButton = function(label, control, enabled, cb)
	local found = false

	local name = string.upper(string.gsub(label, " ", "_"))

	if not labels[name] then
		print("[scripting/ui] Registering Text Label "..name, label)
		AddTextEntry(name, label)
		labels[name] = true
	end

	for k, entry in next, entries do
		if entry.name == name and entry.control == control then
			found = true
			if not enabled then
				table.remove(entries, k)
				SetInstructions()
			end
			break
		end
	end
	if not found then
		if enabled then
			table.insert(entries, {name = name, control = control, cb = cb})
			SetInstructions()
		end
	end
end