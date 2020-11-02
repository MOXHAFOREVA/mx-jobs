-- Thanks ak4y

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local madenloc = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}

ESX = nil

local anim = false

local carspawnstatus = 0

local impacts = 0

local sleep = 1000




TriggerEvent("esx:getSharedObject", function(library) 
    ESX = library 
end)

Citizen.CreateThread(function()
    while ESX.PlayerData == nil do
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    while ESX.PlayerData.job == nil do
        Citizen.Wait(100)
    end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    Citizen.Wait(100)
end)


function madenselling(labels, values)
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'sellingmenu',
            {
                title    = 'Satış Menüsü',
                elements = {
                    {label = "Elmas", value = "elmas"},
                    {label = "Altın", value = "altin"},
                    {label = "Demir", value = "demir"}, 
                }
            },
            function(data, menu)
                for i = 1, #maden, 1 do
                if data.current.value == "elmas" then
                    TriggerServerEvent('mx-jobs:sellingformaden', maden[i].diamondname, maden[i].diamondprice)
                elseif data.current.value == 'demir' then
                        TriggerServerEvent('mx-jobs:sellingformaden', maden[i].ironname, maden[i].ironprice)
                elseif data.current.value == 'altin' then
                        TriggerServerEvent('mx-jobs:sellingformaden', maden[i].goldname, maden[i].goldprice)
                end
            end
            end,
            function(data, menu)
                menu.close()
            end
        )
end

Citizen.CreateThread(function() -- Satış
    while true do
        Citizen.Wait(sleep)
        local performans = false
        local ped = PlayerPedId()

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "terzi" then
            for i = 1, #terzi, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords,terzi[i].sell.x, terzi[i].sell.y, terzi[i].sell.z, false)
                if dst <= 10 then
                    DrawText3DMX(terzi[i].sell.x, terzi[i].sell.y, terzi[i].sell.z, "Kiyafetleri Satmak Icın ~r~[E]~s~ Bas")
                    performans = true
                end
                if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                    ESX.TriggerServerCallback("mx-jobs:selling", function(count, adet)
                        if count then
                        ESX.ShowNotification("" .. adet .. " Kıyafeti Şukadara [" .. count .. "] Sattın.")
                        else
                            ESX.ShowNotification("üstünde yeterli sayıda kıyafet yok")
                        end
                    end, terzi[i].sellitem, terzi[i].price)
                end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "kasap" then
            for i = 1, #kasap, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords,kasap[i].sell.x, kasap[i].sell.y, kasap[i].sell.z, false)
                if dst <= 8 then
                    DrawText3DMX(kasap[i].sell.x, kasap[i].sell.y, kasap[i].sell.z, "Tavukları Satmak Icin ~r~[E]~s~ Bas", 0.40)
                    performans = true
                end
                if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                    ESX.TriggerServerCallback("mx-jobs:selling", function(count, adet)
                        if count then
                        ESX.ShowNotification("" .. adet .. " eti Şukadara [" .. count .. "] Sattın.")
                        else
                            ESX.ShowNotification("üstünde yeterli sayıda et yok")
                        end
                    end, kasap[i].sellitem, kasap[i].price)
                end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "maden" then
            for i = 1, #maden, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords,maden[i].sell.x, maden[i].sell.y, maden[i].sell.z, false)
                if dst <= 8 then
                    DrawText3DMX(maden[i].sell.x, maden[i].sell.y, maden[i].sell.z, "Maden\' den topladıgın seyleri satmak Için ~r~[E]~s~ Bas")
                    performans = true
                end
                if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                    madenselling()
                end
            end
        end
        
        if not performans then
            sleep = 1000
        end
        if performans then
            sleep = 3
        end

    end
end)

