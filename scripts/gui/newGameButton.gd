extends Button


func _on_button_down() -> void:
	EntityManager.unlock(EntityManager.getAquatic(1))
	SceneManager.Map()
