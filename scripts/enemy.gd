class_name Enemy extends RigidBody2D


@export var ACCELERATION: int = 2500

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var target_pos: Vector2 = Vector2(150, 500)


func _input(event: InputEvent) -> void:

	if event is InputEventScreenTouch:
		target_pos = event.position
	
	elif event is InputEventScreenDrag:
		target_pos = event.position
				
				
func _integrate_forces(state) -> void:
	var direciton = Vector2()
	navigation_agent.get_navigation_map()
	
	navigation_agent.target_position = target_pos
	direciton = navigation_agent.get_next_path_position() - global_position
	direciton = direciton.normalized()
	direciton *= ACCELERATION

	state.apply_force(direciton)
	#
	#if Input.is_action_pressed("ui_up"):
		#state.apply_force(thrust.rotated(rotation))
	#else:
		#state.apply_force(Vector2())
	#var rotation_direction = 0
	#if Input.is_action_pressed("ui_right"):
		#rotation_direction += 1
	#if Input.is_action_pressed("ui_left"):
		#rotation_direction -= 1
	#state.apply_torque(rotation_direction * torque)