-- Toplama 
Citizen.CreateThread(function()    
    while true do
        Citizen.Wait(sleep)
        local performans = true
        local ped = PlayerPedId()

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "terzi" then
            for i = 1, #terzi, 1 do
                local pedcoord = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoord, terzi[i].clc.x, terzi[i].clc.y, terzi[i].clc.z, false)
                if dst <= 8 then
                    DrawText3DMX(terzi[i].clc.x, terzi[i].clc.y, terzi[i].clc.z, "Kumas Almak Için ~g~ [E] ~s~ BAS")
                    performans = false
                end

                if dst <= 3 and IsControlJustPressed(0, Keys["E"]) then
                    ESX.TriggerServerCallback("mx-jobs:giveable", function(giveable)
                        if giveable then
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "KumasAlma",
                            duration = 10000,
                            label = "Kumas Alınıyor",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = "missheistdockssetup1clipboard@idle_a",
                                anim = "idle_a",
                            },
                            prop = {
                                model = "",
                            }
                        }, function(status)
                            if not status then
                                TriggerServerEvent("mx-jobs:takeitem", terzi[i].clcitem, 1, false) 
                                ClearPedTasks(ped)
                        end
                    end)  
                end
            end, terzi[i].clcitem, terzi[i].AmountRequired, terzi[i].limit)
            end
        end
    end


            if ESX.PlayerData.job  and ESX.PlayerData.job.name == "maden" then
                for i = 1, #maden, 1 do
                    for j = 1, #madenloc, 1 do
                    local pedcoord = GetEntityCoords(ped)
                    local dst = GetDistanceBetweenCoords(pedcoord, madenloc[j].x, madenloc[j].y, madenloc[j].z, false)
                    if dst <= 8 then
                        DrawText3DMX(madenloc[j].x, madenloc[j].y, madenloc[j].z, "Kazmak Icın ~y~E~s~ Bas")
                        performans = false
                    end
                        if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                            RequestAnimDict("melee@large_wpn@streamed_core")
                            Citizen.Wait(100)
                            -- TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                            TaskPlayAnim(PlayerPedId(), "melee@large_wpn@streamed_core", "ground_attack_on_spot", 8.0, -8.0, -1, 1, 0, false, false, false)
                            SetEntityHeading(ped, 270.0)
                            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                            pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                            AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "Maden",
                                duration = 10000,
                                label = "Kazılıyor",
                                useWhileDead = false,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "",
                                    anim = "",
                                },
                                prop = {
                                    model = "",
                                }
                            }, function(status)
                                if not status then
                                    ClearPedTasks(ped)
                                    DetachEntity(pickaxe, 1, true)
                                    DeleteEntity(pickaxe)
                                    DeleteObject(pickaxe)
                                         local luck = math.random(1, 250)
                                if luck < 40 then
                                    TriggerServerEvent("mx-jobs:takeitem", "diamond", 1, false)
                                elseif luck > 50 and luck < 100 then
                                    TriggerServerEvent("mx-jobs:takeitem", "gold", 1, false)
                                elseif luck > 150 and luck < 220 then
                                    TriggerServerEvent("mx-jobs:takeitem", "iron", 1, false)
                                else
                                    ESX.ShowNotification("Herhangi birşey çıkaramadın !")
                                end
                                end
                            end)
                        end
                    end
                end
            end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == "kasap" then
                for i = 1, #kasap, 1 do
                    local pedcoord = GetEntityCoords(ped)
                    local dst = GetDistanceBetweenCoords(pedcoord, kasap[i].clc.x, kasap[i].clc.y, kasap[i].clc.z, false)
                    if dst <= 8 then
                        DrawText3DMX(kasap[i].clc.x, kasap[i].clc.y, kasap[i].clc.z, "Kesilmis Et Almak Için ~r~E~s~ Bas")
                        performans = false
                    end
                    if dst <= 3 then
                    if IsControlJustPressed(0, Keys["E"]) and not anim then
                        anim = true
                        eatprop = CreateObject(GetHashKey('prop_cs_steak'),pedcoord.x, pedcoord.y,pedcoord.z, true, true, true)
                        AttachEntityToEntity(eatprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                        karton = CreateObject(GetHashKey('prop_cs_clothes_box'),pedcoord.x, pedcoord.y,pedcoord.z, true, true, true)
                        AttachEntityToEntity(karton, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
                        LoadDict("anim@heists@ornate_bank@grab_cash_heels")
                        TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
                        FreezeEntityPosition(PlayerPedId(), true)
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "Tavuk",
                            duration = 10000,
                            label = "Kesilmiş Etleri Topluyorsun",
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = "",
                                anim = "",
                            },
                            prop = {
                                model = "",
                            }
                        }, function(status)
                            if not status then
                                TriggerServerEvent("mx-jobs:takeitem", "tavuk", 1, false)
                                ClearPedTasks(ped)
                                DeleteEntity(karton)
                                DeleteEntity(eatprop)
                                FreezeEntityPosition(ped, false)
                                anim = false
                            end
                        end)

                        end
                    end
                end
            end
        if not performans then
            sleep = 3
        end

        if performans then
            sleep = 1000
        end
    end
end)

