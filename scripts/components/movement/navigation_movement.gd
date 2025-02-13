class_name NavigationMovement extends BasicMovement

@onready var navigation_agent: NavigationAgent2D = $"../NavigationAgent2D"

func _ready() -> void:
    super._ready()
    if not navigation_agent:
        push_error("NavigationMovement requires a NavigationAgent2D child node")
        return
    
    # Wait for navigation to be ready
    await get_tree().create_timer(0.1).timeout
    _on_navigation_ready()

# Called when navigation map is ready
func _on_navigation_ready() -> void:
    # Configure NavigationAgent2D properties here if needed
    navigation_agent.path_desired_distance = 4.0
    navigation_agent.target_desired_distance = 4.0

# Override move_to to use navigation
func move_to(target: Vector2) -> void:
    navigation_agent.target_position = target
    super.move_to(target)

func _physics_process(delta: float) -> void:
    if not is_moving or not parent:
        apply_friction(delta)
        return
    
    if navigation_agent.is_navigation_finished():
        stop()
        return
    
    # Get next path position
    var next_path_position = navigation_agent.get_next_path_position()
    var direction = (next_path_position - parent.global_position).normalized()
    
    # Apply acceleration in the movement direction
    var target_velocity = direction * move_speed
    velocity = velocity.move_toward(target_velocity, acceleration * delta)
    
    # Apply the movement
    if parent is CharacterBody2D:
        parent.velocity = velocity
        parent.move_and_slide()
    else:
        parent.global_position += velocity * delta

# Signal handlers
func _on_navigation_path_changed() -> void:
    # Called when the navigation path changes
    pass
