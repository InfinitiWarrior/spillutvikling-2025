extends Node

var aquaticArray = load("res://base/AquaticArray.tres")
var enemyArray = load("res://base/EnemyArray.tres")

var unlockedAquaticArray = load("res://player/UnlockedAquaticArray.tres")

var renderQueue = []

func unlock(aquaticStats : AquaticStats):
	unlockedAquaticArray.array.append(aquaticStats)
	print(unlockedAquaticArray.array)

func render(stats):
	var aquaticScenePath = "res://scenes/aquatics/" + stats + ".tscn"
	var aquaticScene = load(aquaticScenePath)
	var aquatic = aquaticScene.instantiate()

	get_tree().current_scene.add_child(aquatic)
	renderQueue.append(aquatic)
	return aquatic

func getAquaticArray():
	return aquaticArray.array

func getUnlockedAquaticArray():
	return unlockedAquaticArray.array 

func getEnemyArray():
	return enemyArray.array

func getAquatic(id : int):
	for aquaticEntity in getAquaticArray():
		if aquaticEntity.id == id:
			return aquaticEntity

func getEnemy(id : int):
	for enemyEntity in getEnemyArray():
		if enemyEntity.id == id:
			return enemyEntity


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
