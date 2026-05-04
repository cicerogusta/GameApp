# 🚀 VOID EATER - Steam Launch & Publishing Guide

## 📋 Pre-Launch Checklist

### 1. Steamworks Setup ✅
- [ ] Create Steamworks developer account ($100 USD)
- [ ] Complete application form for publishing
- [ ] Receive App ID from Valve
- [ ] Create Company record (if new developer)

### 2. Game Configuration
- [ ] Set game title: "VOID EATER"
- [ ] Set publisher: Your company name
- [ ] Set developer: Your name/studio
- [ ] Set release date
- [ ] Set game type: Game (not DLC/Expansion)

### 3. Store Page Setup
- [ ] Category: Action, Indie, Roguelike
- [ ] Languages: English (minimum)
- [ ] Pricing: $4.99 USD (recommended for indie roguelike)
- [ ] Regional pricing adjustments
- [ ] Review copy granted to Valve

### 4. Build Preparation
- [ ] Game fully tested and bug-free
- [ ] Performance optimized (target 60 FPS at 1280×720)
- [ ] Save system verified
- [ ] No crash logs or unhandled exceptions

---

## 🎮 Steamworks Integration

### Basic Integration (Required for 2026)

#### 1. Download Steamworks SDK
```bash
# From https://partner.steamgames.com/
# Download latest GodotSteam or use Steamworks SDK directly
```

#### 2. Add to project.godot
```ini
[steamworks]
app_id = 1234567  # Your App ID here
```

#### 3. Implement Achievements

```gdscript
# In game_state.gd
extends Node

var steam_enabled: bool = false

func _ready():
    steam_enabled = Steam.restartAppIfNecessary(APP_ID)

func unlock_achievement(achievement_id: String):
    if steam_enabled:
        Steam.setAchievement(achievement_id)

# Example achievements
# "first_echo" - Collect first echo
# "wave_master_5" - Reach wave 5
# "boss_defeated" - Defeat boss
# "full_upgrade" - Get all permanent upgrades
# "speedrun" - Complete run in under 5 minutes
```

#### 4. Overlay Integration
```gdscript
func _ready():
    if Steam.isSteamRunning():
        Steam.activateGameOverlay("friends")
```

#### 5. Cloud Saves
```gdscript
# Automatically enabled if Steamworks integrated
# Godot handles cloud sync if Steamworks SDK present
# Save file: user://void_eater_save.json
```

---

## 📦 Store Page Details

### Store Title
**VOID EATER**

### Short Description (150 chars)
```
A hypnotic roguelike where you consume souls in an endless void.
Collect echoes, unlock permanent powers, and become unstoppable.
```

### Full Description (1000-1500 chars)
```
VOID EATER is a fast-paced roguelike that combines skill-based 
gameplay with addictive progression systems.

GAMEPLAY
Descend into an endless void, consuming enemies and collecting 
echoes. Each echo presents a choice: boost your power temporarily, 
absorb damage, or convert it into permanent strength.

FEATURES
• Intense 5-12 minute runs with high replayability
• Three unique enemy types with distinct behaviors
• Permanent progression - each run makes you stronger
• Skill-based combat requiring tactical positioning
• Procedural enemy spawning for variety
• Boss encounters every 3 waves
• Rich visual style with minimalist aesthetics

PROGRESSION
Unlock permanent upgrades to damage, speed, health, and more. 
No grind walls - skill and strategy matter most. Every run 
teaches you something new.

"Just one more run..." - Becomes "Just one more run... okay, 
one more after this..."

RECOMMENDED FOR
• Roguelike fans (Risk of Rain, Hades, Brotato)
• Players who love tight, responsive gameplay
• Anyone seeking a "one more run" experience
• Speedrunners looking for optimization challenges

TECHNICAL
• Single-player focus
• No microtransactions
• No ads or DRM beyond Steam
• Auto-save on exit
• Cloud save support
```

