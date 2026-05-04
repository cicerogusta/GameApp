# 🎵 Guia de Integração de Áudio - VOID EATER

## Quick Start (5 minutos)

### Passo 1: Obter Áudios
```
Opção A (RECOMENDADO - 5 min):
1. Acesse Suno.com
2. Gere música com prompt em AUDIO_SOLUTIONS.md
3. Download como MP3
4. Converta para OGG com online-convert.com
5. Salve em assets/music/bg_music_loop.ogg

Opção B (RÁPIDO):
1. Freesound.org
2. Busque "synthwave loop"
3. Download + converta para OGG
```

### Passo 2: Estrutura de Pastas
```bash
cd /home/user/GameApp
mkdir -p assets/music
mkdir -p assets/sounds

# Organize seus áudios:
assets/
├── music/
│   └── bg_music_loop.ogg       (2:00, loopable)
└── sounds/
    ├── attack_sfx.wav          (0.1s zap)
    ├── hit_sfx.wav             (0.15s impact)
    ├── echo_collect_sfx.wav    (0.2s chime)
    ├── levelup_sfx.wav         (0.6s chime)
    ├── boss_appear_sfx.wav     (1.5s tone)
    └── death_sfx.wav           (0.4s whoosh)
```

### Passo 3: Usar AudioManagerPro
```gdscript
# Em game.gd
func _ready():
    # Criar audio manager
    var audio_manager = AudioManagerPro.new()
    add_child(audio_manager)
    
    # Iniciar música de fundo
    audio_manager.play_music("background", -5.0)
    
    # Conectar eventos
    player.attack_performed.connect(func(_pos, _dir):
        audio_manager.play_sfx("attack", 0.0)
    )
```

---

## Setup Completo (20 minutos)

### 1️⃣ Gerar Música

#### Opção A: Suno.com (RECOMENDADO)
```
1. Vá para https://suno.com
2. Clique em "Create"
3. Cole o prompt:

---PROMPT---
Style: Lo-fi Electronic Synthwave
Duration: 2 minutes (loopable)
BPM: 100
Mood: Dark, hypnotic, pulsing
Instruments: Synth pad + pulsing bass + minimal drums
Vibe: Ominous but addictive
Inspiration: Hotline Miami + Brotato OST
Loop: Seamless (no clicks at loop point)

Preferably instrumental, no vocals
Key: Minor
Tempo: Steady 100 BPM
---END PROMPT---

4. Gere 3 variações
5. Escolha a melhor
6. Download como MP3
```

#### Opção B: Pixabay.com
```
1. https://pixabay.com/music/
2. Busque: "synthwave dark"
3. Filtre por duração: 2:00
4. Download direto (free)
```

#### Opção C: OpenGameArt.org
```
1. https://opengameart.org
2. Busque: "game music loop"
3. Escolha estilo neon/synth
4. Download
```

### 2️⃣ Converter Música para OGG

Se baixou MP3, converta:
```
1. Vá para https://online-convert.com
2. Selecione: Audio → OGG
3. Upload seu MP3
4. Download OGG resultante
5. Renomeie para bg_music_loop.ogg
6. Salve em assets/music/
```

### 3️⃣ Coletar Sound Effects

#### Freesound.org (MELHOR)
```
Busque cada um:
1. "8-bit zap attack" → attack_sfx.wav
2. "8-bit hit impact" → hit_sfx.wav
3. "coin collect chime" → echo_collect_sfx.wav
4. "8-bit level up" → levelup_sfx.wav
5. "dark boss appear" → boss_appear_sfx.wav
6. "death whoosh" → death_sfx.wav

Salve todos em assets/sounds/
```

#### Alternativas
```
- Pixabay: https://pixabay.com/sound-effects/
- Zapsplat: https://www.zapsplat.com
- Freepd: https://freepd.com
```

### 4️⃣ Integrar AudioManagerPro

#### Adicionar ao Game.tscn
```
No Godot Editor:
1. Scene → game.tscn aberta
2. Clique em "Game" (root node)
3. Adicione Node novo
4. Type: AudioManagerPro
5. Salve cena
```

#### Conectar ao Game.gd
```gdscript
extends Node2D

var audio_manager: AudioManagerPro

func _ready():
    audio_manager = $AudioManager  # Assumindo nome no scene tree
    
    # Iniciar música
    audio_manager.play_music("background", -5.0)
    
    # Conectar eventos
    player.attack_performed.connect(_on_player_attack)
    
    # Debug
    audio_manager.print_audio_status()

func _on_player_attack(position: Vector2, direction: Vector2):
    audio_manager.play_sfx("attack", 0.0)
    # ... resto do código
```

### 5️⃣ Conectar Todos os SFX

#### Attack SFX
```gdscript
# Em player_improved.gd
func _perform_attack():
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("attack", 0.0)
    # ... resto
```

#### Hit SFX
```gdscript
# Em player_improved.gd / enemy_improved.gd
func take_damage():
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("hit", -3.0)  # Um pouco mais quieto
    # ... resto
```

#### Echo Collect SFX
```gdscript
# Em echo_improved.gd
func collect():
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("echo_collect", 0.0)
    # ... resto
```

#### Level Up SFX
```gdscript
# Em upgrade_manager.gd
func apply_upgrade(upgrade: Dictionary):
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("levelup", 0.0)
    # ... resto
```

#### Boss Appear SFX
```gdscript
# Quando boss spawna
func spawn_boss():
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("boss_appear", 0.0)
    # ... resto
```

#### Death SFX
```gdscript
# Em player_improved.gd
func die():
    var audio_mgr = get_tree().root.get_node("Game/AudioManager")
    if audio_mgr:
        audio_mgr.play_sfx("death", 0.0)
    # ... resto
```

