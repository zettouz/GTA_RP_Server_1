ESX = nil
local ShowText = false

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx_watch:ShowTime')
AddEventHandler('esx_watch:ShowTime', function()
    ShowText = not ShowText
end)

function DrawMissionText(text)
    SetTextScale(0.5, 0.5)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(0.9,0.955)
end

Citizen.CreateThread(function()
    while true do
        if ShowText then
            DrawMissionText("hihi")
        end
        Citizen.Wait(0)
    end
end)


