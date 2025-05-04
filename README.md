# Rhythm Game with Level Editor - A Customizable Music Game Experience

This is a rhythm game built with Godot Engine that features a dynamic level editor, real-time scoring system, and web export capabilities. Players can test their rhythm skills by pressing keys in sync with falling notes while creating and playing custom levels.

The game combines precise timing mechanics with an intuitive scoring system, offering multiple difficulty levels through timing windows (Perfect, Good, Normal, Bad). The built-in level editor allows players to create custom beat maps by recording key presses in real-time while listening to music. The game features a combo system that rewards consistent accurate timing and includes detailed feedback through visual judgment text.

## Repository Structure
```
.
├── export_presets.cfg          # Web export configuration for Godot
├── README.md                   # Project documentation
└── scripts/                    # Core game logic scripts
    ├── falling_key.gd         # Controls falling note behavior and physics
    ├── game_end.gd           # Handles end-game score display
    ├── game_ui.gd            # Manages in-game UI elements and scoring display
    ├── key_listener.gd       # Processes player input and scoring logic
    ├── level_editor.gd       # Implements level creation and playback
    ├── score_press_text.gd   # Handles judgment text display
    ├── signals.gd            # Central signal management for game events
    └── start_screen.gd       # Start screen and level selection logic
```

## Web Version & Blockchain Integration
The game is being exported to HTML5 and integrated into a Next.js application, enabling seamless web browser gameplay. This integration includes blockchain connectivity through the following implementation:

- HTML5 export for browser-based gameplay
- Next.js framework integration for enhanced web functionality
- Blockchain connectivity via Sepolia testnet
- Smart contract integration for game data persistence
- Web3 wallet integration for player authentication

## Usage Instructions
### Prerequisites
- Godot Engine 4.x
- Web browser with WebGL support (for web export)
- Audio output device
### Quick Start
1. Launch the game in Godot Engine
2. Click "Play" in the editor or export and run the game
3. Select a song from the start screen
4. Press the corresponding keys (D, F, J, K) as the notes fall

### More Detailed Examples
#### Playing the Game
```gdscript
# Key mappings
D - Leftmost lane
F - Left middle lane
J - Right middle lane
K - Rightmost lane
```

#### Scoring System
- Perfect: ±20ms timing window (250 points)
- Good: ±40ms timing window (100 points)
- Normal: ±80ms timing window (30 points)
- Bad: ±160ms timing window (-50 points)
- Miss: Note passes without input (Combo Break)

## Data Flow
The game processes input and scoring through a chain of interconnected systems, from key input to visual feedback and score calculation.

```ascii
[Key Input] -> [Key Listener] -> [Score Calculation]
     |              |                    |
     v              v                    v
[Falling Notes] -> [Hit Detection] -> [UI Update]
     |                                  |
     +----------------------------------+
              [Combo System]
```

Component Interactions:
1. Key Listener monitors player input and matches it with falling notes
2. Scoring system calculates accuracy based on timing windows
3. UI updates display current score, combo, and judgment text
4. Signal system manages communication between components
5. Level editor records and plays back note patterns
6. Falling notes move at a consistent speed for timing accuracy
7. Combo system tracks consecutive successful hits