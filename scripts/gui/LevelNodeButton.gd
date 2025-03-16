extends TextureButton

signal level_pressed

@export var level : int

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mousePosition = get_global_mouse_position()
		var nodePosition = position
		var radius = get_node("Sprite2D").texture.get_height()
		
		if (mousePosition.x > nodePosition.x - radius and mousePosition.x < nodePosition.x + radius) and (mousePosition.y > nodePosition.y - radius and mousePosition.y < nodePosition.y + radius):
			if PlayerManager.playerStats.levelUnlocked >= level:
				emit_signal("level_pressed", self)
