extends Control

var previousMousePosition = Vector2.ZERO

var camera : Camera2D
var nodes : Control

func _ready():
	camera = get_node("MapCamera")
	nodes = get_node("Nodes")

	loadMapState()

func _on_level_pressed(node):
	GlobalUI.visible = false
	LevelManager.byIndex(node.level).loadScene()

func _process(delta):
	moveCamera()
	
func loadMapState():
	var levelUnlocked = PlayerManager.playerStats.levelUnlocked

	var enumerate = 1
	for node in nodes.get_children():
		node.connect("level_pressed", Callable(self, "_on_level_pressed"))
		
		if enumerate <= levelUnlocked:
			node.get_node("Sprite2D").texture = load("res://sprites/UI/unlockedCircle.png")
		enumerate += 1

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
