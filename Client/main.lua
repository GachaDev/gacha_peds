ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('openpedmenu', function ()
    OpenPedMenu()
end)

RegisterNetEvent('gacha_peds:client:openDeletePedMenu')
AddEventHandler('gacha_peds:client:openDeletePedMenu', function(results, currentSource)
    if next(results) ~= nil then
        OpenDeletePedMenu(currentSource, results)
    else
        ESX.ShowNotification('The player dont have any ped')
    end
end)