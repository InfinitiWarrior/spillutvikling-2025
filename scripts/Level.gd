extends Node
class_name Level

@export var enemies : Array[EnemyStats]

func _ready():
	EntityManager.render(enemies[0], 1)
