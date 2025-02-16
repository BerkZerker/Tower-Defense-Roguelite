extends Node

# Constants
@export var MIN_SEPARATION: float = 40.0  # Minimum distance between entities
@export var SEPARATION_STRENGTH: float = 0.8  # How strongly to separate
@export var MAX_SPEED: float = 180.0  # Maximum movement speed
@export var SMOOTHING: float = 0.2  # Movement smoothing factor (0-1)
@export var NEIGHBOR_RADIUS: float = 100.0  # Radius to check for neighbors

var velocity := Vector2.ZERO
var target_velocity := Vector2.ZERO
var parent: Node2D
var navigation_agent: NavigationAgent2D
var spatial_grid := {}
var grid_cell_size: float
var last_grid_position := Vector2.ZERO

func _ready() -> void:
    parent = get_parent()
    await parent.ready
    navigation_agent = parent.get_node_or_null("NavigationAgent2D")
    if !navigation_agent:
        push_error("FluidMovement requires NavigationAgent2D node on parent")
    name = "FluidMovement"
    
    # Initialize spatial grid
    grid_cell_size = MIN_SEPARATION * 2.0
    _update_spatial_grid()

func _physics_process(delta: float) -> void:
    if !navigation_agent:
        return
        
    # Update spatial grid position if needed
    var current_grid_pos = _get_grid_position()
    if current_grid_pos != last_grid_position:
        _update_spatial_grid()
        last_grid_position = current_grid_pos
        
    # Get next position and calculate base velocity
    var next_pos = navigation_agent.get_next_path_position()
    var to_next = next_pos - parent.global_position
    target_velocity = to_next.normalized() * MAX_SPEED
    
    # Optimized separation using spatial grid
    var separation = Vector2.ZERO
    var nearby_entities = _get_nearby_entities()
    
    for other in nearby_entities:
        if other == parent:
            continue
            
        var diff = parent.global_position - other.global_position
        var distance = diff.length()
        
        if distance < MIN_SEPARATION and distance > 0:
            # Square falloff for more natural separation
            var separation_factor = 1.0 - (distance / MIN_SEPARATION)
            separation += diff.normalized() * separation_factor * separation_factor
    
    if !nearby_entities.is_empty():
        target_velocity += separation.normalized() * SEPARATION_STRENGTH * MAX_SPEED
    
    # Smooth velocity transition
    velocity = velocity.lerp(target_velocity, SMOOTHING)
    
    # Optimized speed clamping using squared length
    var speed_squared = velocity.length_squared()
    if speed_squared > MAX_SPEED * MAX_SPEED:
        velocity = velocity.normalized() * MAX_SPEED
    
    # Apply movement
    if parent.has_method("move_and_slide"):
        parent.velocity = velocity
        parent.move_and_slide()

func _get_grid_position() -> Vector2:
    return (parent.global_position / grid_cell_size).floor()

func _update_spatial_grid() -> void:
    var grid_pos = _get_grid_position()
    
    # Remove from old position
    for cell in spatial_grid.keys():
        spatial_grid[cell].erase(parent)
        if spatial_grid[cell].is_empty():
            spatial_grid.erase(cell)
    
    # Add to new position
    if !spatial_grid.has(grid_pos):
        spatial_grid[grid_pos] = []
    spatial_grid[grid_pos].append(parent)

func _get_nearby_entities() -> Array:
    var grid_pos = _get_grid_position()
    var nearby = []
    
    # Check surrounding cells
    for x in range(-1, 2):
        for y in range(-1, 2):
            var check_pos = grid_pos + Vector2(x, y)
            if spatial_grid.has(check_pos):
                nearby.append_array(spatial_grid[check_pos])
    
    return nearby

func get_velocity() -> Vector2:
    return velocity
