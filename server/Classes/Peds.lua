CreatePedTable = function(identifier, peds)

    local this = {}
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

        options.addPed = function(model, label, cb)
            table.insert(this.peds, {value = model, label = label})
            if not Config.UseGhmattimysql then
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
            else
                exports.ghmattimysql:execute("UPDATE gacha_peds SET peds = @peds WHERE identifier = @identifier", {
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

        options.editLabel = function(model, label, cb)
            for k,v in pairs(this.peds) do
                if v.value == model then
                    v.label = label
                    if not Config.UseGhmattimysql then
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
                    else
                        exports.ghmattimysql:execute("UPDATE gacha_peds SET peds = @peds WHERE identifier = @identifier", {
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
        end

        options.removePed = function(model, cb)
            for k,v in pairs(this.peds) do
                if v.value == model then
                    table.remove(this.peds, k)
                    if not Config.UseGhmattimysql then
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
                    else
                        exports.ghmattimysql:execute("UPDATE gacha_peds SET peds = @peds WHERE identifier = @identifier", {
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
        end

        return options

    end

    return this

end