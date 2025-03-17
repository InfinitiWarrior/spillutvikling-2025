extends Area2D

signal mouse_hover_self

@onready var root = LevelManager.getCurrentScene()
var line : Line2D
var collision_shape : CollisionShape2D
var is_dragging = false

var enemy = null
var aquatic = null

var enemySelected = false
var aquaticSelected = false

func _ready():
	connectToEnemies()
	connectToAquatics()
	collision_shape = $CollisionShape2D
	line = Line2D.new()
	line.width = 2
	line.default_color = Color.GREEN  # Default color
	add_child(line)
	set_process_input(true)
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _input(event):
	if event is InputEventMouseButton and not Global.attacking:
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
		if not aquatic:
			pass
		
		line.add_point(get_local_mouse_position())
		
	elif not is_dragging:
		line.clear_points()

	if not is_dragging and enemySelected:
		get_parent().turnReady = false
		enemySelected = false
		get_parent().attack(enemy)

	if not is_dragging and aquaticSelected:
		get_parent().turnReady = false
		aquaticSelected = false
		get_parent().Support(aquatic)

func connectToEnemies():
	for enemy in root.enemies:
		var area = enemy.get_node("Area2D")
		area.connect("mouse_hover", Callable(self, "_on_enemy_hover"))

func connectToAquatics():
	for aquatic in EntityManager.renderQueue:
		var area = aquatic.get_node("Area2D")
		area.connect("mouse_hover_self", Callable(self, "_on_aquatic_hover"))

func _on_mouse_entered():
	emit_signal("mouse_hover_self", self)


func _on_enemy_hover(enemyObj):
	enemy = enemyObj

func _on_aquatic_hover(aquaticObj):
	print("HOVERED")
	aquatic = aquaticObj
	print(aquatic)
