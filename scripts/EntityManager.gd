extends Node

var aquaticArray = load("res://base/AquaticArray.tres")
var unlockedAquaticArray = load("res://player/UnlockedAquaticArray.tres")
var renderQueue = []

func getAquatic(id : int):
	for aquaticEntity in getAquaticArray():
		if aquaticEntity.id == id:
			return aquaticEntity

func unlock(aquaticStats : AquaticStats):
	unlockedAquaticArray.array.append(aquaticStats)

func render(aquaticStats : AquaticStats):
	var aquaticScene = load("res://scenes/Aquatic.tscn")
	var aquatic = aquaticScene.instantiate()
	aquatic.get_node("Sprite2D").texture = aquaticStats.texture
	aquatic.aquaticStats = aquaticStats
	
	get_tree().current_scene.add_child(aquatic)
	renderQueue.append(aquatic)
	


func getAquaticArray():
	return aquaticArray.array

func getUnlockedAquaticArray():
	return unlockedAquaticArray.array



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
