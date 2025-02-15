extends Node

# Fluid movement parameters
@export var mass := 0.8  # Lower mass for faster response
@export var damping := 0.92  # Higher damping for stability
@export var stiffness := 0.6  # Higher stiffness for better targeting
@export var rest_length := 150.0  # Match movement speed
@export var separation_radius := 40.0  # Tighter grouping
@export var separation_strength := 30.0  # Gentler separation

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var target_pos := Vector2.ZERO
var parent: Node2D

func _ready() -> void:
    parent = get_parent()

func _physics_process(delta: float) -> void:
    # Calculate desired velocity towards target position
    var displacement = target_pos - parent.position
    var distance = displacement.length()
    var direction = displacement.normalized()
    
    # Scale desired velocity based on distance
    var desired_speed = min(distance, rest_length * 2.0)
    var desired_velocity = direction * desired_speed
    
    # Calculate basic separation from nearby enemies
    var separation = _calculate_separation()
    
    # Spring force for soft body effect
    var spring_force = (desired_velocity - velocity) * stiffness
    
    # Combine forces
    acceleration = (spring_force + separation) / mass
    velocity += acceleration
    velocity *= damping

func _calculate_separation() -> Vector2:
    var separation = Vector2.ZERO
    var nearby_count = 0

    # Get all enemies in the scene
    var enemies = get_tree().get_nodes_in_group("enemies")

    for enemy in enemies:
        if enemy != parent:
            var distance = parent.position.distance_to(enemy.position)
            if distance < separation_radius:
                var push_vector = parent.position - enemy.position
                separation += push_vector.normalized() * (1.0 - (distance / separation_radius))
                nearby_count += 1

    if nearby_count > 0:
        separation = separation.normalized() * separation_strength

    return separation

func set_target(pos: Vector2) -> void:
    target_pos = pos

func apply_force(force: Vector2) -> void:
    velocity += force / mass

func reset_forces() -> void:
    velocity = Vector2.ZERO
    acceleration = Vector2.ZERO

func get_velocity() -> Vector2:
    return velocity
