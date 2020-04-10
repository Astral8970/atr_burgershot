ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('astral_burger:achat')
AddEventHandler('astral_burger:achat', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
    	TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~b~1 ".. label .. " ~w~pour ~g~" .. price .. "$ !", "", 1)
    else
    	TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d\'argent !", "", 1)
    end
end)

