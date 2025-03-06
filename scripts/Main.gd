extends Node2D

func _ready() -> void:
	#var allAquatics = load("res://player/AllAquatics.tres").allAquatics
	#var unlockedAquatics = load("res://player/UnlockedAquatics.tres")
	
	SaveManager.save()
	SaveManager.loadSave()
