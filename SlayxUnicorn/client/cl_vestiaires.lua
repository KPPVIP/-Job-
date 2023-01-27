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

-- Function --

function barman()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then

-- Pour les Hommes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0, ['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }
    else

-- Pour les Femmes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0,['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0, ['arms_2'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end

function barman2()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then

-- Pour les Hommes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0, ['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }
    else

-- Pour les Femmes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0,['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0, ['arms_2'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end

function vcivil()

ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

TriggerEvent('skinchanger:loadSkin', skin)

end)

end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Vestiaire Unicorn', "Unicorn")
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenVestiaire()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Separator("↓ ~b~   Vestiaire  ~s~↓")

              RageUI.Button("Reprendre Sa Tenue", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    vcivil()
                  end
                })	

                RageUI.Button("Enfiler Tenue de Travail", nil, {RightLabel = "→"}, true , {
                  onSelected = function()
                    barman()
                    end
                  })	
            
                  RageUI.Button("Enfiler Tenue de Travail #2", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                      barman2()
                      end
                    })	
            end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = 99.21, y = -1311.85, z = 29.27}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
       if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour ouvrir le casier", 1) 
                if IsControlJustPressed(1,51) then
                  OpenVestiaire()
            end
        end
      end
    Citizen.Wait(wait)
    end
  end
end)

--Ped Videur

local npc = {
  {hash="s_m_m_highsec_01", x = 127.83, y = -1299.68, z = 29.23, a = 211.97},
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

local npc = {
  {hash="s_m_m_highsec_02", x = 130.48, y = -1298.27, z = 29.23, a = 221.90},
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

--PED VITRINE

local npc = {
  {hash="u_f_y_poppymich", x = 112.65, y = -1310.89, z = 29.75, a = 209.49},
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

local npc = {
  {hash="u_f_y_poppymich_02", x = 109.97, y = -1312.62, z = 29.75, a = 214.415},
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

local npc = {
  {hash="u_f_y_lauren", x = 107.02, y = -1314.15, z = 29.75, a = 203.5},
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
