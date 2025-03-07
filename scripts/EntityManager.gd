extends Node

var playerStats = load("res://player/PlayerStats.tres")

var aquaticArray = load("res://base/AquaticArray.tres")
var enemyArray = load("res://base/EnemyArray.tres")

var unlockedAquaticArray = load("res://player/UnlockedAquaticArray.tres")

var renderQueue = []
var enemyRenderQueue = []

func getAquatic(id : int):
	for aquaticEntity in getAquaticArray():
		if aquaticEntity.id == id:
			return aquaticEntity

func getEnemy(id : int):
	for enemyEntity in getEnemyArray():
		if enemyEntity.id == id:
			return enemyEntity

func unlock(aquaticStats : AquaticStats):
	unlockedAquaticArray.array.append(aquaticStats)

func render(stats, type=0):
	if type == 0:
		var aquaticScene = load("res://scenes/Aquatic.tscn")
		var aquatic = aquaticScene.instantiate()
		aquatic.get_node("Sprite2D").texture = stats.texture
		aquatic.aquaticStats = stats
		
		get_tree().current_scene.add_child(aquatic)
		renderQueue.append(aquatic)
		return aquatic
	
	elif type == 1:
		var enemyScene = load("res://scenes/Enemy.tscn")
		var enemy = enemyScene.instantiate()
		enemy.get_node("Sprite2D").texture = stats.texture
		enemy.enemyStats = stats
		
		get_tree().current_scene.add_child(enemy)
		enemyRenderQueue.append(enemy)
		return enemy

func getAquaticArray():
	return aquaticArray.array

func getUnlockedAquaticArray():
	return unlockedAquaticArray.array

func getEnemyArray():
	return enemyArray.array



func printAquaticArray(array="", all=false):
	var arrayObj
	if array == "unlocked":
		arrayObj = getUnlockedAquaticArray()
	else:
		arrayObj = getAquaticArray()
	
	if arrayObj:
		if all:
			for aquatic in arrayObj:
				print(aquatic.name)
		else:
			if array == "unlocked":
				print("UnlockedAquaticArray: ", arrayObj)
			else:
				print("AquaticArray: ", arrayObj)
	else:
		if array == "unlocked": 
			print("Empty array: UnlockedAquaticArray")
		else:
			print("Empty array: AquaticArray")
