Peds = {}
UserPedsId = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM gacha_peds', {}, function(x)
        for k,v in pairs(x) do
            Peds[v.id] = CreatePedTable(v.id, v.identifier, v.peds)
            table.insert(UserPedsId, {identifier = v.identifier, id = v.id})
        end
	end)
end)