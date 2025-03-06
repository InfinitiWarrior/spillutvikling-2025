extends Node2D

func _ready() -> void:
	
	#EntityManager.unlock(EntityManager.getAquatic(1))
	#EntityManager.unlock(EntityManager.getAquatic(1))
	SaveManager.loadSave()
	
	
	var unlocked = EntityManager.getUnlockedAquaticArray()
	if unlocked:
		EntityManager.render(unlocked[0])
		EntityManager.renderQueue[0].hello()
		
	unlocked[0].maximumHealth = 5
	print(unlocked[0].maximumHealth)
	SaveManager.save()
	#SaveManager.loadSave()
