class_name Torch extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
    sprite.visible = false
    timer.start()

func _on_timer_timeout() -> void:
    sprite.visible = true
