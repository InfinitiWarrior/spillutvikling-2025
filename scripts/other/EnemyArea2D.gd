extends Area2D

func _ready():
	# Connect the signals to the corresponding functions
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	Global.is_snapped_to_enemies = true
	
	# Because when the screen changes size, the global position isn't actually changing, so we calculate the new coordinates
	var screen_pos = get_viewport().get_screen_transform().origin + get_viewport().get_screen_transform().basis_xform(global_position)
	Global.enemy_center = global_position


	Input.warp_mouse(screen_pos)
	print("Cursor moved to enemy at ", screen_pos)
	print(Global.enemy_center)

func _on_mouse_exited():
	print("Cursor exited enemy area!")
	Global.is_snapped_to_enemies = false
