extends Node

@onready var weapons = load("res://base/Weapons/Weapons.tres")

func getWeapons():
	return weapons.array

func byId(id : int) -> Weapon:
	for weapon in getWeapons():
		if weapon.id == id:
			return weapon
	return null

func unlock(weapon : Weapon):
	weapon.unlocked = true
