extends CharacterBody2D

@export var initial_target_pos := Vector2(1200, 500)
@export var movement_speed := 150.0  # Reduced for smoother movement
@export var path_update_interval := 0.25  # Increased for less frequent updates

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var fluid_movement: Node
var previous_target := Vector2.ZERO

func _ready() -> void:
    add_to_group("enemies")

    # Create and add fluid movement component
    fluid_movement = preload("res://scripts/components/movement/fluid_movement.gd").new()
    add_child(fluid_movement)

    # Configure fluid movement parameters
    fluid_movement.mass = 0.8  # Lower mass for faster response
    fluid_movement.damping = 0.92  # Higher damping for stability
    fluid_movement.stiffness = 0.6  # Higher stiffness for better targeting
    fluid_movement.rest_length = movement_speed  # Match movement speed
    fluid_movement.separation_radius = 40.0  # Tighter grouping
    fluid_movement.separation_strength = 30.0  # Gentler separation

    # Setup initial navigation
    nav_agent.max_speed = movement_speed
    nav_agent.target_position = initial_target_pos
    nav_agent.path_desired_distance = 24.0  # Smaller distance for more precise pathing
    nav_agent.target_desired_distance = 24.0  # Smaller distance for more precise targeting
    nav_agent.avoidance_enabled = true  # Enable avoidance between agents
    nav_agent.radius = 20.0  # Set appropriate radius for avoidance
    nav_agent.neighbor_distance = 100.0  # Increased neighbor awareness
    previous_target = initial_target_pos

    # Start path update timer
    _setup_path_update_timer()

func _setup_path_update_timer() -> void:
    var timer := Timer.new()
    timer.wait_time = path_update_interval
    timer.timeout.connect(_update_pathfinding)
    timer.autostart = true
    add_child(timer)

func _physics_process(_delta: float) -> void:
    if nav_agent.is_navigation_finished():
        return

    # Get next path position
    var next_pos = nav_agent.get_next_path_position()

    # Calculate direction and distance to target
    var direction = (next_pos - global_position).normalized()
    var distance = global_position.distance_to(next_pos)

    # Update fluid movement with scaled target based on distance
    var target_pos = global_position + direction * min(distance, movement_speed)
    fluid_movement.set_target(target_pos)

    # Get velocity and ensure it's properly scaled
    velocity = fluid_movement.get_velocity()
    if velocity.length() > 0:
        velocity = direction * min(velocity.length(), movement_speed)
        move_and_slide()

func _update_pathfinding() -> void:
    # Update target to mouse position
    var mouse_pos = get_global_mouse_position()
    nav_agent.target_position = mouse_pos

    # Store previous target for next update
    previous_target = mouse_pos
