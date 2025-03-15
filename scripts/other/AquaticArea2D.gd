extends Area2D

@onready var root = LevelManager.getCurrentScene()
var line : Line2D
var collision_shape : CollisionShape2D
var is_dragging = false
var enemy = null
var enemySelected = false

func _ready():
	connectToEnemies()
	collision_shape = $CollisionShape2D
	line = Line2D.new()
	line.width = 2
	line.default_color = Color.GREEN  # Default color
	add_child(line)
	set_process_input(true)
#
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_pos = collision_shape.to_local(event.position)
			var rect = collision_shape.shape.get_rect()
			if rect.has_point(local_pos) and event.pressed:
				is_dragging = true
			elif is_dragging and not event.pressed:
				is_dragging = false

	if is_dragging and get_parent().turnReady:
		line.clear_points()
		line.add_point(position)

		if not enemy:
			enemySelected = false
			line.default_color = Color.GREEN
			
		else:
			line.default_color = Color.RED
			# Because when the screen changes size, the global position isn't actually changing, so we calculate the new coordinates
			if not enemySelected:
				Input.warp_mouse(get_viewport().get_screen_transform().origin + get_viewport().get_screen_transform().basis_xform(enemy.global_position))
				enemySelected = true
				
		line.add_point(get_local_mouse_position())
		
	elif not is_dragging:
		line.clear_points()

	if not is_dragging and enemySelected:
		get_parent().turnReady = false
		enemySelected = false
		enemy.take_damage(10)

func connectToEnemies():
	for enemy in root.enemies:
		var area = enemy.get_node("Area2D")
		area.connect("mouse_hover", Callable(self, "_on_mouse_hover"))

func _on_mouse_hover(enemyObj):
	enemy = enemyObj
