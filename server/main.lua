Peds = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM gacha_peds', {}, function(x)
        for k,v in pairs(x) do
            Peds[v.identifier] = CreatePedTable(v.identifier, json.decode(v.peds))
        end
	end)
end)

RegisterCommand('giveped', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if IsAuthorized(source) then
        if args[1] and args[2] and args[3] then
            local target = ESX.GetPlayerFromId(args[1])
            local userPed = Peds[target.getIdentifier()]
            if userPed == nil then
                NewPedTable(target.getIdentifier(), args[2], args[3], target, xPlayer)
            else
                userPed.options().addPed(args[2], args[3], function(done)
                    if done then
                        xPlayer.showNotification("Ped added successfully!")
                        target.showNotification('You received a ped')
                    end
                end)
            end
        end
    end
end)