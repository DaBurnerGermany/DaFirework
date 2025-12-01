Config = {}
Config.TurnCityLightsOff = true -- City Blackout at fireworks show?
Config.FireworksTime = 15 -- Time in Minutes
Config.DelayPerExplosion = 200 --Time in milliseconds
Config.Language = 'en'

Config.AddExplosionSounds = true -- if you use anticheat please add this script as exception.
Config.AutoSetNightOnFirework = true
Config.AutoSetClearWeather = true


Config.Notify = function(message)
	TriggerEvent("myVehicleRegistration:notify", message)
	--TriggerEvent('notifications', '#07b95e', '', message)
end 

Config.FireworkPositions = {
    {-74.61, -818.97, 326.18} --maze bank
    ,{215.0, -921.61, 60.0} -- centre park
    ,{711.36, 1197.95, 348.51} --vinewood logo
}

Config.Milestones = {
    de = {
        ["23:00"] = "Es ist 23:00 Uhr! In einer Stunde beginnt das große Feuerwerk!",
        ["23:30"] = "Es ist 23:30 Uhr! Noch 30 Minuten bis zum Feuerwerk!",
        ["23:45"] = "Es ist 23:45 Uhr! Noch 15 Minuten bis zum Feuerwerk!",
        ["23:55"] = "Es ist 23:55 Uhr! Noch 5 Minuten bis zum Feuerwerk!",
        ["23:59"] = "Es ist 23:59 Uhr! Gleich startet der Countdown!",
        final = "Frohes neues Jahr!"
    },
    en = {
        ["23:00"] = "It's 11:00 PM! The big fireworks show starts in one hour!",
        ["23:30"] = "It's 11:30 PM! Only 30 minutes left until the fireworks!",
        ["23:45"] = "It's 11:45 PM! 15 minutes until the fireworks!",
        ["23:55"] = "It's 11:55 PM! 5 minutes left until the fireworks!",
        ["23:59"] = "It's 11:59 PM! The countdown starts soon!",
        final = "Happy New Year!"
    }
}


Config.FireworkConfig = {
    {asset="proj_indep_firework", effect = "scr_indep_firework_air_burst"},
    {asset="proj_indep_firework_v2", effect = "scr_firework_indep_spiral_burst_rwb"},
    {asset="proj_indep_firework_v2", effect = "scr_firework_indep_repeat_burst_rwb"},
    {asset="scr_indep_fireworks", effect = "scr_indep_firework_starburst"},
    {asset="scr_indep_fireworks", effect = "scr_indep_firework_shotburst"},
    {asset="scr_indep_fireworks", effect = "scr_indep_firework_fountain"},
    {asset="proj_xmas_firework", effect = "scr_firework_xmas_repeat_burst_rgw"},
    {asset="proj_indep_firework_v2", effect = "scr_firework_indep_ring_burst_rwb"},
    {asset="proj_indep_firework_v2", effect = "scr_xmas_firework_burst_fizzle"}
}

Config.FireworkTypes = {
    ["scr_indep_firework_air_burst"] = { rx = 100, ry = 100, minZ = 100, maxZ = 150, scale = 2.0 },
    ["scr_firework_indep_spiral_burst_rwb"] = { rx = 200, ry = 200, minZ = 100, maxZ = 200, scale = 5.0 },
    ["scr_firework_indep_repeat_burst_rwb"] = { rx = 100, ry = 100, minZ = 100, maxZ = 200, scale = 5.0 },
    ["scr_indep_firework_starburst"] = { rx = 100, ry = 100, minZ = 50,  maxZ = 100, scale = 5.0 },
    ["scr_indep_firework_shotburst"] = { rx = 100, ry = 100, minZ = 50,  maxZ = 200, scale = 5.0 },
    ["scr_indep_firework_fountain"] = { rx = 0,   ry = 0,   minZ = 0,   maxZ = 0,   scale = 5.0 },
    ["scr_firework_xmas_repeat_burst_rgw"] = { rx = 100, ry = 100, minZ = 50, maxZ = 200, scale = 5.0 },
    ["scr_firework_indep_ring_burst_rwb"] = { rx = 100, ry = 100, minZ = 50, maxZ = 200, scale = 5.0 },
    ["scr_xmas_firework_burst_fizzle"] = { rx = 100, ry = 100, minZ = 50, maxZ = 200, scale = 5.0 }
}