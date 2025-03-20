extends Control

var camera : Camera2D
var nodes : Control

func _ready():
	camera = get_node("MapCamera")
	nodes = get_node("Nodes")

	loadMapState()

func _on_level_pressed(node):
	GlobalUI.visible = false
	LevelManager.byIndex(node.level).loadScene()
	
func loadMapState():
	var levelUnlocked = PlayerManager.playerStats.levelUnlocked

	var enumerate = 1
	for node in nodes.get_children():
		node.connect("level_pressed", Callable(self, "_on_level_pressed"))
		
		if enumerate <= levelUnlocked:
			node.get_node("Sprite2D").texture = load("res://sprites/UI/unlockedCircle.png")
		enumerate += 1
