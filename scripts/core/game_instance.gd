class_name GameInstance extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# I'll make a sprite? based class called touch and then instance them from the main game class
# to handle all of the touch events and everything. This will also make multi-touch support
# and such a lot easier
func _input(event: InputEvent) -> void:
	pass
	# if event is InputEventScreenTouch:
	#	if event.pressed:
	#		print('pressed')
	#	else:
	#		print('released')
	#
	# elif event is InputEventScreenDrag:
	#	print('moving...')
