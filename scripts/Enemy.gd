class_name Enemy
extends CharacterBody2D

@export var enemyStats : EnemyStats
@onready var animatedSprite = $AnimatedSprite2D

func _ready():
	printStats()
	idle_animate()

func printStats():
	if enemyStats:
		print("Name: ", enemyStats.name)
		#print("Maximum Health: ", enemyStats.maximumHealth)

func hello():
	print("hello world enemy")

func idle_animate():
	animatedSprite.play("idle")
