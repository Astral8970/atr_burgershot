ESX = nil

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Burger, 1 do
            local hash = GetHashKey("csb_burgerdrug")
            while not HasModelLoaded(hash) do
                RequestModel(hash)
                Wait(60)
            end
            ped = CreatePed("PED_TYPE_CIVMALE", "csb_burgerdrug", v.Burger[i].x, v.Burger[i].y, v.Burger[i].z, v.Burger[i].angle, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Burger, 1 do
            local blip = AddBlipForCoord(v.Burger[i].x, v.Burger[i].y, v.Burger[i].z)

            SetBlipSprite (blip, 106)
            SetBlipScale  (blip, 0.9)
            SetBlipColour (blip, 51)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Burgershot')
            EndTextCommandSetBlipName(blip)
         end
     end
end)


local burger = {
    Base = { Title = "Burgershot" },
    Data = { currentMenu = "~b~Acheter un produit au Burgergshot !" },
    Events = {
        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
              if btn.name == "Hamburger" then
                    TriggerServerEvent('astral_burger:achat', 5, "hamburger", "Hamburger")
              elseif btn.name == "Coca Cola" then
                    TriggerServerEvent('astral_burger:achat', 7, "cocacola", "Coca-cola")
              elseif btn.name == "Sandwich" then
                    TriggerServerEvent('astral_burger:achat', 7, "sandwich", "Sandwich")
              elseif btn.name == "Ice-Tea" then
                    TriggerServerEvent('astral_burger:achat', 7, "icetea", "Ice-tea")
              end
        end,
    },
    Menu = {
        ["~b~Acheter un produit au Burgergshot !"] = {
            b = {
                {name = "Hamburger", ask = "~g~4$", askX = true},
                {name = "Coca Cola", ask = "~g~6$", askX = true},
                {name = "Sandwich", ask = "~g~4$", askX = true},
                {name = "Ice-Tea", ask = "~g~6$", askX = true},
            }
        },

    }
}



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- on check si le joueur est assez proche du ped
        for k,v in pairs(Config.Zones) do
            
            -- Pour tous les shop legaux
            for i = 1, #v.Burger, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Burger[i].x, v.Burger[i].y, v.Burger[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler au vendeur.')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(burger)
                    end
                end
            end
        end
    end
end)


print("^0======================================================================^7")
print("^5BurgerShot en cMenu par Astral ^^")
print("^0======================================================================^7")