---

## ✅ Checklist de Implementação

### Obtenção de Áudio
- [ ] Música gerada/baixada
- [ ] 6 SFX coletados
- [ ] Convertidos para formatos corretos
- [ ] Organizados em assets/

### Setup no Godot
- [ ] Pasta assets/music criada
- [ ] Pasta assets/sounds criada
- [ ] AudioManagerPro.gd copiado
- [ ] AudioManagerPro adicionado ao scene tree

### Integração nos Scripts
- [ ] player_improved.gd: SFX de attack
- [ ] player_improved.gd: SFX de hit
- [ ] player_improved.gd: SFX de morte
- [ ] echo_improved.gd: SFX de coleta
- [ ] upgrade_manager.gd: SFX de level up
- [ ] Boss script: SFX de aparição

### Testes
- [ ] Música toca ao iniciar jogo
- [ ] Attack SFX ao atacar
- [ ] Hit SFX ao tomar dano
- [ ] Echo SFX ao coletar
- [ ] Level up SFX ao fazer upgrade
- [ ] Volumes estão balanceados
- [ ] Sem delays nos sons
- [ ] Música loopa sem clicks

---

## 🔊 Ajuste de Volumes

### Padrão Recomendado
```gdscript
# Em game.gd _ready()
audio_manager.set_music_volume(0.7)     # 70%
audio_manager.set_sfx_volume(0.8)       # 80%
audio_manager.set_master_volume(0.9)    # 90%
```

### Volumes por SFX
```gdscript
# Volume dB é:
# 0.0 dB = Normal (100%)
# -3.0 dB = 70% (quieter)
# -6.0 dB = 50% (much quieter)
# -12.0 dB = 25% (very quiet)

# Exemplos:
audio_manager.play_sfx("attack", 0.0)        # Normal
audio_manager.play_sfx("hit", -3.0)          # 70%
audio_manager.play_sfx("echo_collect", 0.0)  # Normal
audio_manager.play_sfx("levelup", 2.0)       # +200% (celebratory)
audio_manager.play_sfx("boss_appear", -6.0)  # 50% (atmospheric)
audio_manager.play_sfx("death", 0.0)         # Normal
```

---

## 🐛 Troubleshooting

### Música não toca
```
Checklist:
- [ ] Arquivo em assets/music/bg_music_loop.ogg
- [ ] ResourceLoader.exists() retorna true
- [ ] AudioManagerPro no scene tree
- [ ] audio_manager.play_music() chamado
- [ ] Console: print_audio_status() mostra música
```

### SFX não toca
```
Checklist:
- [ ] Arquivo em assets/sounds/
- [ ] Nome correto (attack_sfx.wav, etc)
- [ ] ResourceLoader.exists() retorna true
- [ ] play_sfx() chamado com nome certo
- [ ] SFX player não está silenciado
```

### Som muito baixo/alto
```
Solução:
- Ajuste volume_db em play_sfx()
- Ajuste bus volumes em AudioManager
- Normalize áudio original se muito baixo
```

### Música tem click no loop
```
Se não fez procedurally:
- Use Audacity (free)
- Edit → Find Silence
- Corte silêncio do start/end
- Exporte como OGG
```

---

## 📊 Formato Recomendado

| Arquivo | Formato | Bitrate | Duração |
|---------|---------|---------|---------|
| Music | OGG | 128 kbps | 2:00-2:30 |
| Attack | WAV | 16-bit 44.1kHz | 0.1s |
| Hit | WAV | 16-bit 44.1kHz | 0.15s |
| Echo | WAV | 16-bit 44.1kHz | 0.2s |
| Level Up | WAV | 16-bit 44.1kHz | 0.6s |
| Boss | WAV | 16-bit 44.1kHz | 1.5s |
| Death | WAV | 16-bit 44.1kHz | 0.4s |

---

## 🎯 Fallback: SFX Procedurais

Se não conseguir áudio real:
```gdscript
# AudioManagerPro automaticamente usa SoundGenerator
# Se arquivo não encontrado:
play_sfx("attack")  # Usa generate_attack_sfx() do SoundGenerator

# Funciona mas soa robótico
# Use como placeholder enquanto gera áudio profissional
```

---

## 📝 Próximas Melhorias

Depois de integrar áudio básico:
```
1. Adicionar variações de SFX
   - attack_1.wav, attack_2.wav, attack_3.wav
   - Toca aleatório para evitar repetição

2. Música dinâmica
   - Música mais intensa em waves altas
   - Fade out ao ficar perto da morte

3. Feedback de áudio avançado
   - Som diferente para crit damage
   - Som diferente para shield
   - Efeitos sonoros on particle burst

4. Audio mixing profissional
   - Compressor no master
   - Reverb na música
   - EQ per channel
```

---

## 🚀 Tempo Estimado

| Tarefa | Tempo |
|--------|-------|
| Gerar música | 5 min |
| Coletar 6 SFX | 10 min |
| Setup AudioManagerPro | 5 min |
| Integração completa | 15 min |
| Testes | 10 min |
| **TOTAL** | **~45 minutos** |

---

## 📞 Suporte

Arquivo de problemas comuns:
- ❌ "Não acha arquivo de áudio"
  - Verificar caminho exato
  - Verificar ResourceLoader.exists()
  
- ❌ "Som muito baixo"
  - Ajustar volume_db
  - Normalizar áudio original
  
- ❌ "Música em loop tem click"
  - Trim silêncio em Audacity
  - Usar OGG em vez de WAV

---

**Pronto para áudio profissional em seu jogo! 🎵**
