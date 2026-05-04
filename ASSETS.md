# 🎨 VOID EATER - Asset Generation Guide

## How to Use This Document

For each asset, use the prompt with an AI image generator (Midjourney, DALL-E, Stable Diffusion, etc.)

**Export Settings:**
- Format: PNG with transparency
- Resize to specified resolution
- Place in `assets/sprites/` folder

---

## 🎮 PLAYER CHARACTER

**File:** `player_void_eater.png`  
**Resolution:** 64×64 px (2x scale)  
**Animation Frames:** 4 frames (idle bob, left, right, attack)

### Prompt
```
Minimalist pixel art 64x64, 8-bit style.
A small GLOWING abstract creature with ONE large eye (electric blue #00d9ff).
Body is DARK PURPLE (#9d00ff) with 3 flowing tentacles.
Add BRIGHT GLOW AURA around the eye.
Transparent background.
Style: Risk of Rain meets Brotato, minimalist alien.
Colors ONLY: #1a1a2e (dark), #00d9ff (cyan), #9d00ff (purple)
```

### Frames to Create
- Frame 1: Idle (eye slightly larger)
- Frame 2: Moving left (tentacles to left)
- Frame 3: Moving right (tentacles to right)  
- Frame 4: Attacking (glow intensified, eye larger)

---

## 👾 ENEMIES

### 1. SPECTER (Fast Weak Enemy)

**File:** `enemy_specter.png`  
**Resolution:** 48×48 px  
**Frames:** 2 frames (idle, moving)

#### Prompt
```
Pixel art 48x48, 8-bit minimalist.
FAST GHOST-LIKE entity, sphere shape.
Color: BRIGHT CYAN (#00d9ff).
Add trailing comet effect (fading cyan behind).
Transparent background.
Style: Simple, clean, menacing speed effect.
```

---

### 2. BLOAT (Slow Strong Enemy)

**File:** `enemy_bloat.png`  
**Resolution:** 64×64 px  
**Frames:** 2 frames (idle, moving)

#### Prompt
```
Pixel art 64x64, 8-bit minimalist.
LARGE BULBOUS creature, square-ish shape.
Color: HOT PINK (#ff006e).
Add PULSING GLOW effect (darker magenta outline).
Visible "mouth" or center void (dark).
Threatening appearance, slower movement.
Transparent background.
```

---

### 3. SPINNER (Rotating Enemy)

**File:** `enemy_spinner.png`  
**Resolution:** 48×48 px  
**Frames:** 8 frames (rotation animation)

#### Prompt
```
Pixel art 48x48, 8-bit minimalist.
ROTATING multi-pointed STAR shape.
Colors: BRIGHT CYAN (#00d9ff) with PURPLE (#9d00ff) points alternating.
Add GLOW around each point.
Movement: Designed for 8-frame rotation.
Transparent background.
Style: Sharp, angular, dynamic.
```

---

## 🌟 ECHO (Collectible)

**File:** `echo_collectible.png`  
**Resolution:** 32×32 px  
**Frames:** 4 frames (spinning animation)

### Prompt
```
Pixel art 32x32, 8-bit minimalist.
FLOATING SPARKLE/SPIRIT, rotating multi-pointed STAR.
Colors: Gradient from GOLD (#ffff00) to CYAN (#00d9ff).
Add BRIGHT GLOW/AURA effect.
Motion blur trailing effect.
Transparent background.
Style: Magical, collectible feel, very appealing.
```

---

## 🎯 BOSS - ECHO SOVEREIGN

**File:** `boss_echo_sovereign.png`  
**Resolution:** 128×128 px  
**Frames:** 3 frames (idle, attacking, hit)

### Prompt
```
Pixel art 128x128, 8-bit minimalist.
MASSIVE OMINOUS BOSS entity.
Central GIANT GLOWING EYE (cyan #00d9ff).
Radiating tentacles/spikes from body (6-8 points).
Dark VOID-LIKE body (#1a1a2e with purple outline #9d00ff).
Aura of PURPLE and CYAN energy around entire form.
Threatening, powerful, memorable appearance.
Transparent background.
```

---

## 🎨 UI ELEMENTS

### Main Menu Button Set

**File:** `ui_buttons_main_menu.png`  
**Resolution:** 512×128 px (4 buttons, 128×128 each)

#### Prompt
```
Pixel art 512x128, 8-bit minimalist, 4 button sprites.
Each button 128x128:
1. START (cyan glow)
2. OPTIONS (purple glow)
3. CONTINUE (gold glow)
4. QUIT (red glow)

Style: Rounded rectangular buttons.
Background: Dark (#1a1a2e).
Text overlay: White with glow effect.
Hover state: Increased glow/brightness.
Transparent background for individual buttons.
```

