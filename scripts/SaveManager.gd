extends Node

var savePath = "user://saves/test_save.tres" # Have to make sure the saves folder exists
#var aquatic = load("res://base/AquaticArray.tres")

func save():
	var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres").duplicate() 
	
	var gameData = GameData.new()
	gameData.unlockedAquaticArray = unlockedAquatic
	
	print(gameData.unlockedAquaticArray.array)

	ResourceSaver.save(gameData, "user://saves/save.tres")

func loadSave(): 
	var gameData = ResourceLoader.load("user://saves/save.tres")
	
	var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres")
	unlockedAquatic = gameData.unlockedAquaticArray # Overwriting the resource in memory with the save data
	
	
	

#func initializeNew(): # Deletes save specific data and adds starting stuff like the Aquatic you start off with
	#var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres")
	#if len(unlockedAquatic.array) != 0:
		#unlockedAquatic.array.clear()