-- İşleme
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(sleep)
        local performans = true
        local ped = PlayerPedId()

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "terzi" then
            for i = 1, #terzi, 1 do
                local pedpos = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedpos, terzi[i].prsn.x, terzi[i].prsn.y, terzi[i].prsn.z, true)
                if dst <= 10 then
                DrawText3DMX(terzi[i].prsn.x, terzi[i].prsn.y, terzi[i].prsn.z, "Kuması Islemek Icın  ~r~[E] ~s~ Bas")
                performans = false
                end
                if IsControlJustPressed(0, Keys["E"]) and dst <= 2 then
                    ESX.TriggerServerCallback("mx-jobs:giveable", function(giveable)
                        if giveable then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "terziisleme",
                        duration = 10000,
                        label = "Kumaşlardan Kıyafet Yapıyorsun",
                        useWhileDead = false,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "amb@prop_human_bum_bin@base",
                            anim = "base",
                        },
                        prop = {
                            model = "",
                        }
                    }, function(status)
                        if not status then
                            TriggerServerEvent("mx-jobs:takeitem", terzi[i].sellitem, 1, true, terzi[i].clcitem, terzi[i].AmountRequired)
                            ClearPedTasks(ped)
                        end
                    end)
                end
                end, terzi[i].clcitem, terzi[i].AmountRequired, terzi[i].limit)
                end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "kasap" then
            for i = 1, #terzi, 1 do
                local pedpos = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedpos, kasap[i].prsn.x, kasap[i].prsn.y, kasap[i].prsn.z, false)
                if dst <= 10 then
                    DrawText3DMX(kasap[i].prsn.x, kasap[i].prsn.y, kasap[i].prsn.z, "Pisirmek Için Bas ~r~[E]~s~")
                    performans = false
                end
                if IsControlJustPressed(0, Keys["E"]) and dst <= 2 then
                    ESX.TriggerServerCallback("mx-jobs:giveable", function(giveable)
                        if giveable then
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "tisleme",
                            duration = 10000,
                            label = "Tavukları İşliyorsun",
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = "missheistdockssetup1clipboard@idle_a",
                                anim = "idle_a",
                            },
                            prop = {
                                model = "",
                            }
                        }, function(status)
                            if not status then
                                TriggerServerEvent("mx-jobs:takeitem", kasap[i].sellitem, 1, true, kasap[i].clcitem, kasap[i].AmountRequired)
                                ClearPedTasks(ped)
                                
                            end
                        end)
                        end
                     end, kasap[i].clcitem, kasap[i].AmountRequired, kasap[i].limit)
                    end
            end
        end

        if performans then
            sleep = 1000
        end

        if not performans then
            sleep = 5
        end
    end
end)


Citizen.CreateThread(function()
while carspawnstatus == 1 do
        Citizen.Wait( 2 * 60000) -- 2 dakikada bir
        carspawnstatus = 0
    end
end)

