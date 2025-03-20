extends TextureButton


func _on_button_up() -> void:
	SaveManager.save()
	SceneManager.Menu()
