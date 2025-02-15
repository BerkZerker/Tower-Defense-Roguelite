extends Node2D

@onready var spawn_timer: Timer = $Timer
var enemy_scene: PackedScene = preload("res://scenes/entities/enemy.tscn")

func _on_timer_timeout() -> void:
    var enemy = enemy_scene.instantiate()
    add_child(enemy)
