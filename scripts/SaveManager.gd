extends Node

func save():
	var unlockedAquatic = EntityManager.unlockedAquaticArray.duplicate()
	var playerStats = PlayerManager.playerStats.duplicate()
	
	var gameData = GameData.new()
	
	gameData.playerStats = playerStats
	
	print(gameData.playerStats.pearls)
	
	gameData.unlockedAquaticArray = unlockedAquatic
	for aquatic in gameData.unlockedAquaticArray.array:
		var aquaticCopy = aquatic.duplicate()  # This duplicates the entire resource
		gameData.unlockedAquaticArray.array[gameData.unlockedAquaticArray.array.find(aquatic)] = aquaticCopy  # Update with the duplicated version
	
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("user://saves"):
		dir.make_dir("user://saves")

	ResourceSaver.save(gameData, "user://saves/save.tres")
	print("Saved.")

func loadSave():
	var gameData = ResourceLoader.load("user://saves/save.tres")
	EntityManager.unlockedAquaticArray = gameData.unlockedAquaticArray # Overwriting the resource in memory with the save data
	PlayerManager.playerStats = gameData.playerStats
	print("Loaded.")

#func initializeNew(): # Deletes save specific data and adds starting stuff like the Aquatic you start off with
	#var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres")
	#if len(unlockedAquatic.array) != 0:
		#unlockedAquatic.array.clear()
