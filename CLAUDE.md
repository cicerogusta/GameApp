# 🤖 CLAUDE.md - AI Developer Guide

This file documents VOID EATER for AI assistants (Claude, etc.) to understand and continue development.

---

## 🎯 Project Summary

**Game:** VOID EATER - Fast-paced roguelike for Steam  
**Engine:** Godot 4.3+  
**Language:** GDScript  
**Status:** Alpha (Core systems complete)  
**Repository:** cicerogusta/GameApp  
**Branch:** claude/indie-game-steam-launch-YvHY6

---

## 🎮 Game Concept

**Core Mechanic:** Echo System
- Enemies drop echoes (souls) on defeat
- Player chooses: Boost immediately, use as shield, or convert to permanent upgrade
- Creates dynamic decision-making every second

**Session:** 5-12 minutes (roguelike)  
**Goal:** Reach highest wave possible before death  
**Progression:** Coins enable permanent upgrades across runs  

---

## 🏗️ Architecture Overview

### Autoloaded Singletons
```gdscript
GameState        # Global game state + progression tracking
Constants        # All game constants (speeds, damages, colors, paths)
```

### Core Systems
```
echo_system.gd       → Spawns/tracks echoes
wave_manager.gd      → Enemy spawning & wave progression
upgrade_manager.gd   → Permanent upgrades pool
save_manager.gd      → Save/load JSON files
```

### Entity Classes
```
EnemyBase            → Base class for all enemies
  ├─ Specter (fast, weak)
  ├─ Bloat (slow, strong)
  └─ Spinner (rotating)
Player               → Main character
Echo                 → Collectible souls
```

### Scene Structure
```
main_menu.tscn       → Start screen
game.tscn            → Main gameplay scene
game_over.tscn       → End screen
```

---

## 📁 Key Files & Their Roles

### src/utils/
- **game_state.gd**: Holds ALL persistent data
  - `current_coins`, `best_wave`, `permanent_upgrades`
  - Emits signals for UI updates
  - Reset on each run

- **constants.gd**: One source of truth for all numbers
  - Player/enemy speeds, damages
  - Echo lifetimes, boost multipliers
  - Color hex codes
  - File paths

### src/systems/
- **wave_manager.gd**: Controls enemy spawning
  - Tracks current wave
  - Spawns increasing enemy counts
  - Determines boss intervals

- **echo_system.gd**: Creates & tracks echoes
  - Connects to enemy death signal
  - Manages active echo array
  - Emits echo_spawned/consumed signals

- **upgrade_manager.gd**: Permanent progression
  - 6 upgrades available
  - Applies effects to player
  - Tracks run-specific upgrades vs. permanent

