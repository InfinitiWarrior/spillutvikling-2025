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
		var aquaticScenePath = "res://scenes/aquatics/" + stats + ".tscn"
		var aquaticScene = load(aquaticScenePath)
		var aquatic = aquaticScene.instantiate()
		
		get_tree().current_scene.add_child(aquatic)
		renderQueue.append(aquatic)
		return aquatic
	
	elif type == 1:
		var enemyScenePath = "res://scenes/enemies/" + stats + ".tscn"
		var enemyScene = load(enemyScenePath)
		var enemy = enemyScene.instantiate()
		
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
