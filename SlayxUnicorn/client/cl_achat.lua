Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('Achat', 'Unicorn Slayx') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilUnicorn() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()

        RageUI.Button("~r~Acheter~s~ x1 Vin", nil, {RightLabel = "20$"}, not codesCooldown5 , {
			onSelected = function()
			TriggerServerEvent('slayx:BuyVine')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
    })

        RageUI.Button("~r~Acheter~s~ x1 Mojito", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyMojito')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Ice Tea", nil, {RightLabel = "8$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyIceTea')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Eau", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyEau')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Whisky-coca", nil, {RightLabel = "12$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyWhiskycoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Coca", nil, {RightLabel = "6$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyCoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Limonade", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyLimonade')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button("~r~Acheter~s~ x1 Fanta", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('slayx:BuyFanta')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

		end)			
		Wait(0)
	   end
	end)
 end
end

local position = {
    {x = 980.89, y = -1705.84, z = 31.12}
}

local npc = {
    {hash="a_m_y_business_02", x = 980.89, y = -1705.84, z = 31.12, a = 81.84},
}

Citizen.CreateThread(function()
    for _, item2 in pairs(npc) do
        local hash = GetHashKey(item2.hash)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped2, true)
        FreezeEntityPosition(ped2, true)
        SetEntityInvincible(ped2, true)
    end
 end)  

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, 980.89, -1705.84, 31.12, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir avec le Vendeur", 1) 
                if IsControlJustPressed(1,51) then
                    OpenMenuAccueilUnicorn()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

