class_name Enemy extends CharacterBody2D

@export var initial_target_pos: Vector2 = Vector2(150, 500)

@onready var movement = $NavigationMovement

func _ready() -> void:
    movement.move_to(initial_target_pos)

func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        movement.move_to(event.position)
    elif event is InputEventScreenDrag:
        movement.move_to(event.position)
    elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        movement.move_to(event.position)
    elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            movement.move_to(event.position)