-- Araç Spawnlama
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(sleep)
    local performans = true
    local ped = PlayerPedId()

    if ESX.PlayerData.job and ESX.PlayerData.job.name == "terzi" then
        for i = 1, #terzi, 1 do
            local pedcoord = GetEntityCoords(ped)
            local dst = GetDistanceBetweenCoords(pedcoord, terzi[i].vehspawnmarker.x, terzi[i].vehspawnmarker.y, terzi[i].vehspawnmarker.z, false)
            if dst <= 10 then
                DrawMarker(2, terzi[i].vehspawnmarker.x, terzi[i].vehspawnmarker.y, terzi[i].vehspawnmarker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                performans = false
            end
            if dst <= 2 then
                ESX.ShowHelpNotification("İş Arabası Almak İçin [E] Tuşuna Bas")
                if IsControlJustPressed(0, Keys["E"]) and carspawnstatus == 0 then
                    local s = terzi[i].vehspawnprice
                        ESX.TriggerServerCallback("mx-jobs:getmoney", function(cbmoney)
                            if cbmoney then
                                TriggerServerEvent("mx-jobs:takemoney", s)
                                ESX.Game.SpawnVehicle("youga", vector3(terzi[i].vehspawn.x, terzi[i].vehspawn.y, terzi[i].vehspawn.z), terzi[i].vehspawn.h, function(nnn)
                                    TaskWarpPedIntoVehicle(ped, nnn, -1)
                                    SetVehicleNumberPlateText(nnn ,"jobcar")
                                end)
                                -- spawnveh("youga", function(test)
                                --     TaskWarpPedIntoVehicle(ped, test, -1)
                                -- end,terzi[i].vehspawn.x, terzi[i].vehspawn.y, terzi[i].vehspawn.z, terzi[i].vehspawn.h)
                                
                                ESX.ShowNotification("İş Arabası Alındı")
                                carspawnstatus = 1
                            else
                                ESX.ShowNotification('Yeterli Paranız Yok İhtiyacınız Olan Para\n '..s)
                            end
                        end, s)  
                    end
                end
        end
    end

    if ESX.PlayerData.job and ESX.PlayerData.job.name == "maden" then
        for i = 1, #maden, 1 do
            local pedcoord = GetEntityCoords(ped)
            local dst = GetDistanceBetweenCoords(pedcoord, maden[i].vehspawnmarker.x, maden[i].vehspawnmarker.y, maden[i].vehspawnmarker.z, false)
            if dst <= 10 then
                DrawMarker(2, maden[i].vehspawnmarker.x, maden[i].vehspawnmarker.y, maden[i].vehspawnmarker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                performans = false
            end
            if dst <= 2 then
                ESX.ShowHelpNotification("İş Arabası Almak İçin [E] Tuşuna Bas")
        if IsControlJustPressed(0, Keys["E"]) and carspawnstatus == 0 then
            local s = maden[i].vehspawnprice
                ESX.TriggerServerCallback("mx-jobs:getmoney", function(cbmoney)
                    if cbmoney then
                        TriggerServerEvent("mx-jobs:takemoney", s)
                        ESX.Game.SpawnVehicle("youga", vector3(maden[i].vehspawn.x, maden[i].vehspawn.y, maden[i].vehspawn.z), maden[i].vehspawn.h, function(nnn)
                            TaskWarpPedIntoVehicle(ped, nnn, -1)
                            SetVehicleNumberPlateText(nnn ,"jobcar")
                        end)
                        ESX.ShowNotification("İş Arabası Alındı")
                        carspawnstatus = 1
                    else
                        ESX.ShowNotification('Yeterli Paranız Yok İhtiyacınız Olan Para\n '..s)
                    end
                end, s)  
            end
        end
        end
    end

    if ESX.PlayerData.job and ESX.PlayerData.job.name == "kasap" then
        for i = 1, #kasap, 1 do
            local pedcoord = GetEntityCoords(ped)
            local dst = GetDistanceBetweenCoords(pedcoord, kasap[i].vehspawnmarker.x, kasap[i].vehspawnmarker.y, kasap[i].vehspawnmarker.z, false)
            if dst <= 10 then
                DrawMarker(2, kasap[i].vehspawnmarker.x, kasap[i].vehspawnmarker.y, kasap[i].vehspawnmarker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                performans = false
            end
            if dst <= 2 then
                ESX.ShowHelpNotification("İş Arabası Almak İçin [E] Tuşuna Bas")
            if IsControlJustPressed(0, Keys["E"]) and carspawnstatus == 0 then
                local s = kasap[i].vehspawnprice
                    ESX.TriggerServerCallback("mx-jobs:getmoney", function(cbmoney)
                        if cbmoney then
                            TriggerServerEvent("mx-jobs:takemoney", s)
                            ESX.Game.SpawnVehicle("youga", vector3(kasap[i].vehspawn.x, kasap[i].vehspawn.y, kasap[i].vehspawn.z), kasap[i].vehspawn.h, function(nnn)
                                TaskWarpPedIntoVehicle(ped, nnn, -1)
                                SetVehicleNumberPlateText(nnn ,"jobcar")
                            end)
                            
                            ESX.ShowNotification("İş Arabası Alındı")
                            carspawnstatus = 1
                        else
                            ESX.ShowNotification('Yeterli Paranız Yok İhtiyacınız Olan Para\n '..s)
                        end
                    end, s)  
                end
            end
        end
    end
      
        if performans then
            sleep = 1000
        end

        if not performans then
            sleep = 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(sleep)
        local performans = true
        local ped = PlayerPedId()

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "terzi" then
            for i = 1, #terzi, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords, terzi[i].vehdel.x, terzi[i].vehdel.y, terzi[i].vehdel.z, false)
                local vehped = GetVehiclePedIsIn(ped, false)
                if dst <= 8 then
                    DrawMarker(2, terzi[i].vehdel.x, terzi[i].vehdel.y, terzi[i].vehdel.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                    performans = false
                end
                if dst <= 2 then
                    local pedveh = GetVehiclePedIsIn(ped, false)
                    ESX.ShowHelpNotification("Araç Silmek İçin [E] Tuşuna Bas")
                    if IsControlJustPressed(0, Keys["E"]) then
                        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(pedveh))
                        if plate == "JOBCAR" then
                         DeleteVehicle(vehped)
                         carspawnstatus = 0
                        else
                            ESX.ShowNotification("Bu Araç Iş Aracı Değil !")
                        end
                end
            end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "maden" then
            for i = 1, #maden, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords, maden[i].vehdel.x, maden[i].vehdel.y, maden[i].vehdel.z, false)
                local vehped = GetVehiclePedIsIn(ped, false)
                if dst <= 8 then
                    DrawMarker(2, maden[i].vehdel.x, maden[i].vehdel.y, maden[i].vehdel.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                    performans = false
                end
                if dst <= 2 then
                    local pedveh = GetVehiclePedIsIn(ped, false)
                    ESX.ShowHelpNotification("Araç Silmek İçin [E] Tuşuna Bas")
                    if IsControlJustPressed(0, Keys["E"]) then
                        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(pedveh))
                        if plate == "JOBCAR" then
                         DeleteVehicle(vehped)
                         carspawnstatus = 0
                        else
                            ESX.ShowNotification("Bu Araç Iş Aracı Değil !")
                        end
                    end
                end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "kasap" then
            for i = 1, #kasap, 1 do
                local pedcoords = GetEntityCoords(ped)
                local dst = GetDistanceBetweenCoords(pedcoords, kasap[i].vehdel.x, kasap[i].vehdel.y, kasap[i].vehdel.z, false)
                local vehped = GetVehiclePedIsIn(ped, false)
                if dst <= 8 then
                    DrawMarker(2, kasap[i].vehdel.x, kasap[i].vehdel.y, kasap[i].vehdel.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                    performans = false
                end
                if dst <= 2 then
                    local pedveh = GetVehiclePedIsIn(ped, false)
                    ESX.ShowHelpNotification("Araç Silmek İçin [E] Tuşuna Bas")
                    if IsControlJustPressed(0, Keys["E"]) then
                        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(pedveh))
                        if plate == "JOBCAR" then
                         DeleteVehicle(vehped)
                         carspawnstatus = 0
                        else
                            ESX.ShowNotification("Bu Araç Iş Aracı Değil !")
                        end
                end
            end
            end
        end

        if performans then
            sleep = 1000
        end

        if not performans then
            sleep = 5
        end
    end
end)

if Cfg.npc then
Citizen.CreateThread(function()
    for k,v in pairs(Cfg.peds) do
        RequestModel(v.ped)
        while not HasModelLoaded(v.ped) do
            Wait(1)
        end

        local seller = CreatePed(1, v.ped, v.x, v.y, v.z - 1, v.h, false, true)
        SetBlockingOfNonTemporaryEvents(seller, true)
        SetPedDiesWhenInjured(seller, false)
        SetPedCanPlayAmbientAnims(seller, true)
        SetPedCanRagdollFromPlayerImpact(seller, false)
        SetEntityInvincible(seller, true)
        FreezeEntityPosition(seller, true)
    end
end)
end


local poragaclar = {
    { ['x'] = 2316.86,  ['y'] = 4993.01,  ['z'] = 42.03},
    { ['x'] = 2305.81,  ['y'] = 4996.95,  ['z'] = 42.29},
    { ['x'] = 2316.38,  ['y'] = 5008.47,  ['z'] = 42.53},
    { ['x'] = 2316.66,  ['y'] = 5022.98,  ['z'] = 43.28},
}
local uzumyeris = {
    { ['x'] = 1921.62,  ['y'] = 4803.87,  ['z'] = 44.23},
    { ['x'] = 1918.89,  ['y'] = 4807.36,  ['z'] = 44.46},
    { ['x'] = 1894.29,  ['y'] = 4830.92,  ['z'] = 46.06}
}


-- Yan Meslekler Tekrar yazılıcak...

Citizen.CreateThread(function()
  
    while true do
	local ped = PlayerPedId()
        for i = 1, #portakal, 1 do
        for j = 1, #poragaclar, 1 do
        sleep = 0
        local pedcoords = GetEntityCoords(ped)
        local dst = GetDistanceBetweenCoords(pedcoords, poragaclar[j].x, poragaclar[j].y, poragaclar[j].z, true)
        if dst >= 60 then
            sleep = 300
        end
        if dst <= 10 then
            DrawText3DMX(poragaclar[j].x, poragaclar[j].y, poragaclar[j].z, "Portakal Toplamak Icin ~r~E~s~ Bas")
        end
            if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                TriggerEvent("mythic_progbar:client:progress", {
                                            name = "Portakal Toplama",
                                            duration = 10000,
                                            label = "Portakal Topluyorsun",
                                            useWhileDead = false,
                                            canCancel = false,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            },
                                            animation = {
                                                animDict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                                                anim = "high_center_up",
                                            },
                                            prop = {
                                                model = "",
                                            }
                                        }, function(status)
                                            if not status then
                                                ClearPedTasks(ped)
                                                TriggerServerEvent("mx-jobs:takeitem", portakal[i].clcitem, 1, false)
                                            end
                                        end)
            end
            end
        end
        Citizen.Wait(sleep)    
    end
end)

Citizen.CreateThread(function()
while true do
local ped = PlayerPedId()
    sleep = 0
    for i = 1, #uzum, 1 do
        for j = 1, #uzumyeris, 1 do
        sleep = 0
        local pedcoords = GetEntityCoords(ped)
        local dst = GetDistanceBetweenCoords(pedcoords, uzumyeris[j].x, uzumyeris[j].y, uzumyeris[j].z, true)
        if dst >= 60 then
            sleep = 300
        end
        if dst <= 10 then
            DrawText3DMX(uzumyeris[j].x, uzumyeris[j].y, uzumyeris[j].z, "Uzum Toplamak Icın ~r~E~s~ Bas")
        end
            if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
                TriggerEvent("mythic_progbar:client:progress", {
                                            name = "Uzuum Toplama",
                                            duration = 10000,
                                            label = "Uzum Topluyorsun",
                                            useWhileDead = false,
                                            canCancel = false,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            },
                                            animation = {
                                                animDict = "amb@prop_human_bum_bin@base",
                                                anim = "base",
                                            },
                                            prop = {
                                                model = "",
                                            }
                                        }, function(status)
                                            if not status then
                                                ClearPedTasks(ped)
                                                TriggerServerEvent("mx-jobs:takeitem", uzum[i].clcitem, 1, false)
                                            end
                                        end)
            end
            end
        end
    Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function()
    while true do
 local ped = PlayerPedId()
        for i = 1, #portakal, 1 do
        sleep = 0
        local pedcoords = GetEntityCoords(ped)
        local dst = GetDistanceBetweenCoords(pedcoords, portakal[i].prsn.x, portakal[i].prsn.y, portakal[i].prsn.z, true)
        if dst >= 60 then
            sleep = 300
        end
        if dst <= 8 then
            DrawText3DMX(portakal[i].prsn.x, portakal[i].prsn.y, portakal[i].prsn.z, "Portakal Islemek Icin ~y~E~s~ Bas")
        end
        if IsControlJustPressed(0, Keys["E"]) and dst <= 2 then
            TriggerEvent("mythic_progbar:client:progress", {
                name = "islemes",
                duration = 10000,
                label = "Portakalları İşliyorsun",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "missheistdockssetup1clipboard@idle_a",
                    anim = "idle_a",
                },
                prop = {
                    model = "",
                }
            }, function(status)
                if not status then
                    ClearPedTasks(ped)
                    TriggerServerEvent("mx-jobs:takeitem", portakal[i].sellitem, 1, true, portakal[i].clcitem, portakal[i].AmountRequired)
                end
            end)
        end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        sleep = 0
        for i = 1, #uzum, 1 do
            local pedcoords = GetEntityCoords(ped)
            local dst = GetDistanceBetweenCoords(pedcoords, uzum[i].prsn.x, uzum[i].prsn.y, uzum[i].prsn.z, true)
            if dst >= 60 then
                sleep = 300
            end
            if dst <= 8 then
                DrawText3DMX(uzum[i].prsn.x, uzum[i].prsn.y, uzum[i].prsn.z, "Uzum Islemek Icin ~y~E~s~ Bas")
            end
            if IsControlJustPressed(0, Keys["E"]) and dst <= 2 then
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "islemes",
                    duration = 10000,
                    label = "Uzumleri İşliyorsun",
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard@idle_a",
                        anim = "idle_a",
                    },
                    prop = {
                        model = "",
                    }
                }, function(status)
                    if not status then
                        ClearPedTasks(ped)
                        TriggerServerEvent("mx-jobs:takeitem", uzum[i].sellitem, 1, true, uzum[i].clcitem, uzum[i].AmountRequired)
                    end
                end)
            end
        end
        Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        for i = 1, #portakal, 1 do
        sleep = 0
        local pedcoords = GetEntityCoords(ped)
        local dst = GetDistanceBetweenCoords(pedcoords, portakal[i].sell.x, portakal[i].sell.y, portakal[i].sell.z, true)
        if dst >= 80 then
           sleep = 200 
        end
        if dst <= 8 then
            DrawText3DMX(portakal[i].sell.x, portakal[i].sell.y, portakal[i].sell.z, "Portakalları Satmak Icin ~y~E~s~ Bas")
        end
        if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
            ESX.TriggerServerCallback("mx-jobs:selling", function(count, adet)
                if count then
                ESX.ShowNotification("" .. adet .. " Portakal Suyunu Şukadara [" .. count .. "] Sattın.")
                else
                    ESX.ShowNotification("üstünde yeterli sayıda Portakal yok")
                end
            end, portakal[i].sellitem, portakal[i].price)
        end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
