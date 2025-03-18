extends Node

func save():
	var unlockedAquatic = EntityManager.unlockedAquaticArray.duplicate()
	var playerStats = PlayerManager.playerStats.duplicate()
	var weapons = ItemManager.weapons.duplicate()
	
	var gameData = GameData.new()
	
	gameData.playerStats = playerStats
	
	gameData.unlockedAquaticArray = unlockedAquatic
	for aquatic in gameData.unlockedAquaticArray.array:
		var aquaticCopy = aquatic.duplicate()  # This duplicates the entire resource
		gameData.unlockedAquaticArray.array[gameData.unlockedAquaticArray.array.find(aquatic)] = aquaticCopy  # Update with the duplicated version

	gameData.weapons = weapons
	for weapon in gameData.weapons.array:
		var weaponCopy = weapon.duplicate()  # This duplicates the entire resource
		gameData.weapons.array[gameData.weapons.array.find(weapon)] = weaponCopy  # Update with the duplicated version

	var dir = DirAccess.open("user://")
	if not dir.dir_exists("user://saves"):
		dir.make_dir("user://saves")

	ResourceSaver.save(gameData, "user://saves/save.tres")
	print("Saved.")

func loadSave():
	var gameData = ResourceLoader.load("user://saves/save.tres")
	EntityManager.unlockedAquaticArray = gameData.unlockedAquaticArray # Overwriting the resource in memory with the save data
	PlayerManager.playerStats = gameData.playerStats
	ItemManager.weapons = gameData.weapons
	print("Loaded.")
