ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
    ESX = library 
end)

RegisterServerEvent("mx-jobs:takeitem")
AddEventHandler("mx-jobs:takeitem", function(ItemName, count, removeItem, olditem, olditemcount)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local xItem = xPlayer.getInventoryItem(olditem)

if removeItem == true then
    if xPlayer.canCarryItem(ItemName, count) then
        if xItem.count >= olditemcount then
        xPlayer.removeInventoryItem(olditem, olditemcount)
        xPlayer.addInventoryItem(ItemName, count) 
        else
            xPlayer.showNotification("Bu Eşyadan Üstünüzde Yeterli Sayıda Yok [" ..string.upper(olditem).. "] üstünüzde Olması Gereken "..olditemcount)
        end
    else
        xPlayer.showNotification("Bu eşyayı üstünüze alamazsınız. "..ItemName)
    end
end

if removeItem == false then
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

RegisterServerEvent('mx-jobs:selling')
AddEventHandler('mx-jobs:selling', function(itemName, itemPrice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xItem = xPlayer.getInventoryItem(itemName)
    if xItem.count > 0 then
        xPlayer.addMoney(xItem.count * itemPrice)
        xPlayer.removeInventoryItem(itemName, xItem.count)
        xPlayer.showNotification("Şu Eşyayı Satarak [" ..string.upper(xItem.name).. "] Şukadar Para Kazandın "..xItem.count * itemPrice)
        TriggerClientEvent('textstatus', source, true)
    else
        xPlayer.showNotification("Üstünde Yeterli Sayıda ["..string.upper(xItem.name).."] Yok")
        TriggerClientEvent('textstatus', source, true)
    end
end)