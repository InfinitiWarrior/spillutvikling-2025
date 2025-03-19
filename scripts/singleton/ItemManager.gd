extends Node

var weapons = load("res://base/Weapons/Weapons.tres")

func _ready():
	pass

func getWeapons():
	print(weapons.array[0].unlocked)
