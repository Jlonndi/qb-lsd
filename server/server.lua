QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('acid_weed:pickedUpCannabis2') --hero
AddEventHandler('acid_weed:pickedUpCannabis2', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('empty_bottle') then
	    if 	TriggerClientEvent("QBCore:Notify", src, "You Got Some Acid.", "Success", 8000) then
		  Player.Functions.AddItem('acid_bottle', 1) ---- change this shit 
		  Player.Functions.RemoveItem('empty_bottle', 1)
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['acid_bottle'], "add")
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_bottle'], "remove")
	    end
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have Empty Bottles', "error")
	end
end)	

RegisterServerEvent('acid_weed:processweed2')
AddEventHandler('acid_weed:processweed2', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('acid_bottle') then
		local chance = math.random(1, 8)
		if chance == 1 or chance == 2 or chance == 3 or chance == 4 or chance == 5 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('acid_bottle', 2)----change this
			Player.Functions.AddItem('lsd', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['acid_bottle'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd'], "add")
			TriggerClientEvent('QBCore:Notify', src, 'LSD Made successfully', "success")  
		else
			--Player.Functions.RemoveItem('cannabis', 1)----change this
			--Player.Functions.RemoveItem('empty_weed_bag', 1)----change this
			--TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
			--TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove")
			--TriggerClientEvent('QBCore:Notify', src, 'You messed up and got nothing', "error") 
		end 
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)

--selldrug ok

RegisterServerEvent('acid_weed:selld2')
AddEventHandler('acid_weed:selld2', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Item = Player.Functions.GetItemByName('lsd')
   
	
      
	for i = 1, Item.amount do
	if Item.amount >0 then
	if Player.Functions.GetItemByName('lsd') then
		local chance2 = math.random(1, 8)
		if chance2 == 1 or chance2 == 2 or chance2 == 9 or chance2 == 4 or chance2 == 10 or chance2 == 6 or chance2 == 7 or chance2 == 8 then
			Player.Functions.RemoveItem('lsd', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd'], "remove")
			Player.Functions.AddMoney("cash", Config.Pricesell, "sold-pawn-items")
			TriggerClientEvent('QBCore:Notify', src, 'You Sold LSD', "success")   
		end 
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
else
	TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	
end
end
end)



function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('acid_weed:cancelProcessing2')
AddEventHandler('acid_weed:cancelProcessing2', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('acid_weed:onPlayerDeath2')
AddEventHandler('acid_weed:onPlayerDeath2', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('poppy:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "bag_cocke" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Coke process", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
