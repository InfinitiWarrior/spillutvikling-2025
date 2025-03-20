extends Camera2D

@onready var background = get_parent().get_node("Background")

var previousMousePosition = Vector2.ZERO

var left
var right
var top
var bottom

var cam_left
var cam_right
var cam_top
var cam_bottom

var buffer = 200

func _ready():
	var half_width = (background.texture.get_width() * background.scale.x) / 2
	var half_height = (background.texture.get_height() * background.scale.y) / 2

	left = background.position.x - half_width
	right = abs(background.position.x + half_width - get_viewport_rect().size.x)
	top = background.position.y - half_height
	bottom = background.position.y + half_height + get_viewport_rect().size.y

func _process(delta):
	moveCamera()

func moveCamera():
	var cam_global_position = get_global_position()
	cam_left = cam_global_position.x - get_viewport_rect().size.x / 2
	cam_right = cam_global_position.x + get_viewport_rect().size.x / 2
	cam_top = cam_global_position.y - get_viewport_rect().size.y / 2
	cam_bottom = cam_global_position.y + get_viewport_rect().size.y / 2
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): # Calculating the distance for the camera to move (distanceToMove)
		if not previousMousePosition:
			previousMousePosition = get_global_mouse_position()
		
		var currentMousePosition = get_global_mouse_position()
		
		var distanceToMove = (previousMousePosition - currentMousePosition) / 1.5 # Dividing by 2 to make it slower and reversing it to make it the correct direction
	
		previousMousePosition = currentMousePosition
		
		print(cam_bottom, " ", bottom)
		print(bottom)
		
		if cam_right >= right + buffer:
			position.x -= 10
			return
		if cam_left <= left + buffer:
			position.x += 10
			return

		if cam_top <= top + buffer:
			position.y += 10
			return
		if cam_bottom >= bottom + 1700:
			position.y -= 10
			return
		
		position += distanceToMove

	else: # Resets the mouse position when releasing mouse button left
		if previousMousePosition:
			previousMousePosition = Vector2.ZERO
