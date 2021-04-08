------------------------------
-- Scaleforms --
------------------------------

Base.Scaleform = {}
Base.Scaleform.Utils = {}



------------------------------
-- News Messages --
------------------------------
-- RegisterNetEvent('aopcounty')
-- AddEventHandler('aopcounty', function()
--     local timer = 500 -- 5 seconds
--     function Initialize(scaleform)
    
--         local scaleform = RequestScaleformMovie(scaleform)

--         while not HasScaleformMovieLoaded(scaleform) do
--             Citizen.Wait(0)
--         end
--         PushScaleformMovieFunction(scaleform, "SET_TEXT")
--         PushScaleformMovieFunctionParameterString("AOP IS NOW COUNTY")
--         PushScaleformMovieFunctionParameterString("ROBBING BANKS AND STORES IN CITY IS PROHIBITED")
--         PopScaleformMovieFunctionVoid()
        
--         return scaleform
--     end 
--     scaleform = Initialize("breaking_news")
    
--     while timer >= 0 do
--         Citizen.Wait(0)
--         DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
--         timer = timer - 1
--     end
--     SetScaleformMovieAsNoLongerNeeded(scaleform)
-- end)

RegisterNetEvent('robg6')
AddEventHandler('robg6', function()
    local timer = 500 -- 30 seconds
    function Initialize(scaleform)
    
        local scaleform = RequestScaleformMovie(scaleform)

        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "SET_TEXT")
        PushScaleformMovieFunctionParameterString("Gruppe 6 Armoured Truck currently doing pickups")
        PushScaleformMovieFunctionParameterString("Feeling lucky? Try to rob it, guards are heavily armed, check the guide on #general")
        PopScaleformMovieFunctionVoid()
        
        return scaleform
    end 
    scaleform = Initialize("breaking_news")
    
    while timer >= 0 do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        timer = timer - 1
    end
    SetScaleformMovieAsNoLongerNeeded(scaleform)
end)

-- RegisterNetEvent('aopcity')
-- AddEventHandler('aopcity', function()
--     local timer = 500 -- 30 seconds
--     function Initialize(scaleform)
    
--         local scaleform = RequestScaleformMovie(scaleform)

--         while not HasScaleformMovieLoaded(scaleform) do
--             Citizen.Wait(0)
--         end
--         PushScaleformMovieFunction(scaleform, "SET_TEXT")
--         PushScaleformMovieFunctionParameterString("AOP is now City")
--         PushScaleformMovieFunctionParameterString("Robbing Banks / Stores in county is now prohibited.")
--         PopScaleformMovieFunctionVoid()
        
--         return scaleform
--     end 
--     scaleform = Initialize("breaking_news")
    
--     while timer >= 0 do
--         Citizen.Wait(0)
--         DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
--         timer = timer - 1
--     end
--     SetScaleformMovieAsNoLongerNeeded(scaleform)
-- end)

-- RegisterNetEvent('aopmap')
-- AddEventHandler('aopmap', function()
--     local timer = 500 -- 30 seconds
--     function Initialize(scaleform)
    
--         local scaleform = RequestScaleformMovie(scaleform)

--         while not HasScaleformMovieLoaded(scaleform) do
--             Citizen.Wait(0)
--         end
--         PushScaleformMovieFunction(scaleform, "SET_TEXT")
--         PushScaleformMovieFunctionParameterString("AOP now map wide")
--         PushScaleformMovieFunctionParameterString("Enjoy the variety LSLA has to offer.")
--         PopScaleformMovieFunctionVoid()
        
--         return scaleform
--     end 
--     scaleform = Initialize("breaking_news")
    
--     while timer >= 0 do
--         Citizen.Wait(0)
--         DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
--         timer = timer - 1
--     end
--     SetScaleformMovieAsNoLongerNeeded(scaleform)
-- end)