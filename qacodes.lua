local minutesforgivecoin = 1
local coinstogive = 1 
local playerConnected = {}


AddEventHandler("Connect", function(Passport,Source)
    if Passport and not playerConnected[Passport] then 
        playerConnected[Passport] = os.time() + (minutesforgivecoin*60)
    end
end)


AddEventHandler("Disconnect", function(Passport,Source)
    if Passport and playerConnected[Passport] then 
        playerConnected[Passport] = nil
    end
end)


function giveCoin(Passport)
    if Passport then 
        local source = vRP.Source(Passport)
        if source then 
            TriggerClientEvent("Notify",source,"azul","Obrigado por se conectar ao nosso servidor! Você recebeu "..coinstogive.." "..(coinstogive > 1 and "coins" or "coin").." como recompensa.","importante",5000)
        end

        vRP.GiveCoins(Passport,coinstogive)

        -- Log
    end
end


CreateThread(function()
    while true do
        Wait(30000)

        local now = os.time()
        for Passport,nextRewardTime in pairs(playerConnected) do 
            if now >= nextRewardTime then 
                giveCoin(Passport)
                playerConnected[Passport] = os.time() + (minutesforgivecoin*60)
            end 
        end
    end
end)