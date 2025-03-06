extends Node

func getAquatic(id : int):
	var aquatic = load("res://base/AquaticArray.tres")
	var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres")
	
	for aquaticEntity in aquatic.array:
		print(aquaticEntity.id)
		if aquaticEntity.id == id:
			return aquaticEntity

func unlock(aquaticEntity : AquaticStats):
	var aquatic = load("res://base/AquaticArray.tres")
	var unlockedAquatic = load("res://player/UnlockedAquaticArray.tres")
	aquatic.array.append(aquaticEntity)
	print("Added aquatic: ", aquaticEntity.name)
