# 🎮 VOID EATER

**"Consume. Evolve. Ascend."**

A hypnotic fast-paced roguelike where you consume souls in an endless void, collecting echoes to unlock permanent power and achieve transcendence.

![Status](https://img.shields.io/badge/Status-Alpha-orange)
![Engine](https://img.shields.io/badge/Engine-Godot_4.3-blue)
![Platform](https://img.shields.io/badge/Platform-Windows-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🎯 Quick Start

### For Players
```bash
# Download latest release from Steam (coming soon)
# or extract release build and run:
./Void_Eater.exe
```

### For Developers
```bash
# Clone repository
git clone https://github.com/yourname/void-eater.git
cd void-eater

# Open in Godot 4.3+
godot project.godot

# Or run directly
godot --run project.godot
```

**Control:**
- WASD / Arrow Keys: Move
- Mouse Click: Attack
- ESC: Pause

---

## 🎮 Gameplay Overview

### Core Loop
1. **Enter run** - Start with base stats
2. **Fight enemies** - Defeat Specters, Bloats, Spinners
3. **Collect echoes** - Temporary boosts or permanent upgrades
4. **Progress waves** - Difficulty scales, choose upgrades every 5 enemies
5. **Face bosses** - Every 3 waves, Echo Sovereign awaits
6. **Die → Upgrade** - Spend coins on permanent improvements
7. **Repeat** - Each run makes you stronger

### The Echo System (Unique Mechanic)
Defeated enemies drop **echoes** - floating souls with three uses:
- **Consume:** +30% speed/damage for 8 seconds
- **Store:** Absorb 1 incoming hit  
- **Convert:** 10 echoes = 1 permanent upgrade

This creates **dynamic decision-making** every second of gameplay.

---

## ✨ Features

✅ **Addictive Gameplay Loop**
- 5-12 minute runs designed for "one more run" mentality
- Immediate feedback & responsive controls
- High replayability through procedural spawning

✅ **Permanent Progression**
- Collect coins during runs
- Unlock 6+ permanent upgrades
- No grind walls - skill + strategy matter most

✅ **Three Enemy Types**
- **Specter:** Fast, weak (chasing threat)
- **Bloat:** Slow, strong (positioning challenge)
- **Spinner:** Rotating defense (projectile risk)

✅ **Boss Encounters**
- Echo Sovereign appears every 3 waves
- 3 phases, unique attack patterns
- High risk/reward challenge

✅ **Minimalist Art Style**
- Clean pixel art aesthetic
- Neon cyan & purple color scheme
- Professional visual feedback

✅ **Audio Immersion**
- Lo-fi electronic soundtrack
- Satisfying SFX for actions
- Hypnotic audio loop design

---

## 🏗️ Project Structure

```
GameApp/
├── README.md                    # This file
├── DEVELOPMENT.md              # Full dev guide
├── ASSETS.md                   # Asset generation prompts
├── STEAM_LAUNCH.md             # Publishing guide
├── BUILD_GUIDE.md              # Build instructions
│
├── project.godot               # Godot configuration
│
├── src/
│   ├── utils/
│   │   ├── constants.gd       # Game constants
│   │   └── game_state.gd      # Global game state
│   ├── entities/
│   │   ├── player.gd
│   │   ├── enemy_base.gd
│   │   ├── specter.gd
│   │   ├── bloat.gd
│   │   ├── spinner.gd
│   │   └── echo.gd
│   ├── systems/
│   │   ├── wave_manager.gd
│   │   ├── echo_system.gd
│   │   ├── upgrade_manager.gd
│   │   └── save_manager.gd
│   ├── ui/
│   │   └── hud.gd
│   └── scenes/
│       ├── main_menu.*
│       ├── game.*
│       ├── game_over.*
│       ├── echo.tscn
│       └── enemy_*.tscn
│
└── assets/
    ├── sprites/
    ├── sounds/
    └── music/
```

---

## 🎮 Game Balance

| Mechanic | Value | Details |
|----------|-------|---------|
| Player Speed | 200 px/s | Base; +15% per upgrade |
| Attack Cooldown | 0.3s | Responsive feel |
| Damage | 10 base | +2 per upgrade |
| Health | 3 base | +1 per upgrade |
| Wave Scaling | +2 enemies | Starts at 3, increases |
| Boss Interval | Every 3 waves | Milestone fights |
| Echo Lifetime | 3 seconds | Time to collect |
| Boost Duration | 8 seconds | Short-term power spike |

---

## 🎯 System Architecture

### Clean Design
- **Separation of Concerns:** Systems don't depend on each other
- **Autoloaded Singletons:** GameState, Constants globally accessible
- **Signal-Based Communication:** Loose coupling between systems
- **Scalable Entity System:** Easy to add new enemies or upgrades

### Key Systems

**GameState** (Global)
- Tracks permanent progression
- Manages current run state
- Handles save/load

**WaveManager**
- Spawns enemies with scaling difficulty
- Manages level progression
- Triggers boss encounters

**EchoSystem**
- Creates collectible echoes on enemy death
- Tracks active echoes
- Manages collection mechanics

**UpgradeManager**
- Maintains upgrade pool
- Applies permanent enhancements
- Tracks run-specific upgrades

---

## 📊 Development Roadmap

### Phase 1: Core Systems ✅
- Game state & progression
- Player movement & combat
- Enemy spawning & AI
- Echo collection mechanics
- Basic UI

### Phase 2: Polish
- [ ] Visual feedback & particles
- [ ] Animation system
- [ ] Sound integration
- [ ] Menu polish

### Phase 3: Content
- [ ] Art assets
- [ ] Audio assets
- [ ] Enemy variety (add 2 more)
- [ ] Boss implementation

### Phase 4: Optimization & Testing
- [ ] Performance tuning
- [ ] Bug fixes
- [ ] Balance iteration
- [ ] Save system reliability

### Phase 5: Steam Integration
- [ ] Steamworks SDK
- [ ] Achievements
- [ ] Cloud saves
- [ ] Overlay support

### Phase 6: Launch
- [ ] Final builds
- [ ] Store page
- [ ] Marketing campaign
- [ ] Day 1 support

---

## 🚀 Building & Testing

### Development Build
```bash
# Open Godot editor
godot project.godot

# Press F5 to play
# Or: Play → Play
```

### Export for Windows
```bash
# Project → Export
# Create Windows Desktop export
# Configure & export as Void_Eater.exe
```

See **BUILD_GUIDE.md** for detailed instructions.

---

## 📈 Design Goals

### Gameplay
✓ **Skill-Based:** React fast, position smart  
✓ **Replayable:** Procedural spawning, multiple builds  
✓ **Satisfying:** Clear feedback, progression feel  
✓ **Tense:** Resource management (echo decisions)  
✓ **Addictive:** "Just one more run" mentality  

### Technical
✓ **Performant:** 60 FPS target at 1280×720  
✓ **Scalable:** Easy to add content  
✓ **Stable:** No crashes or memory leaks  
✓ **Maintainable:** Clean code, clear architecture  

### Commercial
✓ **Attractive:** Eye-catching visuals  
✓ **Accessible:** Clear mechanics, gradual difficulty  
✓ **Marketable:** Unique hook (echo system)  
✓ **Polished:** Professional quality across all aspects  

---

## 🎨 Art & Audio

### Visual Style
- **Genre:** Minimalist Pixel Art (8-bit)
- **Palette:** Dark void + Neon cyan/purple
- **Inspiration:** Risk of Rain, Brotato, Hotline Miami
- **Target:** Professional indie aesthetic

### Sound Design
- **Music:** Lo-fi electronic, hypnotic 100 BPM loop
- **SFX:** Satisfying, punchy, immediate feedback
- **Vibe:** Dark yet engaging, immersive

See **ASSETS.md** for detailed generation prompts.

---

## 🔒 Privacy & Legal

### Data Collection
- **Player Data:** None (single-player only)
- **Save Files:** Local storage + Steam Cloud
- **Telemetry:** Steam metrics only (Valve's terms)

### Licensing
- **Code:** MIT License
- **Assets:** Created specifically for this game
- **Dependencies:** Godot engine (MIT)

---

## 🤝 Contributing

This is a personal/small studio project. Contributions welcome!

### Issues
Report bugs via GitHub Issues with:
- Clear description
- Steps to reproduce
- System info (OS, Godot version)

### Pull Requests
1. Fork repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m "Add amazing feature"`
4. Push: `git push origin feature/amazing-feature`
5. Open Pull Request

---

## 📝 Credits

**Game Design & Development:** [Your Name/Studio]  
**Engine:** Godot 4.3 (https://godotengine.org)  
**Music/SFX:** [Generated/Credited Artists]  
**Art:** [Commissioned/Generated]  

---

## 📞 Support

### Issues & Bugs
- GitHub Issues: [Your repo]
- Email: contact@yourcompany.com
- Discord: [Your server]

### Press & Business
- Email: press@yourcompany.com
- Website: yourwebsite.com
- Twitter: @yourtwitter

---

## 🎓 Resources

### Development
- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Guide](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/)
- [Godot Community](https://godotengine.org/community)

### Game Design
- [Game Feel by Steve Swink](https://www.gamefeelbook.com/)
- [GDC Vault](https://www.gdcvault.com/)
- [Roguelike Design Talks](https://youtu.be/...)

### Publishing
- [Steamworks Documentation](https://partner.steamgames.com/doc/home)
- [Indie Game Postmortems](https://www.gdcvault.com/)

---

## 📅 Release Timeline

- **Alpha (Current):** Core gameplay complete
- **Beta (2-3 weeks):** Art & audio assets integrated
- **Launch (4-5 weeks):** Steam release ready
- **Post-Launch:** Content updates, balance patches

---

## 🎉 Stay Updated

- ⭐ Star this repository
- 👁️ Watch for releases
- 🔔 Follow on social media
- 📧 Join mailing list

---

**Last Updated:** 2026-05-04  
**Version:** 1.0 (Alpha)  
**License:** MIT

---

Made with ❤️ using Godot Engine
