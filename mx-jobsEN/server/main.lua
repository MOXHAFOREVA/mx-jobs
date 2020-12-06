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
            xPlayer.showNotification("You Don't Have Enough of This Item [" ..string.upper(olditem).. "] The number that should be above you "..olditemcount)
        end
    else
        xPlayer.showNotification("The item is too heavy. "..ItemName)
    end
end

if removeItem == false then
        if xPlayer.canCarryItem(ItemName, count) then
            xPlayer.addInventoryItem(ItemName, count) 
        else
            xPlayer.showNotification("The item is too heavy : "..ItemName)
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
AddEventHandler('mx-jobs:selling', function(itemName, itemPrice, types)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xItem = xPlayer.getInventoryItem(itemName)
    local amounts = xItem.count * itemPrice
    if xItem.count > 0 then
        if checkLimit(src, types, amounts) == true then
        xPlayer.addMoney(xItem.count * itemPrice)
        xPlayer.removeInventoryItem(itemName, xItem.count)
        xPlayer.showNotification("Selling That Item [" ..string.upper(xItem.name).. "] You Have Made Money "..xItem.count * itemPrice)
        TriggerClientEvent('textstatus', src, true)
        elseif checkLimit(src, types, amounts) == false then
            xPlayer.showNotification("Your daily limit is over")
            TriggerClientEvent('textstatus', src, true)
        end
    else
        xPlayer.showNotification("You Don't Have Enough of This Item ["..string.upper(xItem.name).."]")
        TriggerClientEvent('textstatus', src, true)
    end
end)

checkLimit = function(source, types, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if types == "mainjob" then
        local result = MySQL.Sync.fetchAll("SELECT mainjoblimit FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
        })
        if result[1].mainjoblimit >= Cfg.mainjoblimit or result[1].mainjoblimit + amount >= Cfg.mainjoblimit then
            return false
        else
            MySQL.Async.execute("UPDATE users SET mainjoblimit = @mainjoblimit WHERE identifier = @identifier", {
                ["@mainjoblimit"] = result[1].mainjoblimit + amount,
                ["@identifier"] = xPlayer.identifier
            })
            return true
        end
        else
        local result = MySQL.Sync.fetchAll("SELECT sidejoblimit FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
        })
        if result[1].sidejoblimit >= Cfg.sidejoblimit or result[1].sidejoblimit + amount >= Cfg.sidejoblimit then 
            return false
        else
            MySQL.Async.execute("UPDATE users SET sidejoblimit = @sidejoblimit WHERE identifier = @identifier", {
                ["@sidejoblimit"] = result[1].sidejoblimit + amount, 
                ["@identifier"] = xPlayer.identifier
            })
            return true
        end
    end
end

resetLimit = function()
    local sqlresult = MySQL.Sync.fetchAll("SELECT * FROM users")
    for i = 1, #sqlresult, 1 do
        MySQL.Async.execute("UPDATE users SET mainjoblimit = @mainjoblimit, sidejoblimit = @sidejoblimit WHERE identifier = @identifier", {
            ["@mainjoblimit"] = 0,
            ["@sidejoblimit"] = 0,
            ["@identifier"] = sqlresult[i].identifier
        })
    end
    print("^8DAILY LIMIT RESET^0")
end


TriggerEvent('cron:runAt', 00, 00, resetLimit)
