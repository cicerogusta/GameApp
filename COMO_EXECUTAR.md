# 🎮 Como Executar VOID EATER

## ⚡ Quick Start (2 minutos)

### Pré-requisito: Godot 4.3+
```bash
# Download: https://godotengine.org/download/windows
# Ou instale com:
# Windows: Godot Hub ou direto do site
# Linux: snap install godot
# Mac: brew install godot
```

### Executar o Jogo
```bash
# Via terminal
cd /home/user/GameApp
godot project.godot

# Ou no Godot Editor:
# 1. File → Open Project
# 2. Selecione /home/user/GameApp
# 3. Pressione F5 (ou clique ▶️)
```

---

## 🎮 Controles

| Ação | Tecla |
|------|-------|
| Mover Esquerda | A ou ← |
| Mover Direita | D ou → |
| Mover Cima | W ou ↑ |
| Mover Baixo | S ou ↓ |
| Atacar | Mouse Click |
| Pausar | ESC |

---

## 📸 O Que Você Vai Ver

### Menu Principal
```
VOID EATER
(glow cyan pulsante)

Consume. Evolve. Ascend.

Best Wave: 0
Total Coins: 0

[INICIAR JOGO]
[SAIR]
```

### Durante o Jogo
- **Player:** Ponto roxo com tentáculos (controlado)
- **Inimigos:** Esferas cyan (rápidos), quadrados rosa (fortes), estrelas (giram)
- **HUD:** Wave/Coins/Health no canto superior esquerdo
- **Echoes:** Estrelinhas douradas flutuando (coletar = ganhar coins)
- **Feedback Visual:** Screen shake, partículas, animações

### Game Over
```
GAME OVER
(ou NOVO RECORDE!)

Wave Atingida: 5
Moedas Ganhas: 150
Melhor Wave: 5

[TENTAR NOVAMENTE]
[MENU]
```

---

## 🎯 Gameplay Básico

1. Clique em **"INICIAR JOGO"** no menu
2. Use **WASD** para se mover pela tela
3. **Clique do mouse** para atacar inimigos
4. Derrote inimigos para ganhar moedas
5. **Echoes** (dourados) aparecem após vitória
6. Colete echoes para ganhar mais moedas
7. A cada 5 inimigos: escolha um upgrade
8. **ESC** para pausar o jogo
9. Ao morrer: veja seu score e tente novamente

---

## 📊 Métricas Esperadas

```
Performance:
  FPS: 60 (alvo)
  Latência de input: <16ms (muito responsivo)
  Tempo de load: <2 segundos
  Uso de RAM: ~200-300 MB

Gameplay:
  Sessão: 5-12 minutos
  Dificuldade: Progride com waves
  Objetivo: Atingir o máximo de waves
```

---

## ❌ Solução de Problemas

### "Erro: Não encontra os scripts"
```
✅ Solução:
1. Certifique que está na pasta correta:
   /home/user/GameApp
2. Verifique que project.godot existe
3. Tente novamente: godot project.godot
```

### "Tela preta ao abrir"
```
✅ Solução:
1. Aguarde alguns segundos (carregando assets)
2. Se continuar preta, verifique console:
   - View → Toggle Bottom Panel
   - Procure por erros em vermelho
```

### "Jogo roda mas sem sprites coloridos"
```
✅ Esperado!
- Sprites são gerados proceduralmente em código
- Você verá formas simples com cores
- Tudo funciona, apenas placeholder visual
- Ver: VISUAL_AUDIO_ENHANCEMENTS.md
```

### "Sem som"
```
✅ Esperado!
- Audio framework está pronto
- SFX são gerados proceduralmente (sons robóticos)
- Para áudio profissional: Ver AUDIO_INTEGRATION_GUIDE.md
```

---

## 🔧 Opções de Execução

### Opção 1: Godot Editor (Recomendado)
```bash
godot project.godot
# Depois pressione F5
```
**Vantagens:** Fácil, pode editar em tempo real

### Opção 2: Terminal Direto
```bash
godot --run project.godot
```
**Vantagens:** Rápido, sem abrir editor

### Opção 3: Build Executável (Windows)
```bash
# No Godot Editor:
# 1. Project → Export
# 2. Selecione Windows Desktop
# 3. Configure e exporte

# Depois execute:
./build/Void_Eater.exe
```
**Vantagens:** Pode rodar sem Godot instalado

---

## 📁 Estrutura do Projeto

```
GameApp/
├── project.godot          ← Arquivo do projeto
├── README.md              ← Este arquivo
├── DEVELOPMENT.md         ← Guia técnico
├── ASSET.md               ← Prompts para IA art
├── src/                   ← Código-fonte
│   ├── entities/          ← Player, Enemies, Echoes
│   ├── systems/           ← Game logic
│   ├── scenes/            ← Cenas (tscn files)
│   └── ui/                ← Menus e HUD
└── assets/                ← Sprites, áudio, etc
    ├── music/             ← Música de fundo
    └── sounds/            ← SFX
```

