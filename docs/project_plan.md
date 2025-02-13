# Tower Defense Roguelite - Project Organization Plan

## Current Project Structure
- Basic Godot project with enemy pathfinding and spawning
- Uses NavigationRegion2D for pathfinding
- Enemies follow touch/drag input
- Basic torch mechanic for visibility
- Timer-based enemy spawning system
- Currently using RigidBody2D for enemy physics

## Technical Requirements
- Godot 4.x
- GDScript
- 2D Physics System
- Navigation System
- Touch Input Support
- Custom Movement System (completed)

## Identified Issues
1. ~~Temporary files need cleanup~~ (Completed)
2. Minimal documentation
3. Basic folder structure could be improved
4. Many placeholder functions
5. No clear separation between core systems
6. ~~Physics-based enemy movement needs refactoring to custom implementation~~ (Completed)

## Task Priority Matrix
### High Priority (P0)
- ~~Convert enemy to custom movement system~~ (Completed)
- ~~Clean up temporary files~~ (Completed)
- Fix scene references
- Document core systems

### Medium Priority (P1)
- Implement code formatting
- Add type hints
- Update README
- Create proper class documentation

### Low Priority (P2)
- Document planned features
- Review project settings
- Add inline comments
- Create API documentation

## Proposed Structure
```
Tower-Defense-Roguelite/
├── assets/
│   ├── textures/       # Current textures
│   ├── audio/          # Future audio files
│   └── fonts/          # Future font files
├── docs/
│   ├── project_plan.md    # This document
│   └── api.md            # Future API documentation
├── scenes/
│   ├── core/           # Core game scenes
│   │   ├── game_instance.tscn
│   │   └── world.tscn
│   ├── entities/       # Game entities
│   │   ├── enemy.tscn
│   │   └── torch.tscn
│   └── ui/            # Future UI scenes
├── scripts/
│   ├── core/          # Core game systems
│   │   ├── game_instance.gd
│   │   └── level.gd
│   ├── entities/      # Entity behaviors
│   │   ├── enemy.gd
│   │   ├── enemy_spawn.gd
│   │   └── torch.gd
│   ├── components/    # Reusable behavior components
│   │   └── movement/  # Custom movement implementations
│   └── autoload/      # Future singleton scripts
└── tests/            # Future test files
```

## Cleanup Tasks

### 1. File Organization (P0)
- [x] Remove temporary files (*.tmp files)
- [x] Create new directory structure
- [x] Move files to appropriate directories
- [x] Update scene references in scripts
Estimated time: 2-3 hours

### 2. Code Organization (P0-P1)
- [ ] Create proper class documentation
- [ ] Implement consistent code formatting
- [ ] Remove unused placeholder functions
- [ ] Add type hints for better code clarity
- [x] Convert enemy to use custom movement system
  - [x] Create movement component system
  - [x] Implement custom physics calculations
  - [x] Migrate from RigidBody2D to CharacterBody2D or Node2D
Estimated time: 8-10 hours

### 3. Documentation (P1-P2)
- [ ] Update README.md with:
  - Project description
  - Setup instructions
  - Basic usage guide
  - Development guidelines
- [ ] Document current features
- [ ] Document planned features from TODO.txt
- [ ] Add inline code documentation
Estimated time: 4-5 hours

### 4. Project Settings (P2)
- [ ] Review and organize project settings
- [ ] Document required Godot version
- [ ] Set up proper version control ignores
Estimated time: 1-2 hours

## Implementation Plan

1. **Phase 1: Cleanup** (Week 1)
   - ✓ Remove temporary files
   - ✓ Create new directory structure
   - ✓ Move files to new locations
   - ✓ Update scene references
   Progress: 100%

2. **Phase 2: Enemy Refactor** (Weeks 1-2)
    - ✓ Create movement component system
    - ✓ Convert enemy to use custom physics
    - ✓ Update enemy spawning system
    - ✓ Test and validate movement behavior
    Progress: 100%

3. **Phase 3: Documentation** (Week 2)
   - Update README
   - Add API documentation
   - Document existing systems
   - Document new movement system
   Progress: 0%

4. **Phase 4: Code Organization** (Week 3)
   - Format existing code
   - Add proper documentation
   - Remove unused code
   - Update import paths
   Progress: 0%

5. **Phase 5: Testing** (Week 3)
   - Verify all scenes load correctly
   - Test enemy spawning and movement
   - Validate torch mechanics
   - Ensure no behavior changes
   - Test custom physics implementation
   Progress: 0%

## Risk Assessment

### High Risk
1. **Custom Movement System Migration**
   - Risk: Breaking existing game mechanics
   - Mitigation: Create parallel implementation, thorough testing before switch
   - Status: Initial implementation complete, testing in progress

2. **Scene Reference Updates**
   - Risk: Breaking scene connections
   - Mitigation: Document all references before moving, automated testing

### Medium Risk
1. **Code Refactoring**
   - Risk: Introducing bugs
   - Mitigation: Incremental changes, unit tests

2. **Directory Restructuring**
   - Risk: Missing file dependencies
   - Mitigation: Careful mapping of dependencies before moving

### Low Risk
1. **Documentation Updates**
   - Risk: Incomplete information
   - Mitigation: Regular reviews, template usage

## Future Considerations

Based on TODO.txt, the following features are planned:
1. ~~Convert enemy to use custom movement/physics system~~ (Completed)
2. Nav mesh baking for random terrain
3. Placeable defenders with roaming behavior
4. Enemy targeting system
5. Touch controls for pan & zoom
6. Defender placement system

The proposed structure accommodates these future features while maintaining clean organization. The new components/movement directory will specifically house the custom movement system for enemies and future defender units.

## Progress Tracking
- [x] Phase 1: Cleanup (100%)
  - Temporary files removed
  - Directory structure organized
  - Files moved to appropriate locations
  - Scene references updated
- [x] Phase 2: Enemy Refactor (100%)
   - Movement component system created
   - Enemy converted to CharacterBody2D
   - Custom physics implemented
   - Testing and validation completed
- [ ] Phase 3: Documentation (0%)
- [ ] Phase 4: Code Organization (0%)
- [ ] Phase 5: Testing (0%)

Overall Project Progress: 35%