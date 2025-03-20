extends TextureButton


func _on_button_up() -> void:
	SaveManager.save()
	get_tree().quit()
