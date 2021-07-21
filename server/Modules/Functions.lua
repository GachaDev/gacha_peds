IsAuthorized = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(Config['groups']) do
        if v == xPlayer.getGroup() then
            return true
        end
    end
    return false
end

NewPedTable = function(identifier, model, label, target, xPlayer)
    local peds = {}
    table.insert(peds, {value = model, label = label})
    if not Config.UseGhmattimysql then
        MySQL.Async.execute("INSERT INTO gacha_peds (identifier, peds) VALUES (@identifier, @peds)", {
            ['@identifier']    = identifier,
            ['@peds'] = json.encode(peds)
        })
    else
        exports.ghmattimysql:execute("INSERT INTO gacha_peds (identifier, peds) VALUES (@identifier, @peds)", {
            ['@identifier'] = identifier,
            ['@peds'] = json.encode(peds)
        })
    end
    Peds[identifier] = CreatePedTable(identifier, peds)
    xPlayer.showNotification("Ped added successfully!")
    target.showNotification('You received a ped')
end