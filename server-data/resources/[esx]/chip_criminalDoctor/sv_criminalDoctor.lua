ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterServerEvent("chip_cDoc:takeMoney")
AddEventHandler("chip_cDoc:takeMoney", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() > Config.toPay then
        print("Hello1")
        TriggerClientEvent("chip_cDoc:getHelp", source)
        TriggerClientEvent('skeletalsystem:UseItem', source, {"Body"},true)
        TriggerClientEvent('skeletalsystem:UseItem', source, {"LeftLeg","RightLeg"},true)
        TriggerClientEvent('skeletalsystem:UseItem', source, {"Head"},true)
        TriggerClientEvent('skeletalsystem:UseItem', source, {"RightArm","LeftArm"},true)
        xPlayer.removeMoney(2000)
    else
        print("I aint got no dollas")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, 
        { 
            type = 'error', 
            text = '你沒有足夠的現金', 
            style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } 
        })
    end

end)