---

### Health Bar / UI Icons

**File:** `ui_icons.png`  
**Resolution:** 128×32 px (4 icons, 32×32 each)

#### Prompt
```
Pixel art 128x32, 8-bit minimalist, 4 UI icons.
1. HEART (health) - Red
2. SHIELD (defense) - Blue  
3. SWORD (attack) - Orange
4. SPEED ICON - Cyan

Colors: Bright, distinct, readable.
Style: Minimalist, iconic.
Transparent background.
```

---

## 🗺️ TILESET / ENVIRONMENT

**File:** `tileset_void.png`  
**Resolution:** 256×128 px (tile size: 32×32, so 8×4 grid)

### Tiles Needed
1. Empty void (dark)
2. Obstacle (elevated platform)
3. Edge wall (barrier)
4. Spawn point (marker)
5. Hazard area (warning pattern)
6-8. Variations/details

#### Prompt
```
Pixel art tileset 256x128, 8-bit minimalist.
32x32 tile size (8 tiles wide, 4 tiles tall).
Style: Dark void environment with minimal detail.
Colors: Mostly dark (#1a1a2e) with cyan/purple accents.

Tiles:
1. Empty void floor (dark gradient)
2. Obstacle/platform (elevated, gray)
3. Wall edge (barrier, outlined)
4. Spawn glow (faint cyan)
5. Hazard zone (warning pattern, red)

All on transparent background, grid aligned.
```

---

## 🎵 AUDIO PROMPTS

See separate audio generation guide.

### Music
```
Lo-fi electronic synth, 2:00 loop, 100 BPM.
Dark synthwave meets ambient minimalist.
Pulsing bass + synth pad + minimal drums.
Hypnotic, slightly ominous, addictive.
Reference: Hotline Miami meets Brotato.
```

### SFX
```
Attack: Sharp zap, 500Hz→200Hz frequency sweep (0.1s)
Echo: Sparkle chime, 800Hz→1200Hz ascending (0.3s)
Level Up: 3-note chime C→E→G (0.6s)
Boss: Low 60Hz tremolo buildup (1.5s)
```

---

## 📋 Asset Checklist

### Essential (Minimum Viable)
- [x] Player sprite (1 frame)
- [x] 3 enemy sprites (1 frame each)
- [ ] Echo sprite (1 frame)
- [ ] Boss sprite (1 frame)
- [ ] UI buttons
- [ ] Font/text rendering

### Nice to Have
- [ ] Animated player (4 frames)
- [ ] Animated enemies (2 frames each)
- [ ] Enemy variety (2 more types)
- [ ] Particle effects (hit, death, level up)
- [ ] Tileset
- [ ] Background effects

### Optional (Polish)
- [ ] Screen shake effects
- [ ] Lighting effects
- [ ] Advanced animations
- [ ] Cinematic intro

---

## 🎯 Placeholder Strategy

While waiting for final art:
1. Use solid colored shapes (circles, squares)
2. Add simple glow effects with shaders
3. Implement all gameplay without art
4. Swap sprites when ready
5. Code remains unchanged

### Quick Placeholder Script
```gdscript
# In player.gd _ready():
if not player_sprite:
    var rect = RectangleShape2D.new()
    var sprite = Sprite2D.new()
    sprite.modulate = Constants.COLOR_PURPLE
    add_child(sprite)
```

---

## 💡 Generation Tips

1. **Size**: Specify exact pixel dimensions
2. **Transparency**: Explicitly request transparent background
3. **Colors**: Include hex codes in prompts
4. **Style**: Reference existing games (Risk of Rain, Brotato)
5. **Grid**: For tilesets, ensure alignment to 32×32
6. **Frames**: Request frame-by-frame if animation needed

---

## 📁 Final File Structure

```
assets/
├── sprites/
│   ├── player_void_eater.png
│   ├── enemy_specter.png
│   ├── enemy_bloat.png
│   ├── enemy_spinner.png
│   ├── echo_collectible.png
│   ├── boss_echo_sovereign.png
│   ├── ui_buttons_main_menu.png
│   ├── ui_icons.png
│   └── tileset_void.png
│
├── sounds/
│   ├── sfx_attack.wav
│   ├── sfx_echo_collect.wav
│   ├── sfx_levelup.wav
│   ├── sfx_boss_appear.wav
│   ├── sfx_hit.wav
│   └── sfx_death.wav
│
└── music/
    └── bg_music_loop.ogg
```

---

**Last Updated:** 2026-05-04  
**Status:** Ready for Generation