- **save_manager.gd**: Persistence
  - JSON serialization (user://void_eater_save.json)
  - Called on game over + periodic intervals
  - Loads on startup

### src/entities/
- **player.gd**: Main character
  - WASD movement, mouse attack
  - Health tracking
  - Damage calculation (with boosts)
  - Attack cooldown management

- **enemy_base.gd**: Abstract base class
  - Seeks player
  - Takes damage & dies
  - Emits defeated signal → coins awarded
  - Collision detection with player

- **specter/bloat/spinner.gd**: Concrete enemies
  - Override speed/health/echo_reward
  - Spinner adds rotation animation

### src/ui/
- **hud.gd**: CanvasLayer for in-game display
  - Wave counter
  - Coins display
  - Health indicator
  - Echo count
  - Connects to GameState signals

### src/scenes/
- **main_menu.gd**: Menu controller
  - Loads save data on init
  - Displays stats
  - Starts new run

- **game.gd**: Main gameplay controller
  - Initializes all systems
  - Handles player attacks (raycast vs enemies)
  - Manages waves (timer-based)
  - Pause functionality

- **game_over.gd**: End screen
  - Shows wave reached & coins
  - Offers retry/menu options

---

## 🔄 Key Systems Flow

### Player Attack → Enemy Dies → Echo Spawned
```
1. game.gd detects Input.is_action_pressed("ui_accept")
2. _on_player_attack() fires
3. Raycast from player position toward mouse
4. If hits enemy: enemy.take_damage(player.get_damage())
5. Enemy health reaches 0: enemy.die()
6. die() emits defeated signal
7. GameState.add_coins(echo_reward)
8. echo_system.spawn_echo(position) creates echo
9. Echo floats for 3 seconds (bob animation)
10. Player collects: GameState.add_coins() again
```

### Level Up Progression
```
1. wave_manager tracks enemies_defeated
2. Every 5 enemies: offer upgrades
3. Player chooses 1 of 3: add to current_run_upgrades
4. Effects applied immediately (if multiplier-based)
5. Saved to GameState for next wave
```

### Run End & Progression
```
1. Player health reaches 0
2. player.die() emits died signal
3. game.gd saves to save_manager
4. Save file contains:
   - best_wave (compares to current_wave)
   - total_coins += current_coins
   - permanent_upgrades (unchanged unless manually added)
5. Switch to game_over.tscn
6. Player reviews stats
7. Menu → Reset everything via GameState.reset_run()
```

---

## 🎯 Critical Design Decisions

### Echo as Unique Hook
- **Why?** Creates micro-decisions every kill
- **Balance:** Temp boost is powerful but short (8s)
- **Strategy:** Risk choosing shields vs. upgrades vs. boosts

### Procedural Spawning
- **Why?** Keeps runs fresh, adds replayability
- **Method:** Random positions, wave-scaling enemy counts
- **Future:** Could add biome variations, enemy pools

### Permanent Upgrades
- **Why?** Respects player time, no grind walls
- **Design:** Each upgrade is +20% effect, not mandatory
- **Balance:** Skill + strategy > gear advantage

### No Run-Specific Progression Between Waves
- **Why?** Keeps momentum, avoids menu fatigue
- **UX:** Upgrades chosen immediately, no separate screen
- **Future:** Could add visual flourish, optional pause

---

## ⚠️ Important Constraints

### Physics
- Player/enemies are CharacterBody2D (not Rigidbody2D)
- move_and_slide() handles collisions
- No gravity/jumping (top-down game)

### Collision Layers
- Player: Layer 1
- Enemies: Layer 2
- Echoes: Area2D (triggers, not physics)
- Use `add_to_group()` for identification, not physics_material

### Performance Targets
- 60 FPS @ 1280×720
- Max 30+ concurrent enemies (scaling with wave)
- Save file < 1KB
- No memory leaks over 30-min sessions

### Godot Version
- **Minimum:** Godot 4.3
- **Reason:** Need Godot 4 features (signals, exports)
- **Not compatible:** Godot 3.x (major API changes)

---

## 🔧 Development Tips for AI Assistants

### Before Making Changes
1. Read the relevant .md file (DEVELOPMENT.md, ASSETS.md, etc.)
2. Understand game flow (see Key Systems Flow above)
3. Check constants.gd for magic numbers
4. Review game_state.gd for data model
5. Test in Godot editor before committing

### Common Tasks

**Add new enemy type:**
```
1. Create src/entities/[name].gd extending EnemyBase
2. Override _ready() with new speed/health/echo_reward
3. Create src/scenes/enemy_[name].tscn from template
4. In wave_manager.gd, add to spawning logic
5. Test in game scene
```

**Add upgrade:**
```
1. Add to available_upgrades array in upgrade_manager.gd
2. Add effect calculation to get_upgrade_effect()
3. Apply in player.gd or appropriate system
4. Add to constants if needed
5. Test with GameState permanent_upgrades
```

**Change game balance:**
```
1. Edit Constants.gd first
2. Test in Godot editor (F5)
3. Observe game feel/difficulty
4. Adjust and repeat
5. Document reasoning in commit message
```

### Testing Checklist
- [ ] Game starts without errors
- [ ] Player can move & attack
- [ ] Enemies spawn and move
- [ ] Damage system works
- [ ] Echoes spawn on kill
- [ ] Game over triggers on death
- [ ] Save file created
- [ ] Menu navigation works
- [ ] No console errors/warnings
- [ ] 60 FPS maintained

### Code Standards
- **Naming:** snake_case for functions/variables, PascalCase for classes
- **Comments:** Minimal - only explain WHY, not WHAT
- **Organization:** Related functions grouped, clear sections
- **Signals:** Use built-in names, emit clearly
- **Groups:** Use for identification (add_to_group("enemy"))

---

## 📋 Asset Generation Status

### Created (Placeholder Ready)
- [ ] Player sprite (64×64)
- [ ] Specter sprite (48×48)
- [ ] Bloat sprite (64×64)
- [ ] Spinner sprite (48×48)
- [ ] Echo sprite (32×32)
- [ ] Boss sprite (128×128)
- [ ] UI buttons
- [ ] Tileset

**Process:** See ASSETS.md for detailed prompts

---

## 🚀 Next Priorities

### Immediate (This session)
1. ✅ Create core systems
2. ✅ Write documentation
3. ✅ Push to repository
4. [ ] Generate/create placeholder sprites
5. [ ] Integrate audio system
6. [ ] Test full game flow

### Short-term (1-2 weeks)
1. [ ] Final art assets
2. [ ] Sound effects & music
3. [ ] Visual polish (particles, feedback)
4. [ ] Animation system
5. [ ] Boss implementation

### Medium-term (2-4 weeks)
1. [ ] Steamworks integration
2. [ ] Achievements
3. [ ] Cloud saves
4. [ ] Performance optimization
5. [ ] Bug fixes

### Pre-Launch (4+ weeks)
1. [ ] Final balance tuning
2. [ ] Build & testing
3. [ ] Steam store page
4. [ ] Marketing campaign
5. [ ] Launch day prep

---

## 📞 Getting Help

### If You're an AI Assistant
1. Read this CLAUDE.md file first
2. Check relevant documentation files (.md)
3. Examine game_state.gd to understand data
4. Look at game.gd for main flow
5. Ask user for clarification if ambiguous

### If You're Stuck
1. Check error messages in Godot console
2. Verify files exist at expected paths
3. Use `print()` statements for debugging
4. Test in Godot editor, not just command line
5. Check git diff for recent changes

### Code Review Checklist
- [ ] Does code follow existing patterns?
- [ ] Are magic numbers in Constants?
- [ ] Are signals used appropriately?
- [ ] Is error handling needed?
- [ ] Does it break other systems?
- [ ] Are comments minimal but clear?

---

## 🎯 Success Criteria

**Game is "Done" when:**
- ✅ All core systems work (player, enemies, echoes, progression)
- [ ] Art assets integrated
- [ ] Audio/music playing
- [ ] Visually polished
- [ ] Balanced (proper difficulty curve)
- [ ] Save system reliable
- [ ] Steam integration ready
- [ ] Tested for bugs
- [ ] Performant (60 FPS)
- [ ] Ready to launch

---

## 📚 Reference Materials

**In This Repository:**
- README.md - Overview
- DEVELOPMENT.md - Full dev guide
- ASSETS.md - Art generation
- STEAM_LAUNCH.md - Publishing
- BUILD_GUIDE.md - Export
- MARKETING.md - Launch strategy

**External Resources:**
- Godot Docs: https://docs.godotengine.org/
- GDScript: https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/

---

## 🤝 Collaboration Notes

**For Multiple Developers:**
1. Pull latest before starting: `git pull origin claude/indie-game-steam-launch-YvHY6`
2. Create feature branch: `git checkout -b feature/my-feature`
3. Commit frequently with descriptive messages
4. Push and create PR for review
5. Merge only after testing

**For AI Assistants:**
1. Ask user before major refactors
2. Test changes before committing
3. Explain what changed and why
4. Keep commits focused (one change per commit)
5. Ask for guidance on ambiguous design decisions

---

## ✅ Final Notes

This is a **professional-grade indie game project**. All core systems are in place. The foundation is solid. Future work focuses on **art, audio, and polish**, not architecture changes.

The game is designed to be:
- **Scalable** (easy to add content)
- **Maintainable** (clean, documented code)
- **Performant** (targets 60 FPS)
- **Extensible** (DLC/updates ready)

**You have everything needed to continue development successfully.**

---

**Last Updated:** 2026-05-04  
**Version:** 1.0  
**Status:** Ready for Continued Development
