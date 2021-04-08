Base.Ped = {}
Base.Ped.ExemptMasks = {27, 36, 73, 109, 114, 120, 121, 122, 145}
Base.Ped.IncHelms = {6, 16, 17, 18, 38, 47, 48, 49, 50, 51, 52, 53, 57, 62, 67, 68, 69, 70, 71, 72, 73, 74, 78, 79, 80, 81, 82, 91, 92, 111, 115, 123, 124, 125, 126, 127, 128, 129, 133, 134}

local fear_level = 0
local mask_override = {}

Base.Ped.hasMask = function(ped, incHelm)
    if (mask_override[ped]) then
        return false, false
    end

    local mask = GetPedDrawableVariation(ped, 1) -- mask
    if (mask ~= 0 and not Base.Ped.ExemptMasks[mask]) then
        return true, false
    end

    if (incHelm) then
        local helm = GetPedPropIndex(ped, 0)
        if (helm ~= -1 and Base.Ped.IncHelms[helm]) then
            return true, true
        end
    end
    return false, false
end

Base.Ped.overrideMaskCheck = function(ped, override)
    if (override) then
        mask_override[ped] = true
    elseif (not override and mask_override[ped]) then
        mask_override[ped] = nil
    end
end

Base.Ped.getFearLevel = function()
    return fear_level
end

Citizen.CreateThread(function()
    local _temp = Base.Ped.ExemptMasks
    Base.Ped.ExemptMasks = {}
    for k,v in pairs(_temp) do
        Base.Ped.ExemptMasks[v] = true
    end

    _temp = Base.Ped.IncHelms
    Base.Ped.IncHelms = {}
    for k,v in pairs(_temp) do
        Base.Ped.IncHelms[v] = true
    end
end)