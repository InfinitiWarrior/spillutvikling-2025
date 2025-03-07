extends Area2D

var is_dragging = false
var line : Line2D
var player_position : Vector2

# Offset for when the player isn't at (0, 0)
var offset : Vector2

# Area2D CollisionShape2D for detecting the click inside the player
var collision_shape : CollisionShape2D

func _ready():
	# Set the player position and handle offset
	player_position = position
	offset = position  # Keep track of the offset

	# Access the CollisionShape2D from the scene
	collision_shape = $CollisionShape2D

	# Create Line2D for drawing attack line
	line = Line2D.new()
	line.width = 2
	line.default_color = Color.GREEN
	add_child(line)
	
	# Enable input events for this Area2D node
	set_process_input(true)

# Detect mouse button press, move, and release
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Check if the click is within the Area2D's collision shape using get_rect()
			if collision_shape.shape is RectangleShape2D:
				var local_pos = collision_shape.to_local(event.position)
				var rect = collision_shape.shape.get_rect()
				if rect.has_point(local_pos) and event.pressed:
					# Start dragging when clicked inside the Area2D
					is_dragging = true
					print("Drag started at: ", event.position)
				elif is_dragging and not event.pressed:
					# When released, print the attack info and stop dragging
					print("Drag released at: ", event.position)
					is_dragging = false

	if event is InputEventMouseMotion:
		if is_dragging:
			# Update line position while dragging
			line.clear_points()  # Clear previous points
			line.add_point(player_position)  # Adjust for offset by using the player's actual position
			line.add_point(get_local_mouse_position())  # Follow the mouse position
		else:
			line.clear_points()
