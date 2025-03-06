extends Node2D

func _ready() -> void:
	#var allAquatics = load("res://player/AllAquatics.tres").allAquatics
	#var unlockedAquatics = load("res://player/UnlockedAquatics.tres")
	
	EntityManager.unlock(EntityManager.getAquatic(1))
