extends Node2D

func _ready() -> void:
	var renderedAquatic = EntityManager.render(EntityManager.getAquatic(1))
		#
	#renderedEnemy.global_position = Vector2(randi_range(0, 800), randi_range(0, 800))
	SaveManager.loadSave()
	
	LevelManager.next().loadScene()
	
	#PlayerManager.playerStats.pearls = 5
	#print(PlayerManager.playerStats.pearls)
	
	#SaveManager.save()