local ped = PlayerPedId()
    sleep = 0
    for i = 1, #uzum, 1 do
        sleep = 0
        local pedcoords = GetEntityCoords(ped)
        local dst = GetDistanceBetweenCoords(pedcoords, uzum[i].sell.x, uzum[i].sell.y, uzum[i].sell.z, true)
        if dst >= 80 then
           sleep = 200 
        end
        if dst <= 8 then
            DrawText3DMX(uzum[i].sell.x, uzum[i].sell.y, uzum[i].sell.z, "Şaraplari Satmak Icin ~y~E~s~ Bas")
        end
        if IsControlJustPressed(0, Keys["E"]) and dst <= 3 then
            ESX.TriggerServerCallback("mx-jobs:selling", function(count, adet)
                if count then
                ESX.ShowNotification("" .. adet .. " Şarabı Şukadara [" .. count .. "] Sattın.")
                else
                    ESX.ShowNotification("üstünde yeterli sayıda Şarap yok")
                end
            end, uzum[i].sellitem, uzum[i].price)
        end
        end
    Citizen.Wait(sleep)
    end
end)

-- Citizen.CreateThread(function()
-- local ped = PlayerPedId()
--     for i = 1, #portakal, 1 do
--         while true do
--             sleep = 0
--         local pedcoords = GetEntityCoords(ped)
--         local dst = GetDistanceBetweenCoords(pedcoords, portakal[i].clc.x, portakal[i].clc.y, portakal[i].clc.z, false)
--         if dst <= 10 then
--             DrawText3DMX(portakal[i].clc.x, portakal[i].clc.y, portakal[i].clc.z, "Portakal Toplama", 0.40)
--         else
--             sleep = 200
--         end
--             if dst <= 2 then
--                 DrawText3DMX(portakal[i].clc.x, portakal[i].clc.y, portakal[i].clc.z, "Portakal Toplamak Icın [E] Bas", 0.40)
--                 if IsControlJustPressed(0, Keys["E"]) then
--                     TriggerEvent("mythic_progbar:client:progress", {
--                         name = "Portakal Toplama",
--                         duration = 10000,
--                         label = "Portakal Topluyorsun",
--                         useWhileDead = false,
--                         canCancel = false,
--                         controlDisables = {
--                             disableMovement = true,
--                             disableCarMovement = true,
--                             disableMouse = false,
--                             disableCombat = true,
--                         },
--                         animation = {
--                             animDict = "missheistdockssetup1clipboard@idle_a",
--                             anim = "idle_a",
--                         },
--                         prop = {
--                             model = "",
--                         }
--                     }, function(status)
--                         if not status then
--                             -- Do Something If Event Wasn't Cancelled
--                         end
--                     end)
--                     TriggerServerEvent("mx-jobs:takeitem", "portakal", 1, false)
--             end
--         end
--             Citizen.Wait(sleep)
--         end
--     end
-- end)


