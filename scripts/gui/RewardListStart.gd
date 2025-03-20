extends TextureButton

signal start_button_hover

var level = null

func _on_button_up() -> void:
	SoundManager.click()
	emit_signal("start_button_hover", level)
