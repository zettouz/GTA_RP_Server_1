ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if ESX ~= nil then
       
        else
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)
 
local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
 
rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = {"general:flipvehicle",  "general:checkoverself", "general:emotes", "general:apartgivekey", "general:aparttakekey",  'prison_status_panel:open', 'dice:roll1'}
    },
    {
        id = "amb-ability",
        displayName = "急救天賦",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        ability = exports["esx_ability"]:GetAbility()
            if ability == "ambulance" and not fuck then
                return true
            end
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = { "esx_amb_ability:generateBandage", "esx_amb_ability:generateMedkit" }
    },
    {
        id = "chef-ability",
        displayName = "烹飪天賦",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        ability = exports["esx_ability"]:GetAbility()
            if ability == "chef" and not fuck then
                return true
            end
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = { "esx_chef_ability:generateBread", "esx_chef_ability:generateWater" }
    },
    {
        id = "mech-ability",
        displayName = "修車天賦",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        ability = exports["esx_ability"]:GetAbility()
            if ability == "mechanic" and not fuck then
                return true
            end
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = { "esx_mech_ability:generateFixkit" }
    },
    {
        id = "lock-ability",
        displayName = "開鎖天賦",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        ability = exports["esx_ability"]:GetAbility()
            if ability == "lock" and not fuck then
                return true
            end
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = { "esx_lock_ability:generateLockpick" }
    },
    {
        id = "gun-ability",
        displayName = "槍械天賦",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        ability = exports["esx_ability"]:GetAbility()
            if ability == "gun" and not fuck then
                return true
            end
        end,
        --subMenus = {"general:flipvehicle",  "general:checkoverself", "general:checktargetstates",  "general:keysgive",  "general:emotes",  "general:checkvehicle", "general:apartgivekey", "general:aparttakekey"  }
        subMenus = { "esx_gun_ability:generateClip" }
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        --subMenus = {"cuffs:cuff", "cuffs:softcuff", "cuffs:uncuff", "police:escort", "police:putinvehicle", "police:unseatnearest", "cuffs:checkinventory", --[[ "cuffs:remmask",  "police:frisk", ]]--[[ "police:removeweapons" ]] "police:revive", "police:gsr", "police:openmdt", "police:getid", "police:impound"}
        subMenus = {"esx_policejob:handcuff", "esx_policejob:unrestrain", "police:escort", "police:putinvehicle","police:takeoutvehicle", "police:unseatnearest","police:seatnearest", "cuffs:checkinventory", --[[ "cuffs:remmask",  "police:frisk", ]]--[[ "police:removeweapons" ]] "police:communityservice", "police:openmdt", "police:getid", "esx-qalle-jail:openJailMenu"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                return true
            end
        end,
        subMenus = {--[[ "general:unseatnearest", ]] "police:runplate", --[[ "police:toggleradar" ]]}
    },
    {
        id = "policeDead",
        displayName = "10-13",
        icon = "#police-dead",
        functionName = "st:panicTrigger",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and fuck then
                return true
            end
        end,
    },
    {
        id = "emsDead",
        displayName = "10-14",
        icon = "#ems-dead",
        functionName = "st:panicTriggerMedic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "ambulance" and fuck then
                return true
            end
        end,
    },
    --[[{
        id = "k9",
        displayName = "K9",
        icon = "#k9",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"k9:follow", "k9:vehicle",   "k9:sniffvehicle",  "k9:huntfind",  "k9:sit", "k9:stand", "k9:sniff", "k9:lay",  "k9:spawn", "k9:delete", }
    },--]]
    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "judge-raid",
        displayName = "Judge Raid",
        icon = "#judge-raid",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "judge-raid:checkowner", "judge-raid:seizeall", "judge-raid:takecash", "judge-raid:takedm"}
    },
    {
        id = "judge-licenses",
        displayName = "Judge Licenses",
        icon = "#judge-licenses",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:checklicenses", "judge:grantDriver", "judge:grantBusiness", "judge:grantWeapon", "judge:grantHouse", "judge:grantBar", "judge:grantDA", "judge:removeDriver", "judge:removeBusiness", "judge:removeWeapon", "judge:removeHouse", "judge:removeBar", "judge:removeDA", "judge:denyWeapon", "judge:denyDriver", "judge:denyBusiness", "judge:denyHouse" }
    },
