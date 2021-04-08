Base.Database = {}
Base.Database.dataHandlers = {}
Base.Database.dataCache = {}

Base.Database.onClientData = function(identifier, index, cb)
    -- Register the new handler
    if (Base.Database.dataHandlers[identifier] == nil) then
        Base.Database.dataHandlers[identifier] = {}
    end
    Base.Database.dataHandlers[identifier][index] = cb

    -- Send cached data if applicable
    if Base.Database.dataHandlers[identifier][index] then
        cb(data)
    end
end

RegisterNetEvent("scripting:sendClientData")
AddEventHandler("scripting:sendClientData", function(identifier, data)
    -- Cache data for undefined handlers
    Base.Database.dataCache[identifier] = data

    -- Trigger data on existing handlers
    if Base.Database.dataHandlers[identifier] then
        for i in pairs(Base.Database.dataHandlers[identifier]) do
            Base.Database.dataHandlers[identifier][i](data)
        end
    end
end)