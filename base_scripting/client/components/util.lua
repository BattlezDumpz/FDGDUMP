Base.Util = {}

Base.Util.wait = function(condition, interval, loops)
    while not condition() and loops > 0 do
        Wait(interval)    
        loops = loops - 1
    end

    if condition or loops > 0 then
        return true
    end

    return false
end

Base.Util.fadeScreen = function(state, fadeTime)
    if state then
        DoScreenFadeOut(fadeTime)
        while not IsScreenFadedOut() do Wait(50) end
    else
        DoScreenFadeIn(fadeTime)
        while not IsScreenFadedIn() do Wait(50) end
    end
end