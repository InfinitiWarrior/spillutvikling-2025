extends Node

var weapons = load("res://base/Weapons/Weapons.tres")

func _ready():
	print(weapons.array[0].unlocked)

func getWeapons():
	print(weapons.array[0].unlocked)
