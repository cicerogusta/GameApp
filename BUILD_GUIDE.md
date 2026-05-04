# 🔨 VOID EATER - Build & Export Guide

## Prerequisites

1. **Godot 4.3+** installed
   - Download from https://godotengine.org/download/windows
   - Or use Godot Engine Manager (GEM)

2. **Windows 10+** for development/testing

3. **Git** (for version control)

4. **Steam Account** (for Steamworks integration - optional for testing)

---

## 🚀 Development Build

### Step 1: Open Project
```bash
# Using command line
godot -e project.godot

# Or double-click project.godot in file explorer
```

### Step 2: Run Game
```
Press F5 in Godot editor
Or: Play → Play (F5)
```

### Step 3: Test Gameplay
- WASD to move
- Click to attack
- ESC to pause
- Check console for errors (View → Toggle Bottom Panel)

---

## 🔧 Configuration

### Graphics Settings
```
Edit → Project Settings → Display → Window
- Width: 1280
- Height: 720
- Resizable: Checked
- Fullscreen: Checked or Unchecked (choice)
```

### Physics Settings
```
Project Settings → Physics → 2D
- Default Linear Damp: 0.1
- Default Angular Damp: 0.1
- Keep defaults for responsive feel
```

### Audio Settings
```
Project Settings → Audio
- Output Latency (ms): 50 (lower = more responsive)
- Keep defaults for good compatibility
```

---

## 📦 Export for Windows

### Step 1: Create Export Profile

1. **Project → Export**
2. Click **Add** button
3. Select **Windows Desktop**
4. Name it: `Windows_Release`

### Step 2: Configure Windows Export

**Export preset settings:**

```
Export Path: res://build/Void_Eater.exe
Texture Format: Uncompressed
Scene Compression: Zstd
Script Encryption: (leave unchecked)
Script Encryption Key: (skip)
```

**Windows-Specific:**
```
Binary Format:
  - Use script encryption: No
  - Wine: (leave empty for Windows)
  - Signtool: (leave empty for now)

Icons:
  - Windows Icon: (optional, use 256x256 ICO file)
```

**Debugging:**
```
  - Export With Debug: Unchecked
  - Export Pck Separately: Unchecked
```

### Step 3: Export

1. In Export dialog, select **Windows Desktop** preset
2. Click **Export Project**
3. Navigate to desired output folder
4. Click **Save**

**Output:** `Void_Eater.exe` (ready to run)

---

## ✅ Testing the Build

### Step 1: Run Executable
```bash
cd build/
./Void_Eater.exe
```

### Step 2: Test Critical Paths
- [ ] Main menu loads
- [ ] "Start Game" launches gameplay
- [ ] Player moves (WASD)
- [ ] Player attacks (click)
- [ ] Enemies spawn
- [ ] Health decreases on hit
- [ ] Game Over screen appears on death
- [ ] Stats saved (check save file)
- [ ] Return to main menu works

### Step 3: Check Save Files
```
Save location (Windows):
C:\Users\[USERNAME]\AppData\Roaming\Godot\app_userdata\Void_Eater\
```

Check for `void_eater_save.json` file.

---

## 🐛 Debugging Export Issues

### Issue: Game Won't Start
```
Check console for errors:
1. Verify project.godot exists
2. Check main scene path in project.godot
3. Verify all resources are packaged
4. Check for missing script references
```

### Issue: Missing Sounds/Images
```
Ensure assets are in:
- assets/sprites/
- assets/sounds/
- assets/music/

And referenced correctly in code:
load("res://assets/sprites/...")
```

### Issue: Performance Problems
```
In-game diagnostics:
- Enable FPS counter: View → Show FPS
- Profile with Profiler: Debug → Profiler
- Check for infinite loops in _process()
```

---

## 🎯 Final Checklist Before Release

### Code Quality
- [ ] No console warnings/errors
- [ ] All scenes load properly
- [ ] No crash on startup
- [ ] No crash on death/game over
- [ ] Save/load works correctly
- [ ] No memory leaks (run for 30 min+)

### Gameplay
- [ ] Player moves smoothly
- [ ] Attack feels responsive
- [ ] Enemies spawn and move
- [ ] Difficulty progression feels right
- [ ] UI is readable and responsive
- [ ] Music/SFX loop without click
- [ ] No game-breaking exploits

### User Experience
- [ ] Menu navigation smooth
- [ ] Game Over screen informative
- [ ] Pause works correctly
- [ ] Resolution responsive to window size
- [ ] No jarring visual issues

### Performance
- [ ] 60 FPS at 1280×720 minimum
- [ ] <200ms startup time
- [ ] CPU usage <30% idle
- [ ] No frame drops during action
- [ ] Smooth 30+ wave gameplay

---

## 🚀 Steam-Ready Build