-- Citizen.CreateThread(function()
--     local ped = PlayerPedId()
--     for i = 1, #uzum, 1 do
--         while true do
--             sleep = 0
--         local pedcoords = GetEntityCoords(ped)
--         local dst = GetDistanceBetweenCoords(pedcoords)
--         if dst <= 10 then
--             DrawText3DMX(uzum[i].prsn.x, uzum[i].prsn.y, uzum[i].prsn.z, "Portakal Isleme Yeri", 0.40)
--         else
--             sleep = 200
--         end
--         if dst <= 3 then
--         DrawText3DMX(uzum[i].prsn.x, uzum[i].prsn.y, uzum[i].prsn.z, "Portakal Islemek Icin [E] Basın", 0.40)
--         if IsControlJustPressed(0, Keys["E"]) then
--             TriggerEvent("mythic_progbar:client:progress", {
--                 name = "uzumIsleme",
--                 duration = 10000,
--                 label = "Uzum Islenıyor",
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--                 animation = {
--                     animDict = "missheistdockssetup1clipboard@idle_a",
--                     anim = "idle_a",
--                 },
--                 prop = {
--                     model = "",
--                 }
--             }, function(status)
--                 if not status then
--                     -- Do Something If Event Wasn't Cancelled
--                 end
--             end)
--             TriggerServerEvent("mx-jobs:takeitem", "sarap", 1, true, "uzum")
--         end
--     end
--     Citizen.Wait(sleep)
-- end
-- end
--     for i = 1, #portakal, 1 do
--         while true do
--             sleep = 0
--         local pedcoords = GetEntityCoords(ped)
--         local dst = GetDistanceBetweenCoords(pedcoords)
--         if dst <= 10 then
--             DrawText3DMX(portakal[i].prsn.x, portakal[i].prsn.y, portakal[i].prsn.z, "Portakal Isleme Yeri", 0.40)
--         else
--             sleep = 200
--         end
--         if dst <= 3 then
--         DrawText3DMX(portakal[i].prsn.x, portakal[i].prsn.y, portakal[i].prsn.z, "Portakal Islemek Icin [E] Basın", 0.40)
--         if IsControlJustPressed(0, Keys["E"]) then
--             TriggerEvent("mythic_progbar:client:progress", {
--                 name = "PortakalIsleme",
--                 duration = 10000,
--                 label = "Portakal İşleniyor",
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--                 animation = {
--                     animDict = "missheistdockssetup1clipboard@idle_a",
--                     anim = "idle_a",
--                 },
--                 prop = {
--                     model = "",
--                 }
--             }, function(status)
--                 if not status then
--                     -- Do Something If Event Wasn't Cancelled
--                 end
--             end)
--             TriggerServerEvent("mx-jobs:takeitem", "portakalsuyu", 1, true, "portakal")
--         end
--     end
--     Citizen.Wait(sleep)
-- end
--     end
-- end)

