extends Area2D

func _ready():
	# Connect the signals to the corresponding functions
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	Global.is_snapped_to_enemies = true 
	Global.enemy_center = get_parent().global_position # Get the center of the Area2D (enemy's position)
	Input.warp_mouse(Global.enemy_center)  # Move the cursor to the enemy's center
	print("Cursor moved to enemy at ", Global.enemy_center)

func _on_mouse_exited():
	emit_signal("cursor_snapped", Vector2.ZERO)  # Reset cursor snapping when it exits
	print("Cursor exited enemy area!")
	Global.is_snapped_to_enemies = false
