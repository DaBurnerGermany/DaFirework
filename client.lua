FireWorkIsRunning = false

CreateThread(function()
    for _, v in pairs(Config.FireworkConfig) do 
        RequestNamedPtfxAsset(v.asset)
        while not HasNamedPtfxAssetLoaded(v.asset) do
            Wait(1)
        end
    end 

    while true do 
        if FireWorkIsRunning then 

            Wait(Config.DelayPerExplosion)

            for _, values in pairs(Config.FireworkConfig) do 
                for _, pos in pairs(Config.FireworkPositions) do 
                    local asset  = values.asset
                    local effect = values.effect
                    SpawnFireworkAtRandomOffset(asset, effect, pos)
                    
                end 
                Wait(Config.DelayPerExplosion)
            end 
        else
            Wait(1000)
        end 
    end 
end)




function SpawnFireworkAtRandomOffset(asset, effect, basePos)
    local cfg = Config.FireworkTypes[effect]
    if not cfg then
        print(("[DaFirework] no config entry for effect'%s'"):format(effect))
        return
    end

    local baseX, baseY, baseZ = basePos[1], basePos[2], basePos[3]

    local x = baseX + math.random(-cfg.rx, cfg.rx)
    local y = baseY + math.random(-cfg.ry, cfg.ry)
    local z = baseZ + 25 + math.random(cfg.minZ, cfg.maxZ)

    UseParticleFxAssetNextCall(asset)
    StartParticleFxNonLoopedAtCoord(
        effect,
        x, y, z,
        0.0, 0.0, 0.0,
        cfg.scale,
        false, false, false, false
    )

    
    PlayFireworkBoomLocal(x, y, z)


end

function PlayFireworkBoomLocal(x, y, z )
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)

    local explosionType = math.random(1,7) - 1
    local damageScale   = 0.0
    local camShake      = 0.1
    local audible       = true
    local invisible     = false

    AddExplosion(
        x or pCoords.x,
        y or pCoords.y,
        z or pCoords.z + 0.5,
        explosionType,
        damageScale,
        audible,
        invisible,
        camShake
    )
end


function StartCountdown(seconds, finaltext)

    CreateThread(function()
        for i = seconds, 1, -1 do
            -- letzter 3 Sekunden: mehrfach Beep für mehr Spannung
            if i <= 3 then
                for n = 1, 3 do
                    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", false)
                    Wait(80)
                end
            else
                PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", false)
            end

            local startTime = GetGameTimer()
            while GetGameTimer() - startTime < 1000 do
                DrawCountdownText(tostring(i))
                Wait(0)
            end
        end

        
        PlaySoundFrontend(-1, "Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)

        
        StartFirework()

        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < 6000 do
            local t = (GetGameTimer() - startTime) / 6000.0

            
            local r = math.floor(127 + 127 * math.sin(t * math.pi * 2))
            local g = math.floor(127 + 127 * math.sin(t * math.pi * 2 + 2))
            local b = math.floor(127 + 127 * math.sin(t * math.pi * 2 + 4))

            DrawCountdownText(finaltext, {r, g, b})
            Wait(0)
        end

    end)
end

function DrawCountdownText(text, color)
    color = color or {255, 255, 255}
    SetTextFont(7)
    SetTextProportional(1)
    SetTextScale(3.5, 3.5)
    SetTextColour(color[1], color[2], color[3], 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.4)
end

RegisterNetEvent("DaFirework:notify")
AddEventHandler("DaFirework:notify", function(notificationtext)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(notificationtext)
	DrawNotification(false, false)
end)

RegisterNetEvent("DaFirework:notifyUser")
AddEventHandler("DaFirework:notifyUser", function(msg)
    Config.Notify(msg)
end)


RegisterNetEvent("DaFirework:StartCountDown")
AddEventHandler("DaFirework:StartCountDown", function(seconds, finaltext)
    clearWeather()
    TurnCityLightsOff()
    StartCountdown(seconds, finaltext)
end)

function clearWeather()
    if Config.AutoSetNightOnFirework then
        NetworkOverrideClockTime(23, 0, 0)
    end

    -- Wetter auf „klar“ setzen (optional)
    if Config.AutoSetClearWeather then
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypeNowPersist("CLEAR")  -- oder "EXTRASUNNY", wenn du willst
    end
end 


function StartFirework()
    FireWorkIsRunning = true

    print("Hello")
    TriggerServerEvent("DaFirework:startFireworkTimer")

end

function StopFirework()
    TurnCityLightsOn();
    FireWorkIsRunning = false
end 


function TurnCityLightsOff()
    if Config.TurnCityLightsOff then
        SetArtificialLightsState(true)
    end
end 
function TurnCityLightsOn()
    if Config.TurnCityLightsOff then
        SetArtificialLightsState(false)
    end
end 

RegisterNetEvent("DaFirework:start")
AddEventHandler("DaFirework:start", function()
    clearWeather()
    TurnCityLightsOff()
    StartFirework();

end)
RegisterNetEvent("DaFirework:stop")
AddEventHandler("DaFirework:stop", function()
    StopFirework()
end)
