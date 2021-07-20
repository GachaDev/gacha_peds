OpenPedMenu = function()
    ESX.TriggerServerCallback('gacha_peds:callback:getPeds', function(results)
        if next(results) ~= nil then
            local elements = {}
            for k,v in pairs(results) do
                table.insert(elements, {value = v.value, label = v.label})
            end
            ESX.UI.Menu.Open('default',GetCurrentResourceName(),"ped_menu",
            {
            title = "Peds in possession",
            align = "bottom-right",
            elements = elements
            }, function(data, menu)
                local model = data.current.value
                ESX.UI.Menu.Open('default',GetCurrentResourceName(),"ped_menu_options",
                {
                title = "Ped Options",
                align = "bottom-right",
                elements = {
                    {value = 'setPed', label = 'Set Ped'},
                    {value = 'editLabel', label = 'Edit label'}
                }
                }, function(data2, menu2)
                    if data2.current.value == 'setPed' then
                        SetPed(model)
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            end, function(data, menu)
                menu.close()
            end)
        else
            ESX.ShowNotification('You dont have any ped')
        end
    end)
end