--[[     {
        id = "judge-actions",
        displayName = "Judge Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    }, ]]
    {
        id = "judge-actions",
        displayName = "Mechanic Actions",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound"}
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "ambulance" and not fuck then
                return true
            end
        end,
        --subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:drag", "medic:undrag", "medic:putinvehicle", "medic:takeoutvehicle", }
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:putinvehicle", "MF_SkeletalSystem:checkOther","MF_SkeletalSystem:useItemOther","medic:billing"}
    },
    {
        id = "Smedic",
        displayName = "SMedical",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "Sambulance" and not fuck then
                return true
            end
        end,
        --subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:drag", "medic:undrag", "medic:putinvehicle", "medic:takeoutvehicle", }
        subMenus = {"Smedic:revive", "Smedic:clean", "Smedic:bigheal", "Smedic:mor","Smedic:lido", "MF_SkeletalSystem:checkOther","MF_SkeletalSystem:useItemOther"}
    },
    {
        id = "doctor",
        displayName = "Doctor",
        icon = "#doctor",
        enableMenu = function()
            return (not isDead and isDoctor)
        end,
        subMenus = { "general:escort", "medic:revive", "general:checktargetstates", "medic:heal" }
    },
    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu = function()
            return (not isDead and isNews)
        end,
        subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
    },
--[[     {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            if not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                return true
            end
        end,
    }, ]]
    {
        id = "impound",
        displayName = "Impound Vehicle",
        icon = "#impound-vehicle",
        functionName = "impoundVehicle",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            if not fuck and myJob == "towtruck" and #(GetEntityCoords(PlayerPedId()) - vector3(549.47796630859, -55.197559356689, 71.069190979004)) < 10.599 then
                return true
            end
            return false
        end
    }, {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck and hasOxygenTankOn
        end
    }, {
        id = "cocaine-status",
        displayName = "Request Status",
        icon = "#cocaine-status",
        functionName = "cocaine:currentStatusServer",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }, {
        id = "cocaine-crate",
        displayName = "Remove Crate",
        icon = "#cocaine-crate",
        functionName = "cocaine:methCrate",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }
}

newSubMenus = {
    ['general:emotes'] = {
        title = "動作",
        icon = "#general-emotes",
        functionName = "dp:RecieveMenu"
    },    
    ['general:keysgive'] = {
        title = "給鑰匙",
        icon = "#general-keys-give",
        functionName = "st:givekey"
    },
    ['general:apartgivekey'] = {
        title = "給鑰匙",
        icon = "#general-apart-givekey",
        functionName = "menu:givekeys"
    },
    ['general:aparttakekey'] = {
        title = "拿鑰匙",
        icon = "#general-apart-givekey",
        functionName = "menu:takekeys"
    },
    ['general:checkoverself'] = {
        title = "檢查身體",
        icon = "#general-check-over-self",
        functionName = "MF_SkeletalSystem:openSkelly"
    },
    ['prison_status_panel:open'] = {
        title = "能力值",
        icon = "#general-check-over-self",
        functionName = "prison_status:open"
    },
    ['dice:roll1'] = {
        title = "擲骰子",
        icon = "#animation-money",
        functionName = "dice:roll1"
    },
    --[[
    ['general:checktargetstates'] = {
        title = "Examine Target",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    }, ]]
--[[     ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "towgarage:annoyedBouce"
    }, ]]
    ['general:putinvehicle'] = {
        title = "將人押入車內",
        icon = "#general-put-in-veh",
        functionName = "police:forceEnter"
    },
    ['general:unseatnearest'] = {
        title = "將人押出車外",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },    
    ['general:flipvehicle'] = {
        title = "翻正車輛",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['animations:brave'] = {
        title = "勇敢",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "匆忙",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "商業",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "喝醉",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "受傷",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "強硬",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "野蠻",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "傷心",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "時髦",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "外星人",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "冷靜",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "流浪漢",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "錢",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "昂首闊步",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "陰暗",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "食人",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "裝模作樣",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "重製",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['mechanic:hijack'] = {
        title = "劫持",
        icon = "#police-vehicle",
        functionName = "st:hijack"
    },
    ['mechanic:repair'] = {
        title = "修車",
        icon = "#police-vehicle",
        functionName = "st:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "清理",
        icon = "#police-vehicle",
        functionName = "st:mechclean"
    },
    ['mechanic:impound'] = {
        title = "拖車",
        icon = "#police-vehicle",
        functionName = "st:mechimpound"
    },
    ['k9:spawn'] = {
        title = "召喚",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "回去",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "跟隨",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "上/下車",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "坐",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "趴",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "站",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "聞",
        icon = "#k9-sniff",
        functionName = "st:k9drugsniff"
    },
--[[     ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    }, ]]
--[[     ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    }, ]]
--[[     ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    }, ]]
    ['cuffs:cuff'] = {
        title = "上銬",
        icon = "#cuffs-cuff",
        functionName = "st:handcuff"
    },
    ['esx_policejob:handcuff'] = {
        title = "上銬",
        icon = "#cuffs-cuff",
        functionName = "police:handcuff"
    },  
    ['cuffs:softcuff'] = {
        title = "上銬",
        icon = "#cuffs-cuff",
        functionName = "st:softcuff"
    },
    ['cuffs:uncuff'] = {
        title = "解銬",
        icon = "#cuffs-uncuff",
        functionName = "st:uncuff"
    },
    ['esx_policejob:unrestrain'] = {
        title = "解銬",
        icon = "#cuffs-uncuff",
        functionName = "esx_policejob:unrestrain"
    },
