local Keys = {['E'] = 38, ['Q'] = 44}

ESX = nil

local currentWorkout = {
    run = false,
    type = -1,
    startTime = -1,
    duration = -1,
    animDict = "",
    animName = ""
}
local lastWorkTime = -1
local ownsMembership = false
local bellmodel = "prop_barbell_100kg"
local netid = nil

-- Get ESX and PlayerData
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData() == nil do Citizen.Wait(100) end
    ESX.PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback('esx_gym:checkMembership',
                              function(result) ownsMembership = result end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(player)
    ESX.PlayerData = player
    ESX.TriggerServerCallback('esx_gym:checkMembership',
                              function(result) ownsMembership = result end)
end)

function startWorkout(type, duration, dict, name)
    currentWorkout = {
        run = true,
        type = type,
        startTime = GetGameTimer(),
        duration = duration,
        animDict = dict,
        animName = name
    }
end

function stopWorkout()
    StopAnimTask(GetPlayerPed(-1), currentWorkout.animDict,
                 currentWorkout.animName, 1.0)
    currentWorkout = {
        run = false,
        type = -1,
        startTime = -1,
        duration = -1,
        animDict = "",
        animName = ""
    }
    if netid then
        DetachEntity(NetToObj(netid), 1, 1)
        DeleteEntity(NetToObj(netid))
        netid = nil
    end
end

-- Create blip
--[[
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y,
                                 Config.Blip.Pos.z)

    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, Config.Blip.Display)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipColour(blip, Config.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.Blip.Title)
    EndTextCommandSetBlipName(blip)
end)
--]]

-- Show workouts
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(Config.Workouts) do
            local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z,
                                                      true)
            -- show marker
            if distance < Config.DrawDistance then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0,
                           Config.MarkerSize.x, Config.MarkerSize.y,
                           Config.MarkerSize.z, Config.MarkerColour.r,
                           Config.MarkerColour.g, Config.MarkerColour.b, 255, 0,
                           0, 0, 1)

                -- show action text
                if distance < 1.0 then
                    SetTextComponentFormat("STRING")
                    if currentWorkout.run == false then
                        AddTextComponentString(
                            string.format("按下 ~INPUT_CONTEXT~ 來 ~g~%s",
                                          v.label))
                    else
                        AddTextComponentString(
                            "按下 ~INPUT_CONTEXT_SECONDARY~ 停止健身")
                    end
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                    -- start workout
                    if currentWorkout.run == false and
                        IsControlJustPressed(0, Keys['E']) then
                        --if ownsMembership == false then
                        --    ESX.ShowNotification("Please buy a gym membership")
                        if lastWorkTime ~= -1 then
                            ESX.ShowNotification("休息中...")
                        else
                            startWorkout(v.workout, v.duration * 1000,
                                         Config.WorkoutScenarios[v.workout][1],
                                         Config.WorkoutScenarios[v.workout][2])
                            local playerPed = GetPlayerPed(-1)
                            SetEntityCoordsNoOffset(playerPed, v.x, v.y, v.z,
                                                    false, false, false)
                            SetEntityHeading(playerPed, v.h)
                            RequestAnimDict(
                                Config.WorkoutScenarios[v.workout][1])
                            while not HasAnimDictLoaded(
                                Config.WorkoutScenarios[v.workout][1]) do
                                Citizen.Wait(10)
                            end
                            if v.workout ==2 then
                                local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                                local bellspawn = CreateObject(GetHashKey(bellmodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
                                netid = ObjToNet(bellspawn)
                                AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
                            end
                            TaskPlayAnim(playerPed,
                                         Config.WorkoutScenarios[v.workout][1],
                                         Config.WorkoutScenarios[v.workout][2],
                                         1.0, -1.0, v.duration * 1000, 1, 1,
                                         true, true, true)
                        end
                    end

                    if currentWorkout.run == true and
                        IsControlJustPressed(0, Keys['Q']) then
                        stopWorkout()
                        lastWorkTime = -1
                        
                    end
                end

            end
        end

        -- Membership
        --[[
        local distance = GetDistanceBetweenCoords(coords,
                                                  Config.Membership.Marker.x,
                                                  Config.Membership.Marker.y,
                                                  Config.Membership.Marker.z,
                                                  true)
        if distance < Config.DrawDistance then
            DrawMarker(Config.MarkerType, Config.Membership.Marker.x,
                       Config.Membership.Marker.y, Config.Membership.Marker.z,
                       0, 0, 0, 0, 0, 0, Config.MarkerSize.x,
                       Config.MarkerSize.y, Config.MarkerSize.z,
                       Config.MarkerColour.r, Config.MarkerColour.g,
                       Config.MarkerColour.b, 255, 0, 0, 0, 1)
                       

            -- show action text
            
            if distance < 1.0 then
                SetTextComponentFormat("STRING")
                AddTextComponentString(string.format(
                                           "~INPUT_CONTEXT~ Buy membership (~g~$%d - %d %s~s~)",
                                           Config.Membership.Price,
                                           Config.Membership.Expire,
                                           (Config.Membership.Expire > 1 and
                                               "days" or "day")))
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                if IsControlJustPressed(0, Keys['E']) then
                    ESX.TriggerServerCallback('esx_gym:buyMembership', function(
                        result)
                        if result then
                            ownsMembership = true
                        end
                    end)
                end
            end
            
        end--]]

    end
end)

-- Track workout / resting progress
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if currentWorkout.run then
            local diff = GetGameTimer() - currentWorkout.startTime
            if diff >= currentWorkout.duration then
                stopWorkout()
                lastWorkTime = GetGameTimer()

                ESX.ShowNotification(string.format(
                                         "需要休息",
                                         Config.RestTime))
                if Config.Ability then
                    local luck = math.random(1,100)
                    if Config.RandomAbility >= luck then
                        TriggerEvent("esx_status:add",Config.IncreseAbility,1)
                        --ESX.ShowNotification("感覺到力量上升了")
                        exports['mythic_notify']:SendAlert('success', '感覺到力量上升了', 5000)
                        TriggerEvent("esx_status:remove",Config.DecreseAbility,1)
                        exports['mythic_notify']:SendAlert('error', '感覺到智力下降了', 5000)
                    end
                end
            end
        end

        if lastWorkTime ~= -1 then
            local diff = GetGameTimer() - lastWorkTime
            if diff >= Config.RestTime * 1000 then lastWorkTime = -1 end
        end
    end
end)
