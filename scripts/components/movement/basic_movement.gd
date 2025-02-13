class_name BasicMovement extends Node

@export var move_speed: float = 100.0
@export var acceleration: float = 500.0
@export var deceleration: float = 500.0

var parent: Node2D
var velocity: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var is_moving: bool = false

func _ready() -> void:
	parent = get_parent()
	if not parent is Node2D:
		push_error("BasicMovement component must be child of Node2D")

func move_to(target: Vector2) -> void:
	target_position = target
	is_moving = true

func stop() -> void:
	is_moving = false
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_moving or not parent:
		apply_friction(delta)
		return

	var direction = target_position - parent.global_position
	var distance = direction.length()

	if distance < 5.0:  # Close enough to target
		stop()
		return

	direction = direction.normalized()

	# Apply acceleration in the movement direction
	var target_velocity = direction * move_speed
	velocity = velocity.move_toward(target_velocity, acceleration * delta)

	# Apply the movement
	if parent is CharacterBody2D:
		parent.velocity = velocity
		parent.move_and_slide()
	else:
		parent.global_position += velocity * delta

func apply_friction(delta: float) -> void:
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	if parent is CharacterBody2D:
		parent.velocity = velocity
		parent.move_and_slide()
	else:
		parent.global_position += velocity * delta
