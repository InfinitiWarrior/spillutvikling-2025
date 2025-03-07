class_name Aquatic
extends CharacterBody2D

@export var aquaticStats : AquaticStats

func _ready():
	printStats()

func printStats():
	if aquaticStats:
		print("Name: ", aquaticStats.name)
		print("Maximum Health: ", aquaticStats.maximumHealth)

var speed = 800.0
func _physics_process(delta):
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input * speed
	move_and_slide()
