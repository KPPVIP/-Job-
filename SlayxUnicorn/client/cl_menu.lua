Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

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


-- MENU FUNCTION --

local open = false 
local unicornMain2 = RageUI.CreateMenu('Unicorn', 'Interaction')
local subMenu5 = RageUI.CreateSubMenu(unicornMain2, "Annonces", "Interaction")
unicornMain2.Display.Header = true 
unicornMain2.Closed = function()
  open = false
end

function OpenMenuunicorn()
	if open then 
		open = false
		RageUI.Visible(unicornMain2, false)
		return
	else
		open = true 
		RageUI.Visible(unicornMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(unicornMain2,function() 

			RageUI.Separator("↓ Annonce Unicorn ↓")
			RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:unicorn')
				end
			})

			RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:unicorn')
				end
			})

			RageUI.Button("Annonce ~b~[Recrutement]", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recrutement:unicorn')
				end
			})
			
			
			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une ~y~Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})

			RageUI.Separator("↓ Achat ↓")
			RageUI.Button("Obtenir ~o~Point d\'Achat~s~", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					SetNewWaypoint(980.89, -1705.84, 31.12)  
				end
			})
			end)

		 Wait(0)
		end
	 end)
  end
end




-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_unicorn', ('unicorn'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

-- OUVERTURE DU MENU --

Keys.Register('F6', 'unicorn', 'Ouvrir le menu unicorn', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
    	OpenMenuunicorn()
	end
end)

--- BLIPS ---

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(128.03, -1296.75, 29.26) 
  
	SetBlipSprite (blip, 121)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 7) 
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Vanilla Unicorn')
	EndTextCommandSetBlipName(blip)
  end)