extends Node2D

func _ready() -> void:
		#
	SaveManager.loadSave()
	EntityManager.unlock(EntityManager.getAquatic(1))
	
	SceneManager.Map()
	#SaveManager.save()