### Tags (Select 5)
1. Roguelike
2. Action
3. Indie
4. Fast-Paced
5. Skill-Based

---

## 🎨 Store Page Assets

### Screenshots (Min 5, Max 10)

**Screenshot 1: Main gameplay - Player surrounded by enemies**
```
Prompt: In-game screenshot, player center, 5+ enemies visible,
colorful echoes floating, HUD visible, action-packed.
Resolution: 1920×1080 or 3840×2160
```

**Screenshot 2: Enemy variety showcase**
```
Show 3 enemy types: Specter, Bloat, Spinner in same frame.
```

**Screenshot 3: Progression system - Upgrade selection**
```
Show upgrade menu with 3 options, visual feedback.
```

**Screenshot 4: Boss encounter**
```
Show Echo Sovereign boss, dramatic lighting.
```

**Screenshot 5: Main menu**
```
Clean main menu with stats display.
```

### Capsule Images

**Main Capsule (460×215 px)**
```
Title: "VOID EATER" in bold neon cyan
Subtitle: "Consume. Evolve. Ascend."
Background: Dark void with abstract purple/cyan energy
Center: Stylized eye-creature image
Style: Eye-catching, minimalist, high contrast
```

**Small Capsule (231×87 px)**
```
Same as main but scaled down, readable at small sizes
```

**Hero Image (1920×622 px)**
```
Wide banner image for store page header
Title + tagline + hero art
Dark void background transitioning to cyan/purple energy
```

**Library Images (1920×1080 px)**
```
High-quality in-game screenshot
Shows key gameplay elements
Well-lit, composition focused
```

### Video/Trailer

**Concept:** 30-second launch trailer

**Shot 1 (0-5s):** Calm void, player spawns
**Shot 2 (5-15s):** Combat action montage, enemy defeats, echoes falling
**Shot 3 (15-25s):** Upgrades chosen, progression feeling
**Shot 4 (25-30s):** Title card with tagline

**Audio:** Intense part of background music

---

## 🎬 Marketing Strategy

### Pre-Launch (2 weeks before)

1. **TikTok/YouTube Shorts Campaign**
   - **Hook:** Fast 3-second clip of intense gameplay
   - **Formula:** Combat → Echo collection → Upgrade selection
   - **CTA:** "Wishlist on Steam - link in bio"
   
   **Hashtags:** #IndieGame #Roguelike #GameDev #NewGame #SteamDeck

2. **Community Posts**
   - Discord: Indie game communities
   - Reddit: r/IndieGaming, r/roguelikes
   - Twitter: Game dev community

3. **Influencer Outreach**
   - Send review copies
   - Target 100K+ roguelike streamers
   - Provide press kit (see below)

### Launch Week

1. **Release announcement** across all platforms
2. **Launch day livestream** on Twitch/YouTube
3. **Press kit distribution** to gaming outlets
4. **Community engagement** - Monitor forums, respond to feedback

### Post-Launch (1st Month)

1. **Content updates** (small balance patches)
2. **Community feedback integration**
3. **Streaming program** - Reward streamers
4. **Weekly challenge** ideas for replay value

---

## 📰 Press Kit

Create `PRESSKIT.md` with:

### About VOID EATER
```
VOID EATER is a fast-paced roguelike combining skill-based 
action with addictive progression. Developed by [Your Studio Name].
```

### Key Features (bullet points)
- Hypnotic gameplay loop
- Permanent progression system
- Three unique enemy types
- Boss encounters
- Minimalist art style
- High replayability

### Technical Specs
- Engine: Godot 4.3
- Platform: Windows (Steam)
- Price: $4.99 USD
- Release Date: [Date]
- Dev Team: [Your names]

### Trailer/Video Links
- Launch Trailer: [YouTube Link]
- Gameplay Clip: [YouTube Link]

### Contact
- Email: contact@yourcompany.com
- Website: yourwebsite.com
- Social: Twitter, Discord

