class_name Enemy
extends CharacterBody2D

@export var enemyStats : EnemyStats
@onready var health = enemyStats.maximumHealth
@export var healthbar : TextureProgressBar
@onready var animatedSprite = $AnimatedSprite2D

func _ready():
	healthbar.max_value = enemyStats.maximumHealth
	healthbar.value = health
	idle_animate()

func idle_animate():
	animatedSprite.play("idle")

func attack(target):
	target.take_damage(enemyStats.power)

func take_damage(damage):
	print("Took ", damage, " damage")
	health -= damage
	print(health)
	healthbar.value = health
