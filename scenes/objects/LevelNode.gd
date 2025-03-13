extends TextureButton

signal level_pressed

var isPressed = false

func _ready():
	print("test")
	

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		emit_signal("level_pressed")
		isPressed = true
