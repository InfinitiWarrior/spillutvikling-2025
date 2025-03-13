extends Control

var previousMousePosition = Vector2.ZERO

var camera : Camera2D
var nodes : Control

func _ready():
	camera = get_node("MapCamera")
	nodes = get_node("Nodes")
	
	var levelUnlocked = EntityManager.playerStats.levelUnlocked
	
	for node in nodes.get_children():
		print(node)
		node.connect("level_pressed", Callable(self, "_on_level_pressed"))
	#loadMapState()

func _on_level_pressed():
	print("Button pressed")

func _process(delta):
	moveCamera()
	
func loadMapState():
	var levelUnlocked = EntityManager.playerStats.levelUnlocked

	#var enumerate = 1
	#for node in nodes.get_children():
		#if enumerate == levelUnlocked:
			#node.get_node("Sprite2D").texture = load("res://sprites/unlockedCircle.png")
		#
		#node.pressed.connect(_on_button_pressed.bind(node))
#
		#enumerate += 1

func moveCamera():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): # Calculating the distance for the camera to move (distanceToMove)
		if not previousMousePosition:
			previousMousePosition = get_global_mouse_position()
		
		var currentMousePosition = get_global_mouse_position()
		
		var distanceToMove = (previousMousePosition - currentMousePosition) / 1.5 # Dividing by 2 to make it slower and reversing it to make it the correct direction
	
		previousMousePosition = currentMousePosition
		
		camera.position += distanceToMove

	else: # Resets the mouse position when releasing mouse button left
		if previousMousePosition:
			previousMousePosition = Vector2.ZERO


func _on_locked_node_button_down() -> void:
	print("test")
