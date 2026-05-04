# 🎮 VOID EATER - Complete Game Development Guide

## 📋 Project Overview

**Game Name:** VOID EATER  
**Tagline:** "Consume. Evolve. Ascend."  
**Engine:** Godot 4.3+  
**Platform:** Windows (Steam)  
**Genre:** Fast-Paced Roguelike  
**Session Length:** 5-12 minutes  
**Status:** Core Systems Complete - Asset Generation Phase

---

## 🎯 Core Gameplay Loop

```
START RUN
  ↓
WAVE SPAWNS (3 enemies initially, +2 per wave)
  ↓
PLAYER FIGHTS ENEMIES
  ↓
ENEMIES DROP ECHOES (collect for boosts)
  ↓
ECHO CHOICE:
  - Consume immediately (speed/damage boost 8 seconds)
  - Store as shield (absorb 1 hit)
  - Convert to permanent upgrade (10 coins)
  ↓
EVERY 5 ENEMIES DEFEATED:
  - Level up
  - Choose 1 of 3 random upgrades
  ↓
EVERY 3 WAVES:
  - Boss encounter
  ↓
DEATH = RUN OVER
  - Coins → Permanent upgrades
  - Back to main menu
```

---

## 📁 Project Structure

```
GameApp/
├── project.godot              # Godot configuration
├── DEVELOPMENT.md             # This file
├── ASSETS.md                  # Asset generation prompts
│
├── src/
│   ├── utils/
│   │   ├── constants.gd       # Game constants
│   │   └── game_state.gd      # Global game state (autoload)
│   │
│   ├── entities/
│   │   ├── player.gd          # Player controller
│   │   ├── enemy_base.gd      # Enemy base class
│   │   ├── specter.gd         # Fast weak enemy
│   │   ├── bloat.gd           # Slow strong enemy
│   │   ├── spinner.gd         # Rotating enemy
│   │   └── echo.gd            # Echo collectible
│   │
│   ├── systems/
│   │   ├── wave_manager.gd    # Wave spawning
│   │   ├── echo_system.gd     # Echo creation/tracking
│   │   ├── upgrade_manager.gd # Permanent progression
│   │   └── save_manager.gd    # Save/Load
│   │
│   ├── ui/
│   │   └── hud.gd             # In-game HUD
│   │
│   └── scenes/
│       ├── main_menu.gd/.tscn      # Start screen
│       ├── game.gd/.tscn           # Main gameplay
│       ├── game_over.gd/.tscn      # End screen
│       ├── echo.tscn               # Echo entity
│       ├── enemy_specter.tscn      # Specter enemy
│       ├── enemy_bloat.tscn        # Bloat enemy
│       └── enemy_spinner.tscn      # Spinner enemy
│
└── assets/
    ├── sprites/
    ├── sounds/
    ├── music/
    └── fonts/
```

---

## ⚙️ Key Systems

### 1. **Echo System** (Unique Mechanic)
- Enemies drop echoes on defeat
- Three uses:
  - **Temporary Boost**: +30% speed or +50% damage (8 sec)
  - **Shield**: Absorb 1 hit
  - **Permanent Upgrade**: Convert 10 echoes → 1 permanent upgrade

### 2. **Wave System**
- Waves scale exponentially
- Wave 1: 3 enemies
- Wave N: 3 + (N-1) * 2 enemies
- Every 5 enemies: Level up (choose upgrade)
- Every 3 waves: Boss fight (harder, more rewards)

### 3. **Permanent Progression**
- Collect coins during runs
- Spend coins on permanent upgrades
- Upgrades persist across runs
- Creates "easy" runs once unlocked enough

### 4. **Enemy Types**
- **Specter**: Fast, weak (1 health, 120 speed)
- **Bloat**: Slow, strong (3 health, 60 speed)
- **Spinner**: Medium (1 health, 80 speed, rotates)

### 5. **Player Upgrades**
- Damage (+20% per level)
- Speed (+15% per level)
- Health (+1 per level)
- Echo Duration (+50% per level)
- Echo Spawn Rate (+30% per level)
- Critical Chance (20% crit damage)