--[[     ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    }, ]]
    ['cuffs:checkinventory'] = {
        title = "搜身",
        icon = "#cuffs-check-inventory",
        functionName = "st:search"
    },
    ['cuffs:unseat'] = {
        title = "押下車輛",
        icon = "#cuffs-unseat-player",
        functionName = "esx_ambulancejob:pullOutVehicle"
    },
    ['cuffs:checkphone'] = {
        title = "手機",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "急救",
        icon = "#medic-revive",
        functionName = "medic:revive"
    },
    ['Smedic:revive'] = {
        title = "急救",
        icon = "#medic-revive",
        functionName = "Smedic:revive"
    },
    ['Smedic:clean'] = {
        title = "清理",
        icon = "#medic-heal",
        functionName = "Smedic:clean"
    },
    ['esx_amb_ability:generateBandage'] = {
        title = "製造繃帶",
        icon = "#medic-heal",
        functionName = "esx_amb_ability:generateBandage"
    },
    ['esx_amb_ability:generateMedkit'] = {
        title = "製造醫療包",
        icon = "#medic-heal",
        functionName = "esx_amb_ability:generateMedkit"
    },
    ['esx_chef_ability:generateBread'] = {
        title = "製做麵包",
        icon = "#medic-heal",
        functionName = "esx_chef_ability:generateBread"
    },
    ['esx_chef_ability:generateWater'] = {
        title = "製做水",
        icon = "#medic-heal",
        functionName = "esx_chef_ability:generateWater"
    },
    ['esx_mech_ability:generateFixkit'] = {
        title = "製造修車包",
        icon = "#police-vehicle",
        functionName = "esx_mech_ability:generateFixkit"
    },
    ['esx_lock_ability:generateLockpick'] = {
        title = "製造開鎖工具",
        icon = "#police-vehicle",
        functionName = "esx_lock_ability:generateLockpick"
    },
    ['esx_gun_ability:generateClip'] = {
        title = "製造彈夾",
        icon = "#judge-licenses-grant-weapon",
        functionName = "esx_gun_ability:generateClip"
    },
    ['medic:bigheal'] = {
        title = "治療嚴重傷口",
        icon = "#medic-heal",
        functionName = "medic:bigheal"
    },
    ['Smedic:bigheal'] = {
        title = "治療嚴重傷口",
        icon = "#medic-heal",
        functionName = "Smedic:bigheal"
    },
    ['Smedic:mor'] = {
        title = "嗎啡",
        icon = "#medic-heal",
        functionName = "Smedic:mor"
    },
    ['Smedic:lido'] = {
        title = "利多",
        icon = "#medic-heal",
        functionName = "Smedic:lido"
    },
    ['medic:putinvehicle'] = {
        title = "押上車輛",
        icon = "#general-put-in-veh",
        functionName = "medic:putinvehicle"
    },
    ['medic:takeoutvehicle'] = {
        title = "押下車輛",
        icon = "#general-unseat-nearest",
        functionName = "st:emstakeoutvehicle"
    },
    ['medic:drag'] = {
        title = "拖",
        icon = "#general-escort",
        functionName = "st:emsdrag"
    },
    ['medic:undrag'] = {
        title = "放下",
        icon = "#general-escort",
        functionName = "st:emsundrag"
    },
    ['medic:billing'] = {
        title = "開單",
        icon = "#judge-licenses-grant-business",
        functionName = "medic:billing"
    },
    ['police:escort'] = {
        title = "護送",
        icon = "#general-escort",
        functionName = "police:escort"
    },
    ['MF_SkeletalSystem:checkOther'] = {
        title = "檢查",
        icon = "#police-check-licenses",
        functionName = "MF_SkeletalSystem:checkOther"
    },
    ['MF_SkeletalSystem:useItemOther'] = {
        title = "使用物品",
        icon = "#medic-heal",
        functionName = "MF_SkeletalSystem:useItemOther"
    },
    ['police:revive'] = {
        title = "急救",
        icon = "#medic-revive",
        functionName = "st:pdrevive"
    },
    ['police:putinvehicle'] = {
        title = "押上車輛",
        icon = "#general-put-in-veh",
        functionName = "police:putinvehicle"
    },
    ['police:takeoutvehicle'] = {
        title = "押下車輛",
        icon = "#general-put-in-veh",
        functionName = "police:takeoutvehicle"
    },
    ['police:unseatnearest'] = {
        title = "押下車輛",
        icon = "#general-unseat-nearest",
        functionName = "police:unseatnearest"
    },
    ['police:seatnearest'] = {
        title = "押上車輛",
        icon = "#general-unseat-nearest",
        functionName = "police:seatnearest"
    },
    ['police:impound'] = {
        title = "拖吊",
        icon = "#police-vehicle",
        functionName = "police:impound"
    },
    ['police:communityservice'] = {
        title = "拖吊",
        icon = "#police-vehicle",
        functionName = "police:communityservice"
    },
    ['police:cuff'] = {
        title = "上銬",
        icon = "#cuffs-cuff",
        functionName = "police:cuff"
    },
    ['police:checkbank'] = {
        title = "檢查銀行",
        icon = "#police-check-bank",
        functionName = "police:checkBank"
    },
    ['police:checklicenses'] = {
        title = "檢查證照",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
--[[     ['police:removeweapons'] = {
        title = "Remove Weapons License",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"
    }, ]]
    ['police:gsr'] = {
        title = "GSR",
        icon = "#police-action-gsr",
        functionName = "st:checkGSR"
    },
    ['police:openmdt'] = {
        title = "MDT",
        icon = "#judge-licenses-grant-business",
        functionName = "police:openmdt"
    },
    ['police:getid'] = {
        title = "ID",
        icon = "#police-vehicle-plate",
        functionName = "police:getid"
    },
--[[     ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    }, ]]
    ['police:runplate'] = {
        title = "車牌",
        icon = "#police-vehicle-plate",
        functionName = "st:mdtvehiclesearch"
    },
--[[     ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "police:frisk"
    }, ]]
    ['judge:grantDriver'] = {
        title = "准許證照",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end
