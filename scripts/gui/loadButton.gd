extends Button


func _on_button_down() -> void:
	SaveManager.loadSave()
	SceneManager.Map()
