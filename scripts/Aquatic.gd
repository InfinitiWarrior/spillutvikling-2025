class_name Aquatic
extends CharacterBody2D

@export var aquaticStats : AquaticStats

func _ready():
	printStats()

func printStats():
	if aquaticStats:
		print("Name: ", aquaticStats.name)
		print("Maximum Health: ", aquaticStats.maximumHealth)
		

func hello():
	print("hello world")
