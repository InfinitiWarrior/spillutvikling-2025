extends Area2D

var is_dragging = false
var line : Line2D
var player_position : Vector2

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

var snapped_enemy : Area2D = null
var snap_distance = 50  # Max distance for snapping

func _ready():
	# Set player position correctly
	player_position = position

	# Create Line2D for drawing attack line
	line = Line2D.new()
	line.width = 2
	line.default_color = Color.GREEN
	add_child(line)

	# Enable input
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_click_inside(event.position):
				is_dragging = true
			elif is_dragging and not event.pressed:
				is_dragging = false
				snapped_enemy = null  # Reset snap on release

	elif event is InputEventMouseMotion and is_dragging:
		update_attack_indicator()

func is_click_inside(mouse_pos) -> bool:
	var local_pos = to_local(mouse_pos)
	if collision_shape.shape is RectangleShape2D:
		var rect = collision_shape.shape.get_rect()
		return rect.has_point(local_pos)
	return false

func update_attack_indicator():
	var mouse_local_pos = get_local_mouse_position()

	# Find nearest enemy
	snapped_enemy = get_closest_enemy(global_position + mouse_local_pos)

	# Draw line relative to the player
	line.clear_points()
	line.add_point(Vector2.ZERO)  # Start from player's position (local 0,0)

	if snapped_enemy:
		line.add_point(snapped_enemy.position - position)  # Make it relative
		line.default_color = Color.RED
	else:
		line.add_point(mouse_local_pos)  # Local mouse position relative to player
		line.default_color = Color.GREEN

func get_closest_enemy(mouse_pos) -> Area2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest = null
	var min_distance = snap_distance

	for enemy in enemies:
		var distance = enemy.global_position.distance_to(mouse_pos)
		if distance < min_distance:
			min_distance = distance
			closest = enemy

	return closest