### Press Images
- [Link to screenshots folder]
- [Link to logo files]
- [Link to hero images]

---

## 💰 Pricing Strategy

### Recommended: $4.99 USD

**Reasoning:**
- Indie roguelike standard
- Value perception: High content, low price
- Appeal to roguelike enthusiasts
- Competitive with Brotato ($5), below Risk of Rain ($14.99)

### Regional Pricing
- **US:** $4.99
- **EU:** €4.99
- **UK:** £4.29
- **AUS:** $6.95
- **Canada:** $5.99 CAD
- **Japan:** ¥499

### Launch Discount (Optional)
- **Launch Week:** -10% → $4.49
- **Creates urgency**
- **Incentivizes early reviews**

---

## 🎯 Launch Day Checklist

### 24 Hours Before
- [ ] Final build tested
- [ ] Steamworks config verified
- [ ] Store page visible to public
- [ ] Trailer uploaded
- [ ] Social posts scheduled
- [ ] Email list notified (if applicable)

### Launch Day
- [ ] Go live at 10 AM UTC (standard Steam release time)
- [ ] Monitor for crashes/issues
- [ ] Respond to community feedback
- [ ] Promote on social media
- [ ] Monitor concurrent players

### First Week
- [ ] Track player metrics
- [ ] Monitor reviews
- [ ] Fix reported bugs
- [ ] Engage with streamers
- [ ] Iterate based on feedback

---

## 📊 Success Metrics (Post-Launch)

### Short-term (First Month)
- **Sales Goal:** 100+ copies
- **Reviews Goal:** 10+ with 8+ average
- **Peak Concurrent:** 50+ players
- **Day 1 Retention:** 30%+
- **Avg. Session:** 7-12 minutes

### Medium-term (3 Months)
- **Total Sales:** 500+
- **Average Rating:** 8.0+
- **Returning Players:** 40%+
- **Community:** Active Discord/Forum

### Long-term (6+ Months)
- **DLC Ideas:** New enemies, biomes, game modes
- **Sequel Potential:** Based on success
- **Speedrun Community:** Speedrunning.com listing

---

## 🎮 Post-Launch Content Plan

### Week 1-2: Bug Fixes
- Balance tuning
- Performance optimization
- Save file improvements

### Week 3-4: First Update
- New enemy type
- New upgrade
- Balance changes based on data

### Month 2: Major Update
- New biome/environment
- More boss variety
- New music track
- Achievement additions

### Month 3+: Expansion Consideration
- DLC content
- Cosmetics (skins)
- Seasonal events
- Challenge modes

---

## 🔒 Legal/Compliance

### EULA
```
• Single-player game
• Save locally on user's computer
• Cloud backup via Steam
• No ads or tracking beyond Steam's
• Usage data collected by Steam only
```

### Privacy Policy
```
• Game collects no personal data
• Steam collects user data per Steam Agreement
• No third-party tracking
• Save files stored locally + Steam Cloud
```

### Content Rating
- **ESRB:** E10+ (Cartoon violence)
- **PEGI:** 7 (Mild violence)
- **USK:** 6 (Light action)

---

## 📈 Analytics to Track

### Daily
- Concurrent players
- Crash logs
- New reviews
- Wishlist additions

### Weekly
- Total sales
- Average review score
- Player retention rate
- Session average time
- Most-reached wave

### Monthly
- Revenue
- Total players
- Churn rate
- Community growth
- Bug fix effectiveness

---

## 🎓 Resources

### Steamworks
- https://partner.steamgames.com/doc/home
- https://partner.steamgames.com/doc/webapi

### Marketing
- GDC talks on indie marketing
- "Marketing for Indie Game Developers"
- Game dev YouTube channels

### Launch Success Stories
- Risk of Rain devs (GDC postmortem)
- Brotato devs
- Hades (supergiant games)

---

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Ready for Implementation
