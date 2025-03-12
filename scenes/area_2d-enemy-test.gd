extends Area2D

signal cursor_snapped(position)  # Signal to tell the player where to snap

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	var enemy_center = global_position  # Get enemy center
	cursor_snapped.emit(enemy_center)  # Tell player to snap
	print("Cursor snapped to enemy at ", enemy_center)

func _on_mouse_exited():
	cursor_snapped.emit(Vector2.ZERO)  # Reset line
	print("Cursor exited enemy area!")
