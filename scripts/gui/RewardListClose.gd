extends TextureButton

signal close_button_hover

func _on_button_up() -> void:
	SoundManager.click()
	emit_signal("close_button_hover")
