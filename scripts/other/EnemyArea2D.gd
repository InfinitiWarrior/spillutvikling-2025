extends Area2D

signal mouse_hover

func _ready():
	# Connect the signals to the corresponding functions
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	emit_signal("mouse_hover", self.get_parent())

func _on_mouse_exited():
	emit_signal("mouse_hover", null)
	print("Cursor exited enemy area!")
