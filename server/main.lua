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

RegisterCommand('deleteped', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if IsAuthorized(source) then
        if args[1] then
            local target = ESX.GetPlayerFromId(args[1])
            local userPed = Peds[target.getIdentifier()]
            if userPed == nil then
                xPlayer.showNotification('The player dont have any ped')
            else
                TriggerClientEvent('gacha_peds:client:openDeletePedMenu', source, userPed.options().getPedsTable(), args[1])
            end
        end
    end
end)

ESX.RegisterServerCallback('gacha_peds:callback:getPeds', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local userPed = Peds[xPlayer.getIdentifier()]
    if userPed == nil then
        cb({})
    else
        cb(userPed.options().getPedsTable())
    end
end)

ESX.RegisterServerCallback('gacha_peds:callback:getCurrentLoadOut', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getLoadout())
end)

RegisterServerEvent('gacha_peds:server:editLabel')
AddEventHandler('gacha_peds:server:editLabel', function(model, newLabel)
    local xPlayer = ESX.GetPlayerFromId(source)
    local userPed = Peds[xPlayer.getIdentifier()]
    userPed.options().editLabel(model, newLabel, function(done)
        if done then
            xPlayer.showNotification('Label edited successfully!')
        end
    end)
end)

RegisterServerEvent('gacha_peds:server:deletePed')
AddEventHandler('gacha_peds:server:deletePed', function(model, ply)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(ply)
    local userPed = Peds[target.getIdentifier()]
    if IsAuthorized(source) then
        userPed.options().removePed(model,function(done)
            if done then
                xPlayer.showNotification('Ped removed successfully!')
                target.showNotification('Ped removed successfully!')
            end
        end)
    end
end)