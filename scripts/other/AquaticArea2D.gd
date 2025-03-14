extends Area2D


var is_dragging = false
var line : Line2D
var collision_shape : CollisionShape2D

func _ready():
	collision_shape = $CollisionShape2D
	line = Line2D.new()
	line.width = 2
	line.default_color = Color.GREEN  # Default color
	add_child(line)
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_pos = collision_shape.to_local(event.position)
			var rect = collision_shape.shape.get_rect()
			if rect.has_point(local_pos) and event.pressed:
				is_dragging = true
				print("Drag started at: ", event.position)
			elif is_dragging and not event.pressed:
				print("Drag released at: ", event.position)
				is_dragging = false


	if event is InputEventMouseMotion and is_dragging:
		line.clear_points()
		line.add_point(position)
		
		if Global.is_snapped_to_enemies == false:
			line.add_point(get_local_mouse_position())
			line.default_color = Color.GREEN
		if Global.is_snapped_to_enemies == true:
			line.default_color = Color.RED
			print(global_position)
			line.add_point(to_local(Global.enemy_center))
	else:
		line.clear_points()
	
	if is_dragging == false and Global.is_snapped_to_enemies == true:
		Global.is_snapped_to_enemies = false
		print("damage dealt")