### Step 1: Prepare Depot
```
Create folder structure:
build/
├── Void_Eater.exe
├── Void_Eater.pck (auto-generated)
└── README.txt (optional)
```

### Step 2: Steamworks Configuration

**Edit `project.godot` to include:**
```ini
[application]
config/name="Void Eater"
config/version="1.0.0"

[steamworks]
app_id = YOUR_APP_ID_HERE
```

### Step 3: Upload to Steamworks

1. Log into Steamworks partner
2. Navigate to App → All Depots
3. Create Windows depot:
   - Branch: public
   - Content path: `build/` directory
   - Upload files

4. Set platform config:
   - OS: Windows
   - Architecture: x86_64
   - Depot ID: [System generates]

### Step 4: Build Configuration

**In Steamworks:**
```
App Settings → General Installation
- Multi-User: Enabled
- Use Depot: Windows (your depot ID)
- OSList: Windows
```

### Step 5: Build & Test

```
Steam → Create New Build
- Branch: Internal (for testing)
- Product: Void Eater
- Build ID: Auto
- Upload files
```

**Test on machine:**
```bash
# Install from Steam Library (internal branch)
# Launch game
# Verify Steam overlay works
# Check achievements trigger
# Verify cloud saves work
```

---

## 📋 Release Checklist

### Pre-Release
- [ ] Build tested on clean Windows 10+ machine
- [ ] No antivirus false positives
- [ ] Executable code-signed (optional but recommended)
- [ ] All assets included and working
- [ ] Save system functional
- [ ] Steam achievements configured
- [ ] Store page complete and approved by Valve
- [ ] Marketing materials ready
- [ ] Press kit distributed to outlets
- [ ] Influencers have review copies

### Release Day
- [ ] Go live at 10 AM UTC
- [ ] Monitor for crashes
- [ ] Monitor player feedback
- [ ] Have rapid response team ready
- [ ] First patch (bug fixes) on standby

### First Week
- [ ] Daily monitoring of metrics
- [ ] Active community engagement
- [ ] Bug fix patches released as needed
- [ ] Streamer support/promotion
- [ ] Analytics review

---

## 📊 Build Optimization Tips

### Reduce Executable Size
```ini
# In Export settings:
- Compress ZIP: Yes
- Target Brotli: Yes
- Remove Unused Resources: Yes
```

### Improve Startup Time
```gdscript
# Avoid heavy operations in _ready()
# Use deferred initialization:
call_deferred("_initialize_systems")

func _initialize_systems():
    # Heavy setup here
    pass
```

### Better Performance
```gdscript
# Use object pooling for frequently spawned objects:
var enemy_pool: Array = []

func get_enemy():
    if enemy_pool.size() > 0:
        return enemy_pool.pop_back()
    return enemy_scene.instantiate()
```

---

## 🔐 Code Signing (Optional)

For public release, consider code signing:

```bash
# Windows Code Signing Certificate needed
# Use signtool (Windows SDK):

signtool sign /f certificate.pfx /p password /t http://timestamp.server.com Void_Eater.exe
```

**Note:** Requires purchased certificate (~$200-300/year)

---

## 📦 Distribution

### Steam
- Primary distribution platform
- Handles updates automatically
- Cloud saves built-in

### Alternative Platforms
- **GOG**: DRM-free alternative
- **Itch.io**: Direct distribution
- **Personal Website**: Direct sales

---

## 🆘 Troubleshooting

### Build Fails to Export
```
1. Check Output console for errors
2. Verify all scenes are saved (Ctrl+S)
3. Check for syntax errors (Debug → GDScript Errors)
4. Restart Godot and try again
5. Clear build cache: rm -rf .godot/
```

### Game Crashes on Startup
```
1. Check console output
2. Verify main scene in project.godot
3. Check for script errors
4. Verify all resources exist
5. Run from Godot editor to debug
```

### Save File Corruption
```
# Delete corrupted save:
# Windows: C:\Users\[USER]\AppData\Roaming\Godot\app_userdata\Void_Eater\
# Restart game, new save will be created
```

---

## 📈 Version Management

### Versioning Scheme
- Format: MAJOR.MINOR.PATCH
- Example: 1.0.0 (Release), 1.0.1 (Bug fix), 1.1.0 (Feature)

### Update Process
1. Make changes
2. Test thoroughly
3. Update version in project.godot:
   ```
   config/version = "1.0.1"
   ```
4. Git commit and tag:
   ```bash
   git tag -a v1.0.1 -m "Release 1.0.1"
   git push origin v1.0.1
   ```
5. Build and upload to Steam

---

## 📚 Additional Resources

- **Godot Docs:** https://docs.godotengine.org/
- **GDScript Reference:** https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/
- **Steam Documentation:** https://partner.steamgames.com/doc/home
- **Godot Community:** https://godotengine.org/community

---

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Ready for Use
