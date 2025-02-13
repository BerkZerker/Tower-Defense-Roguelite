extends Node2D

@onready var spawn_timer: Timer = $Timer
var enemy_scene: PackedScene = preload("res://scenes/entities/enemy.tscn")
var num_baddies: int = 0

func _ready() -> void:
    print("EnemySpawn: Ready - Timer autostart:", spawn_timer.autostart, " wait_time:", spawn_timer.wait_time)

func _on_timer_timeout() -> void:
    var enemy = enemy_scene.instantiate()
    add_child(enemy)
    num_baddies += 1
    print("EnemySpawn: Spawned enemy #", num_baddies, " at position ", global_position)
