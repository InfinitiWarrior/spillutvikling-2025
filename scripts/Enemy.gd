class_name Enemy
extends CharacterBody2D

@export var enemyStats : EnemyStats

func _ready():
	#printStats()
	pass

func printStats():
	if enemyStats:
		print("Name: ", enemyStats.name)
		print("Maximum Health: ", enemyStats.maximumHealth)