Citizen.CreateThreadNow(function()
    Citizen.Wait(100)
CreateBlip()
CreateBlipCo()
end)

function CreateBlipCo() 
        for i = 1, #uzum, 1 do
            local a = AddBlipForCoord(uzum[i].blipcoords)
            SetBlipSprite(a, uzum[i].blipsprite)
            SetBlipColour(a, uzum[i].blipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(uzum[i].blipname)
            EndTextCommandSetBlipName(a)
            SetBlipAsShortRange(a, true)

            local b = AddBlipForCoord(uzum[i].clcblipcoords)
            SetBlipSprite(b, uzum[i].clcblipsprite)
            SetBlipColour(b, uzum[i].clcblipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(uzum[i].clcblipname)
            EndTextCommandSetBlipName(b)
            SetBlipAsShortRange(b, true)

            local c = AddBlipForCoord(uzum[i].sellblipcoords)
            SetBlipSprite(c, uzum[i].sellblipcoordsblipsprite)
            SetBlipColour(c, uzum[i].sellblipcoordsblipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(uzum[i].sellblipcoordsblipname)
            EndTextCommandSetBlipName(c)
            SetBlipAsShortRange(c, true)
    end

    for i = 1, #portakal, 1 do
        local d = AddBlipForCoord(portakal[i].blipcoords)
            SetBlipSprite(d, portakal[i].blipsprite)
            SetBlipColour(d, portakal[i].blipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(portakal[i].blipname)
            EndTextCommandSetBlipName(d)
            SetBlipAsShortRange(d, true)

            local e = AddBlipForCoord(portakal[i].clcblipcoords)
            SetBlipSprite(e, portakal[i].clcblipsprite)
            SetBlipColour(e, portakal[i].clcblipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(portakal[i].clcblipname)
            EndTextCommandSetBlipName(e)
            SetBlipAsShortRange(e, true)

            local f = AddBlipForCoord(portakal[i].sellblipcoords)
            SetBlipSprite(f, portakal[i].sellblipcoordsblipsprite)
            SetBlipColour(f, portakal[i].sellblipcoordsblipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(portakal[i].sellblipcoordsblipname)
            EndTextCommandSetBlipName(f)
            SetBlipAsShortRange(f, true)
    end
end

blips = {}

function refresh()
    for _,v in pairs(blips) do
        RemoveBlip(v)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
       refresh() 
       CreateBlip()
    end
end)

function CreateBlip() 
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "terzi" then
            for i = 1, #terzi, 1 do
                local a = AddBlipForCoord(terzi[i].blipcoords)
                SetBlipSprite(a, terzi[i].blipsprite)
                SetBlipColour(a, terzi[i].blipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(terzi[i].blipname)
                EndTextCommandSetBlipName(a)
                SetBlipAsShortRange(a, true)
    
                local b = AddBlipForCoord(terzi[i].clcblipcoords)
                SetBlipSprite(b, terzi[i].clcblipsprite)
                SetBlipColour(b, terzi[i].clcblipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(terzi[i].clcblipname)
                EndTextCommandSetBlipName(b)
                SetBlipAsShortRange(b, true)
    
                local c = AddBlipForCoord(terzi[i].sellblipcoords)
                SetBlipSprite(c, terzi[i].sellblipcoordsblipsprite)
                SetBlipColour(c, terzi[i].sellblipcoordsblipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(terzi[i].sellblipcoordsblipname)
                EndTextCommandSetBlipName(c)
                SetBlipAsShortRange(c, true)
                table.insert(blips, a)
                table.insert(blips, b)
                table.insert(blips, c)
        end
        elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "maden" then
            for i = 1, #maden, 1 do

            local a = AddBlipForCoord(maden[i].blipcoords)
            SetBlipSprite(a, maden[i].blipsprite)
            SetBlipColour(a, maden[i].blipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(maden[i].blipname)
            EndTextCommandSetBlipName(a)
            SetBlipAsShortRange(a, true)

            -- local b = AddBlipForCoord(maden[i].clcblipcoords) -- Toplama yeri deaktif.
            -- SetBlipSprite(b, maden[i].clcblipsprite)
            -- SetBlipColour(b, maden[i].clcblipcolor)
            -- BeginTextCommandSetBlipName("STRING")
            -- AddTextComponentString(maden[i].clcblipname)
            -- EndTextCommandSetBlipName(b)
            -- SetBlipAsShortRange(b, true)

            local c = AddBlipForCoord(maden[i].sellblipcoords)
            SetBlipSprite(c, maden[i].sellblipcoordsblipsprite)
            SetBlipColour(c, maden[i].sellblipcoordsblipcolor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(maden[i].sellblipcoordsblipname)
            EndTextCommandSetBlipName(c)
            SetBlipAsShortRange(c, true)
            table.insert(blips, a)
            table.insert(blips, b)
            table.insert(blips, c)
        end
        elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "kasap" then
            for i = 1, #kasap, 1 do
                local a = AddBlipForCoord(kasap[i].blipcoords)
                SetBlipSprite(a, kasap[i].blipsprite)
                SetBlipColour(a, kasap[i].blipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(kasap[i].blipname)
                EndTextCommandSetBlipName(a)
                SetBlipAsShortRange(a, true)
    
                local b = AddBlipForCoord(kasap[i].clcblipcoords)
                SetBlipSprite(b, kasap[i].clcblipsprite)
                SetBlipColour(b, kasap[i].clcblipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(kasap[i].clcblipname)
                EndTextCommandSetBlipName(b)
                SetBlipAsShortRange(b, true)
    
                local c = AddBlipForCoord(kasap[i].sellblipcoords)
                SetBlipSprite(c, kasap[i].sellblipcoordsblipsprite)
                SetBlipColour(c, kasap[i].sellblipcoordsblipcolor)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(kasap[i].sellblipcoordsblipname)
                EndTextCommandSetBlipName(c)
                SetBlipAsShortRange(c, true)
                table.insert(blips, a)
                table.insert(blips, b)
                table.insert(blips, c)
        end
    end
end

-- Thanks NeQYT
function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("melee@large_wpn@streamed_core")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                        local luck = math.random(1, 250)
                            if luck < 40 then
                                TriggerServerEvent("mx-jobs:takeitem", maden[i].diamondname, 1, false)
                            elseif luck > 50 and luck < 100 then
                                TriggerServerEvent("mx-jobs:takeitem", maden[i].goldname, 1, false)
                            elseif luck > 150 and luck < 220 then
                                TriggerServerEvent("mx-jobs:takeitem", maden[i].ironname, 1, false)
                        end
                    break
                end        
        end
    end)
end


function DrawText3DMX(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

