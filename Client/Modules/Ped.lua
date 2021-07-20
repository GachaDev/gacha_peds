SetPed = function(model)
    local modelHash = GetHashKey(currentModel)
    local health = GetEntityHealth(PlayerPedId())
    SetPedDefaultComponentVariation(PlayerPedId())
    ESX.Streaming.RequestModel(modelHash, function()
        SetPlayerModel(PlayerId(), modelHash)
        SetPedDefaultComponentVariation(PlayerPedId())
        SetModelAsNoLongerNeeded(modelHash)
        SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 2, 0, 0, 2)
        SetEntityMaxHealth(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), health)
    end)
    RestoreWeapons()
end

RestoreWeapons = function()
    ESX.TriggerServerCallback('gacha_peds:callback:getCurrentLoadOut', function(loadout)
        local playerPed = PlayerPedId()
        local ammoTypes = {}
        RemoveAllPedWeapons(playerPed, true)

        for k,v in ipairs(loadout) do
            local weaponName = v.name
            local weaponHash = GetHashKey(weaponName)

            GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
            SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

            local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

            for k2,v2 in ipairs(v.components) do
                local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
                GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
            end

            if not ammoTypes[ammoType] then
                AddAmmoToPed(playerPed, weaponHash, v.ammo)
                ammoTypes[ammoType] = true
            end
        end
    end)
end