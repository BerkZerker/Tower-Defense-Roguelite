# Tower Defense Roguelite

A roguelite tower defense game built with Godot 4, featuring dynamic enemy pathfinding and procedural elements.

## Features

Current:
- Enemy pathfinding using NavigationRegion2D
- Touch-based controls for enemy targeting
- Timer-based enemy spawning system
- Basic torch mechanic for visibility
- Tile-based terrain system

Planned:
- Custom physics-based enemy movement
- Nav mesh baking for random terrain generation
- Placeable defenders with roaming behavior
- Enemy targeting system
- Touch controls for pan & zoom
- Dynamic defender placement system

## Project Structure

```
Tower-Defense-Roguelite/
├── assets/           # Game assets (textures, audio, fonts)
├── docs/            # Project documentation
├── scenes/          # Godot scene files
│   ├── core/       # Core game scenes
│   ├── entities/   # Game entities
│   └── ui/        # User interface scenes
└── scripts/         # GDScript files
    ├── core/       # Core game systems
    ├── entities/   # Entity behaviors
    ├── components/ # Reusable components
    └── autoload/   # Singleton scripts
```

## Development

### Requirements
- Godot 4.x

### Setup
1. Clone the repository
2. Open the project in Godot 4
3. Run the project from the editor

## Controls
- Touch/click to set enemy target position
- (More controls coming soon)

## Contributing

This project is currently in early development. Please refer to docs/project_plan.md for the roadmap and planned features.

## License

Copyright © 2024 Sam Berkebile. All rights reserved.
