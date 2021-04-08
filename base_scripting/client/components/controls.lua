Base.Controls = {}

Base.Controls.disabledKeys = {}
Base.Controls.controlList = {}

Base.Controls.register = function(key, label, onPressed, onReleased, onHeld)
    local id = "lsla_"..string.lower(string.gsub(label, " ", ""))
    
    Base.Controls.disabledKeys[key] = false

    Base.Controls.controlList[id] = false

    RegisterCommand("+"..id, function()
        if (not Base.Controls.disabledKeys[key]) then
            Base.Controls.controlList[id] = true

            if onPressed then onPressed() end

            if onHeld then
                while Base.Controls.controlList[id] and onHeld do
                    Wait(0)
                    onHeld()
                end
            end
        end 
    end)

    RegisterCommand("-"..id, function()
        if (not Base.Controls.disabledKeys[key]) then
            Base.Controls.controlList[id] = false
            if onReleased then onReleased() end
        end
    end)

    RegisterKeyMapping("+"..id, label, "keyboard", key)
end

Base.Controls.disable = function(key, toggle)
    Base.Controls.disabledKeys[key] = toggle
end

Base.Controls.disableAll = function(toggle)
    for key in pairs(Base.Controls.disabledKeys) do
        Base.Controls.disabledKeys[key] = toggle
    end
end