extends Control

var previousMousePosition = Vector2.ZERO
var camera : Camera2D

func _ready():
	camera = get_node("MapCamera")

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): # Calculating the distance for the camera to move (distanceToMove)
		if not previousMousePosition:
			previousMousePosition = get_global_mouse_position()
		
		var currentMousePosition = get_global_mouse_position()
		
		#print("Current: ", currentMousePosition, "Previous: ", previousMousePosition)
		var distanceToMove = currentMousePosition - previousMousePosition
	
		previousMousePosition = currentMousePosition
		print(distanceToMove)
		camera.position += distanceToMove

	else: # Resets the mouse position when releasing mouse button left
		if previousMousePosition:
			previousMousePosition = Vector2.ZERO