---

## 🎮 Controls

| Action | Input |
|--------|-------|
| Move | WASD or Arrow Keys |
| Attack | Mouse Click |
| Pause | ESC |

---

## 🎨 Art Direction

**Style:** Minimalist Pixel Art (8-bit)  
**Resolution:** 1280x720 (base), 2x scale  
**Color Palette:**
- Dark Background: `#1a1a2e`
- Cyan Accent: `#00d9ff`
- Purple Accent: `#9d00ff`
- Hot Pink: `#ff006e`
- Gold: `#ffff00`

**Inspiration:** Risk of Rain, Brotato, Hades

---

## 🔊 Audio System

**Music Loop:** 2:00 loopable track (100 BPM)

**SFX:**
- Attack: Sharp zap (0.1s)
- Echo Collect: Sparkle chime (0.3s)
- Level Up: Ascending 3-note chime (0.6s)
- Boss: Deep tremolo tone (1.5s)
- Hit: Impact sound (0.2s)
- Death: Descending whoosh (0.4s)

---

## 🛠️ Development Checklist

### Phase 1: Core Systems ✅
- [x] Game state management
- [x] Player controller
- [x] Enemy base class
- [x] Echo system
- [x] Wave manager
- [x] UI/HUD
- [x] Save/Load

### Phase 2: Polish
- [ ] Placeholder sprites
- [ ] Animation system
- [ ] Visual feedback (hit flash, knockback)
- [ ] Particle effects
- [ ] Audio system integration
- [ ] Menu transitions
- [ ] Game Over screen details

### Phase 3: Content
- [ ] Art assets
- [ ] Audio assets
- [ ] Tilesets
- [ ] Enemy variety (add 2 more types)
- [ ] Boss implementation
- [ ] Visual effects

### Phase 4: Testing & Optimization
- [ ] Bug fixes
- [ ] Balance tuning
- [ ] Performance optimization
- [ ] Save file compatibility

### Phase 5: Steam Integration
- [ ] Steamworks SDK integration
- [ ] Achievements
- [ ] Cloud saves
- [ ] Overlay support

### Phase 6: Publishing
- [ ] Build executable
- [ ] Create store page
- [ ] Screenshots/trailer
- [ ] Launch trailer
- [ ] Press kit

---

## 🚀 Building & Running

### Development (Godot Editor)
```bash
# Open in Godot
godot project.godot
```

### Export for Windows
1. Project → Export
2. Create Windows Desktop profile
3. Configure:
   - Resolution: 1280x720
   - Fullscreen: Optional
   - Engine crashes: Don't save
4. Export as Void_Eater.exe

---

## 📊 Game Balance (Tuning Points)

| Element | Value | Notes |
|---------|-------|-------|
| Player Speed | 200 px/s | +15% per upgrade |
| Player Damage | 10 | +2 per upgrade |
| Player Health | 3 | +1 per upgrade |
| Attack Cooldown | 0.3s | Responsive feel |
| Echo Lifetime | 3s | Time to collect |
| Boost Duration | 8s | Meaningful but short |
| Wave Scaling | +2 enemies | Gradual difficulty |
| Boss Interval | 3 waves | Milestone feeling |

---

## 🎯 Success Metrics (Post-Launch)

- **Day 1 Retention:** >30%
- **Session Length:** 5-12 minutes
- **Replayability:** 10+ runs before "complete"
- **Viral Potential:** Satisfying gameplay loop + visual effects
- **Peak Concurrent:** Goal: 100+ (indie success)

---

## 📝 Marketing Keywords

- Roguelike
- Fast-Paced
- Skill-Based
- Minimalist
- Indie
- Addictive
- Progression
- Boss Battles

---

## 🔗 Next Steps

1. Generate/create placeholder sprites
2. Implement visual feedback system
3. Add particle effects
4. Integrate audio
5. Polish menus
6. Implement boss encounters
7. Add more enemy types
8. Test and balance

See ASSETS.md for detailed sprite generation prompts.

---

**Last Updated:** 2026-05-04  
**Version:** 1.0 (Pre-Alpha)
