extends Node2D

func _ready() -> void:
		#
	#renderedEnemy.global_position = Vector2(randi_range(0, 800), randi_range(0, 800))
	SaveManager.loadSave()
	EntityManager.unlock(EntityManager.getAquatic(1))
	#EntityManager.unlock(EntityManager.getAquatic(1))
	#EntityManager.unlock(EntityManager.getAquatic(1))
	#EntityManager.unlock(EntityManager.getAquatic(1))
	
	
	
	LevelManager.loadScene()
	
	print(EntityManager.getUnlockedAquaticArray())
	
	#PlayerManager.playerStats.pearls = 5
	#print(PlayerManager.playerStats.pearls)
	
	#SaveManager.save()
