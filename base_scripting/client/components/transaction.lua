Base.Transaction = {}

Base.Transaction.Id = 0
Base.Transaction.Data = {}
Base.Transaction.InProgress = false

Base.InTrasaction = function()
	return Base.Transaction.InProgress
end

Base.Transaction.start = function(item, count, cb)
	if (not Base.Transaction.InProgress) then
		Base.Transaction.InProgress = true

		if (cb ~= nil) then
			Base.Transaction.Data[Base.Transaction.Id] = cb
		end
		TriggerEvent("fdg_ui:SendNotification", "Transaction Pending", { queue = "transaction", animation = { open = "gta_effects_fade_in", close = "gta_effects_fade_out" }, layout = "bottomRight", timeout = 9999999 })
		
		Wait(1000) -- spam prevention

		TriggerServerEvent("base:transaction", Base.Transaction.Id, item, count, (cb ~= nil))
		if (Base.Transaction.Id < 10000) then
			Base.Transaction.Id = Base.Transaction.Id + 1
		else
			Base.Transaction.Id = 0
		end
	else
		print("Base: Inti-Spam")
	end
end

-- Events
RegisterNetEvent("base:transaction")
AddEventHandler("base:transaction", function(id, cb, success)
	TriggerEvent("fdg_ui:ClearNotifications", "transaction")
	if (cb) then
		Base.Transaction.Data[id](success)
		Base.Transaction.Data[id] = nil
	end
	Base.Transaction.InProgress = false
end)

RegisterCommand("transaction", function(source, args)
	Base.Transaction.start(args[1], tonumber(args[2]), function(success)
		if (success) then

		end
	end)
end)