extends CharacterBody2D

@export var initial_target_pos := Vector2(1200, 500)
@export var movement_speed := 180.0
@export var path_update_interval := 0.25

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var fluid_movement: Node
var previous_target := Vector2.ZERO

func _ready() -> void:
    add_to_group("enemies")
    add_to_group("entities")  # Add to entities group for separation logic

    # Create and add fluid movement component
    fluid_movement = preload("res://scripts/components/movement/fluid_movement.gd").new()
    add_child(fluid_movement)

    # Setup initial navigation
    nav_agent.max_speed = movement_speed
    nav_agent.target_position = initial_target_pos
    nav_agent.path_desired_distance = 32.0
    nav_agent.target_desired_distance = 32.0
    nav_agent.avoidance_enabled = true
    nav_agent.radius = 22.0
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

    # Update sprite facing based on movement
    if velocity.x != 0:
        scale.x = -1 if velocity.x > 0 else 1

func _update_pathfinding() -> void:
    # Update target to mouse position
    var mouse_pos = get_global_mouse_position()
    nav_agent.target_position = mouse_pos
    previous_target = mouse_pos
