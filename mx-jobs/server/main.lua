ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
    ESX = library 
end)

-- ESX.RegisterServerCallback("mx-jobs:giveable", function(source, cb, ItemName, cnt)
-- local xPlayer = ESX.GetPlayerFromId(source)
-- local xItem = xPlayer.getInventoryItem(ItemName)
--     if Cfg.limit then
--         if xItem.count >= cnt then
--             cb(true)
--         else
--             xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok ! "..ItemName.. " Gerekli Olan Sayı : " ..cnt)
--             cb(false)
--         end
--     else
--         if xItem.count <= limit then
--             if xItem.count >= cnt then
--                 cb(true)
--             else
--                 xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok ! "..ItemName.. " Gerekli Olan Sayı : " ..cnt)
--                 cb(false)
--             end
--         else
--             xPlayer.showNotification("Bu Eşyadan Daha fazla Alamazsınız ! "..ItemName)
--                 cb(false)
--         end
--     end
-- end)
ESX.RegisterServerCallback("mx-jobs:giveable", function(source, cb, ItemName, cnt, limit)
local xPlayer = ESX.GetPlayerFromId(source)
local xItem = xPlayer.getInventoryItem(ItemName)
    if Cfg.limit then
        if xItem.count <= limit then
            if xItem.count >= cnt then
                cb(true)
            else
                xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok ! "..ItemName.. " Gerekli Olan Sayı : " ..cnt)
                cb(false)
            end
        else
            xPlayer.showNotification("Bu Eşyadan Daha fazla Alamazsınız ! "..ItemName)
                cb(false)
        end
    else
        if xItem.count >= cnt then
            cb(true)
        else
            xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok ! "..ItemName.. " Gerekli Olan Sayı : " ..cnt)
            cb(false)
        end
    end
end)


RegisterServerEvent("mx-jobs:takeitem")
AddEventHandler("mx-jobs:takeitem", function(ItemName, count, itemsil, olditem, olditemcount)
    local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local xItem = xPlayer.getInventoryItem(olditem)

if itemsil == true then
    if xPlayer.canCarryItem(ItemName, count) then
        if xItem.count >= olditemcount then
        xPlayer.removeInventoryItem(olditem, olditemcount)
        xPlayer.addInventoryItem(ItemName, count) 
        else
            xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok\n"..olditem.. "Üstünüzde Olması Gereken "..olditemcount)
        end
    else
        xPlayer.showNotification("Bu eşyayı üstünüze alamazsınız.\n"..ItemName)
    end
end

if itemsil == false then
    if xPlayer.canCarryItem(ItemName, count) then
        xPlayer.addInventoryItem(ItemName, count) 
    else
        xPlayer.showNotification("Bu Eşyayı Taşıyamazsınız : "..ItemName)
    end
end
end)

ESX.RegisterServerCallback("mx-jobs:getmoney", function(source, cb, requestmoney)
local xPlayer = ESX.GetPlayerFromId(source)
local xMoney = xPlayer.getMoney()
    if xMoney >= requestmoney then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("mx-jobs:takemoney")
AddEventHandler("mx-jobs:takemoney", function(takemoneyprice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.removeMoney(takemoneyprice)
end)

RegisterServerEvent("mx-jobs:sellingformaden")
AddEventHandler("mx-jobs:sellingformaden", function (itemName, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xItem = xPlayer.getInventoryItem(itemName)
    if xItem.count > 0 then
        xPlayer.addMoney(xItem.count * price)
        xPlayer.removeInventoryItem(xItem.name, xItem.count)
        xPlayer.showNotification("Şu Eşyayı Satarak [" ..xItem.name.. "] Şukadar Para Kazandın "..xItem.count * price)
    else
        xPlayer.showNotification("Üstünde Yeterli Sayıda ["..xItem.name.."] Yok")
    end
end)

ESX.RegisterServerCallback("mx-jobs:selling", function (source, cb, item, itemPrice)
    -- Thanks James Fishing
    local xPlayer = ESX.GetPlayerFromId(source)

    local xItem = xPlayer.getInventoryItem(item)

    if xItem.count > 0 then 
        xPlayer.addMoney(xItem.count * itemPrice)
        xPlayer.removeInventoryItem(item, xItem.count)
        cb(xItem.count * itemPrice, xItem.count)
    else
        cb(false)
    end
end)


