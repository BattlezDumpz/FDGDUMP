Base.Effect = {}
Base.Effect.Activating = false -- if there is already an effect in progress
Base.Effect.Registered = {}

Base.Effect.Register = function(effect_name, effect_item, effect_dynamic, effect_max, effect_timer, effect_od, effect_conflict, func_start, func_loop, func_end, func_multi, func_over)
    if (Base.Effect.Registered[effect_name] ~= nil) then return end
    local self = {}

    self.active = false
    self.multi = 0
    self.count = 1
    self.last = 0
    self.max = effect_max -- max runs through the effect before it wears off

    self.name = effect_name 
    self.item = effect_item
	self.dynamic = effect_dynamic
	self.time = effect_timer
    self.overdose = effect_od
    self.conflicts = effect_conflict

    self.startEffect = func_start
    self.loopEffect = func_loop
	self.endEffect = func_end
	self.multiEffect = func_multi
    self.overdoseEffect = func_over
    
    self.get = function()
        return self
    end

	Base.Effect.Registered[effect_name] = self
end

Base.Effect.CheckConflict = function(conflicts)
    local a = Base.Effect.GetActive()
    for k,v in pairs(conflicts) do
        for i,_ in pairs(a) do
            if v == i then
                conflictingEffect()
                return true
            end
        end
    end
    return false
end

Base.Effect.GetActive = function()
    local _i = {}
    for k,v in pairs(Base.Effect.Registered) do 
        if v.active then
            _i[v.name] = {max = v.overdose, multi = v.multi}
        end
    end
    return _i
end

Base.Effect.IsHigh = function()
    for k,v in pairs(Base.Effect.Registered) do
        if v.active then
            return true
        end
    end
    return false
end

function conflictingEffect()
    
end

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Base.Effect.Registered) do
            if v.dynamic then
                if v.active and GetGameTimer() - v.last > v.time then
                    if v.max == -1 then
                        if not IsPedDeadOrDying(PlayerPedId(), 1) then
                            v.active = v.loopEffect(v)
                        end
                    else
                        if not IsPedDeadOrDying(PlayerPedId(), 1) then
                            v.loopEffect(v)
                        end
                        v.last = GetGameTimer()
                        v.multi = v.multi + 1
                        if v.multi >= v.max * v.count then
                            v.endEffect(v)
                            v.count = 1
                            v.multi = 0
                            v.active = false
                        end
                    end
                end
            end
        end
		Wait(100)
	end
end)

RegisterNetEvent("base_scripting:effect")
AddEventHandler("base_scripting:effect", function(effect)
    if Base.Effect.Registered[effect] then
        if not Base.Effect.Activating then
            Base.Effect.Activating = true
            -- local conflict = Base.Effect.CheckConflict(v.conflicts or {})
            local conflict = false
            if not conflict then
                local e = effect
                if Base.Effect.Registered[e].active then
                    Base.Effect.Registered[e].count = Base.Effect.Registered[e].count + 1
                    if Base.Effect.Registered[e].count > Base.Effect.Registered[e].overdose then
                        Base.Effect.Registered[e].count = Base.Effect.Registered[e].count - 1
                        if Base.Effect.Registered[e].overdoseEffect ~= nil then
                            if Base.Effect.Registered[e].item then
                                Base.removeItem(Base.Effect.Registered[e].item, 1)
                            end
                            Base.Effect.Registered[e].count = 0
                            Base.Effect.Registered[e].active = false
                            Base.Effect.Registered[e].overdoseEffect(Base.Effect.Registered[e])
                            Base.Effect.Registered[e].endEffect(Base.Effect.Registered[e])
                        else
                            TriggerEvent("fdg_ui:SendNotification", "You cannot take any more.")
                        end
                    else
                        if Base.Effect.Registered[e].multiEffect ~= nil then
                            if Base.Effect.Registered[e].item then
                                Base.removeItem(Base.Effect.Registered[e].item, 1)
                            end
                            Base.Effect.Registered[e].active = false
                            Base.Effect.Registered[e].multi = 0
                            Base.Effect.Registered[e].multiEffect(Base.Effect.Registered[e])
                            Base.Effect.Registered[e].active = true
                        end
                    end
                else
                    if Base.Effect.Registered[e].item then
                        Base.removeItem(Base.Effect.Registered[e].item, 1)
                    end
                    Base.Effect.Registered[e].startEffect(Base.Effect.Registered[e])
                    Base.Effect.Registered[e].active = true
                end
            end
            Base.Effect.Activating = false
        end
    else
        print("[BASE] _EFFECT_NOT_FOUND -> "..effect)
    end
end)