---

## 🎮 Primeiros Passos

```
Primeira execução:
1. Abre menu principal (VOID EATER)
2. Clique em "INICIAR JOGO"
3. 3 inimigos aparecem
4. Use WASD para esquivar/atacar
5. Clique para atacar
6. Derrote todos → próxima wave com mais inimigos
7. Morte = Game Over
8. Veja score e tente novamente

Objetivo:
  - Atingir o máximo de waves possível
  - Cada wave = +1 dificuldade
  - Coins persistem entre runs
  - Compre upgrades permanentes
```

---

## 📚 Documentação Disponível

| Documento | Descrição |
|-----------|-----------|
| **README.md** | Visão geral do projeto |
| **DEVELOPMENT.md** | Guia técnico completo |
| **ASSETS.md** | Prompts para gerar arte |
| **VISUAL_AUDIO_ENHANCEMENTS.md** | Sistema visual/áudio |
| **AUDIO_INTEGRATION_GUIDE.md** | Como integrar som real |
| **STEAM_LAUNCH.md** | Publicação na Steam |
| **BUILD_GUIDE.md** | Como fazer build |
| **MARKETING.md** | Estratégia de lançamento |
| **CLAUDE.md** | Guia para AI developers |

---

## 🚀 Próximos Passos (Após Primeira Gameplay)

1. **Integrar Áudio Real** (20 min)
   - Ver: AUDIO_INTEGRATION_GUIDE.md
   - Use Suno.com para música
   - Freesound.org para SFX

2. **Adicionar Mais Conteúdo**
   - 2 novos tipos de inimigos
   - Boss encounter
   - Mais upgrades

3. **Balance & Polish**
   - Ajustar dificuldade
   - Fine-tune timings
   - Testar gameplay

4. **Preparar para Steam**
   - Build para Windows
   - Criar store page
   - Marketing

---

## 💡 Dicas de Gameplay

```
Estratégia:
- Mantenha distância dos inimigos
- Ataque quando estiver seguro
- Colete echoes rapidamente (desaparecem em 3s)
- A cada upgrade, escolha boost de dano ou velocidade
- Esquive ao invés de lutar quando possível

Meta:
- Primeira sessão: Chegar à wave 3
- Segunda sessão: Chegar à wave 5
- Terceira sessão: Chegar à wave 7+
- Objetivo: Bater seu record pessoal
```

---

## 🐛 Debug Mode

Para ver informações técnicas:

```gdscript
# Adicione em game.gd _ready():
print("✅ Game initialized")
print("Player: ", player)
print("Wave Manager: ", wave_manager)
print("Audio Status: ")
if has_node("AudioManager"):
    $AudioManager.print_audio_status()
```

---

## 📞 Suporte / Problemas

Se encontrar algum bug:

1. **Anote exatamente o que aconteceu**
2. **Verifique console** (View → Toggle Bottom Panel)
3. **Procure por erros em vermelho**
4. **Relate o erro com contexto**

Erros comuns documentados em:
- BUILD_GUIDE.md (problemas de compilação)
- AUDIO_SOLUTIONS.md (problemas de áudio)
- VISUAL_AUDIO_ENHANCEMENTS.md (problemas visuais)

---

## 🎯 Resumo Rápido

```
Executar:           godot project.godot (F5)
Mover:              WASD
Atacar:             Mouse Click
Pausar:             ESC
Objetivo:           Máxima de waves
Duração:            5-12 minutos por sessão
Progresso:          Persiste entre sessions
Próximo:            Integrar áudio real
```

---

## 🏆 Próximas Melhorias

Já implementado:
- ✅ Gameplay funcional
- ✅ UI profissional
- ✅ Visual feedback (hit, partículas)
- ✅ Sistema de save/load
- ✅ Pausa (ESC)

Pronto para implementar:
- ⏳ Áudio real (SFX + Música)
- ⏳ Boss encounter
- ⏳ Mais tipos de inimigos
- ⏳ Polish final

---

**Pronto para jogar? 🎮 Execute o jogo e bom divertimento!**

---

## 📖 Referências Rápidas

```bash
# Abrir projeto
godot project.godot

# Executar
godot --run project.godot

# Build Windows
godot --headless --export-release "Windows Desktop" build/Void_Eater.exe

# Ver git log
git log --oneline -10

# Status do repositório
git status
```

---

**Versão:** 1.0  
**Data:** 2026-05-04  
**Status:** Pronto para Jogar ✅
