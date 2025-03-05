class_name UnlockedAquaticArray
extends Resource

@export var array: Array[AquaticStats]

func addAquatic(aquatic : AquaticStats):
	array.append(aquatic)
	print("Added aquatic: ", aquatic.name)
