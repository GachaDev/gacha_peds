CreatePedTable = function(id, identifier, peds)

    local this = {}
    this.id = id
    this.identifier = identifier
    this.peds = peds

    this.options = function()

        local options = {}

        options.getPedsTable = function(cb)
            if cb then
               return cb(this.peds)
            else
                return this.peds
            end
        end

        options.editLabel = function(model, label, cb)
            for k,v in pairs(this.peds) do
                if v.model == model then
                    v.label = label
                    MySQL.Async.execute("UPDATE gacha_peds SET peds = @peds WHERE identifier = @identifier", {
                        ['@peds'] = json.encode(this.peds),
                        ['@identifier'] = this.identifier,
                    }, function(row)
                        if cb then
                            return cb(true)
                        else
                            return true
                        end
                    end)
                end
            end
        end

        options.removePed = function(model, cb)
            for k,v in pairs(this.peds) do
                if v.model == model then
                    table.remove(this.peds, k)
                    MySQL.Async.execute("UPDATE gacha_peds SET peds = @peds WHERE identifier = @identifier", {
                        ['@peds'] = json.encode(this.peds),
                        ['@identifier'] = this.identifier,
                    }, function(row)
                        if cb then
                            return cb(true)
                        else
                            return true
                        end
                    end)
                end
            end
        end

        return options

    end

    return this

end