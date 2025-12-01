
firedToday = {}
lastDay = os.date("*t").day
countdownRunning = false
fireworkTimerRunning = false

CreateThread(function()
    while true do
        local now = os.date("*t")
        local lang = Config.Language or "en"
        local langTable = Config.Milestones[lang] or Config.Milestones["en"]

        -- only at dec 31st
        if now.month == 12 and now.day == 31 then
            local timeKey = ("%02d:%02d"):format(now.hour, now.min)

            
            if langTable[timeKey] and not firedToday[timeKey] then
                TriggerClientEvent("DaFirework:notifyUser", -1, langTable[timeKey]) 
                firedToday[timeKey] = true

                -- Countdown bei 23:59
                if timeKey == "23:59" and not countdownRunning then
                    countdownRunning = true

                    remainingSeconds = 60 - os.date("*t").sec;
                    TriggerClientEvent("DaFirework:StartCountDown", -1, remainingSeconds, langTable.final) 
                end
            end
        else
            if now.day ~= lastDay then
                firedToday = {}
                countdownRunning = false
                lastDay = now.day
            end
        end

        Wait(1000)
    end
end)


RegisterNetEvent("DaFirework:startFireworkTimer")
AddEventHandler("DaFirework:startFireworkTimer", function()
    local src = source
    local minutes = (Config and Config.FireworksTime) or 15

    
    if minutes < 1 then minutes = 1 end
    if minutes > 120 then minutes = 120 end -- 2h limit

    if fireworkTimerRunning then
        return
    end

    fireworkTimerRunning = true

    CreateThread(function()
        local duration = minutes * 60 * 1000
        local startTime = GetGameTimer()

        while GetGameTimer() - startTime < duration and fireworkTimerRunning do
            Wait(1000)
        end

        if fireworkTimerRunning then
            TriggerClientEvent("DaFirework:stop", -1)
        end

        fireworkTimerRunning = false
    end)
end)



RegisterCommand("firework_countdown", function(source, args, raw)
    if source == 0 or IsPlayerAceAllowed(source, "command") then

        
        local lang = Config.Language or "en"
        local langTable = Config.Milestones[lang] or Config.Milestones["en"]

        local seconds = tonumber(args[1]) or 10 

        if seconds < 5 then 
            seconds = 5
        end 

        TriggerClientEvent("DaFirework:StartCountDown", -1, seconds, langTable.final) 
        print("[DaFirework] countdown manually started.")
    end
end, false)

RegisterCommand("firework_start", function(source, args, raw)
    if source == 0 or IsPlayerAceAllowed(source, "command") then
        TriggerClientEvent("DaFirework:start", -1)
        print("[DaFirework] firework manually started.")
    end
end, false)

RegisterCommand("firework_stop", function(source, args, raw)
    if source == 0 or IsPlayerAceAllowed(source, "command") then
        TriggerClientEvent("DaFirework:stop", -1)
        print("[DaFirework] firework manually stopped.")
    end
end, false)