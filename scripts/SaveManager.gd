extends Node

var savePath = "user://saves/test_save.tres" # Have to make sure the saves folder exists

var gameData : GameData

func _ready():
	if gameData == null:
		gameData = GameData.new()
		print("Initialized new game data")
		
	gameData.unlockedAquatics = UnlockedAquatics.new()

func save():
	print(gameData)
	if gameData:
		print("Saving to: ", savePath)
		ResourceSaver.save(gameData, savePath)

func load(savePath): 
	var loadedData = ResourceLoader.load(savePath)
	
	if loadedData:
		gameData = loadedData
