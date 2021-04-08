Base.Round = function(value)
	return value >= 0 and math.floor(value + 0.5) or math.ceil(value - 0.5)
end

Base.IsValidWeapon = function(weapon)
	return (Config.Weapons[weapon] ~= nil)
end

Base.GetWeaponList = function()
	return Config.Weapons
end

Base.GetWeaponLabel = function(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = Base.GetWeaponList()
	local label = "Unknown"
	
	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			label = weapons[i].label
			break
		end
	end
	
	return label
end

Base.GetWeaponComponentHash = function(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = Base.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j].hash
				end
			end
		end
	end
end