# DaFirework

A fully automatic **New Year’s Eve fireworks show** for FiveM — with timed milestones, countdown, sounds, and realistic particle effects.  
Can also be triggered manually by admins at any time.

---

## Features

- **Automatic New Year’s Eve event**
  - Runs only on **December 31st**
  - Announces messages at: `23:00`, `23:30`, `23:45`, `23:55`, and `23:59`
  - 60-second countdown before midnight
  - Automatically starts fireworks at 00:00  
- **Manual control for admins**
  - `/firework_start` – start fireworks manually  
  - `/firework_stop` – stop fireworks manually  
  - `/firework_countdown [seconds]` – start a manual countdown  
- **Timed fireworks**
  - Automatic stop after `Config.FireworksTime` minutes  
- **Environmental effects**
  - Optional blackout (`TurnCityLightsOff`)
  - Optional night time (`AutoSetNightOnFirework`)
  - Optional clear weather (`AutoSetClearWeather`)
- **Sound effects & explosions**
  - Each firework has a **randomized explosion sound and volume**
  - Sounds are **localized** around the firework position
  - Can be **completely disabled** in the config (`AddExplosionSounds = false`)
- **Multi-language milestone messages**
  - English 🇬🇧 and German 🇩🇪 supported

---

## Installation

1. **Extract** this resource into your `resources/` folder  
   Example:  
   ```
   resources/[yourfolder]/DaFirework
   ```

2. **Add it to your `server.cfg`:**
   ```cfg
   ensure DaFirework
   ```

3. (Optional)  
   If your **anti-cheat** monitors explosion events, make sure to whitelist this resource.  
   The script uses **client-side sound effects and particle explosions** purely for visuals.  
   No damage or gameplay impact occurs.

---

## Configuration

All settings are located in [`config.lua`](config.lua):

| Option | Type | Description |
|---------|------|-------------|
| `TurnCityLightsOff` | boolean | Turns off city lights during the show |
| `FireworksTime` | number | How long fireworks last (minutes) |
| `DelayPerExplosion` | number | Delay between particle bursts (ms) |
| `Language` | string | `"en"` or `"de"` |
| `AddExplosionSounds` | boolean | Enables or disables random explosion sounds |
| `AutoSetNightOnFirework` | boolean | Forces night time at firework start |
| `AutoSetClearWeather` | boolean | Forces clear weather at start |
| `FireworkPositions` | table | List of firework spawn positions |
| `Milestones` | table | Chat or notify messages per milestone |
| `FireworkConfig` | table | Available particle and asset combinations |
| `FireworkTypes` | table | Defines random radius, height, and scale for each effect |

---

## Commands

| Command | Description |
|----------|--------------|
| `/firework_start` | Manually start the fireworks |
| `/firework_stop` | Stop the fireworks |
| `/firework_countdown [seconds]` | Start a countdown and fireworks |

---

## Events

| Event | Side | Description |
|--------|------|--------------|
| `DaFirework:start` | client | Start fireworks instantly |
| `DaFirework:stop` | client | Stop fireworks |
| `DaFirework:StartCountDown` | client | Start countdown UI |
| `DaFirework:startFireworkTimer` | server | Auto-stops fireworks after `Config.FireworksTime` |
| `DaFirework:startTimed` | server | Start fireworks for custom minutes |
| `DaFirework:notify` / `notifyUser` | client | Display notifications |

---

## Developer Notes

- Works standalone — no dependency on ESX or QBCore.  
- If you use ESX/QBCore notifications, you can replace the default notify function:
  ```lua
  Config.Notify = function(message)
      TriggerEvent('esx:showNotification', message)
  end
  ```
- Fireworks are handled **client-side** for smooth visuals and to prevent desync.
- The server manages timing, countdowns, and milestone notifications.
