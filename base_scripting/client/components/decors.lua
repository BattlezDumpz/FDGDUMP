Base.Decors = {}
Base.Decors.list = {}
Base.Decors.lastPed = -1

Base.Decors.set = function(key, value, decorType)
	Base.Decors.list[key] = {value = value, decorType = decorType or 3}

	DecorRegister(key, value, decorType or 3)

	-- Force a decor refresh
	Base.Decors.lastPed = -1
end

Base.Decors.remove = function(key)
	Base.Decors.list[key] = nil

	DecorRemove(PlayerPedId(), key)
end

Base.Decors.get = function(key)
	local decor = Base.Decors.list[key]
	local playerPed = PlayerPedId()

	if not DecorExistOn(playerPed, key) then return false end

	if decor.decorType == 1 then
		return DecorGetFloat(playerPed, k)

	elseif decor.decorType == 2 then
		return DecorGetBool(playerPed, k)

	elseif decor.decorType == 3 then
		return DecorGetInt(playerPed, k)

	elseif decor.decorType == 4 then
		--DecorSetFloat(k, v.value)
		-- unk type

	elseif decor.decorType == 5 then
		return DecorGetTime(playerPed, k)

	end
end

Citizen.CreateThread(function()
	while true do
		Wait(10000)
		local playerPed = PlayerPedId()

		if playerPed ~= Base.Decors.lastPed then
			Base.Decors.lastPed = playerPed

			for k, v in pairs(Base.Decors.list) do
				if v.decorType == 1 then
					DecorSetFloat(playerPed, k, v.value)

				elseif v.decorType == 2 then
					DecorSetBool(playerPed, k, v.value)

				elseif v.decorType == 3 then
					DecorSetInt(playerPed, k, v.value)

				elseif v.decorType == 4 then
					--DecorSetFloat(k, v.value)
					-- unk type

				elseif v.decorType == 5 then
					DecorSetTime(playerPed, k, v.value)

				end
			end
		end
	end
end)