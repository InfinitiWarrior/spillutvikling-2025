class_name Enemy
extends CharacterBody2D

@export var enemyStats : EnemyStats
@onready var health = enemyStats.maximumHealth
@export var healthbar : TextureProgressBar
@onready var animatedSprite = $AnimatedSprite2D

var circle = null

func _ready():
	healthbar.max_value = enemyStats.maximumHealth
	healthbar.value = health
	idle_animate()

func idle_animate():
	animatedSprite.play("idle")

func attack(target):
	move_to_and_back(target, func(): deal_damage(target))

func move_to_and_back(target, onHit : Callable):
	Global.attacking = true
	var startingPos = global_position # Saving the starting position so that the return tween knows where to go, because normally it is queued, so you could use position, but since the tween is created on completion of the first tween, global_position is where it ended, not started
	
	# Moving towards the enemy
	var tween = create_tween()
	tween.tween_property(self, "global_position", target.global_position, 0.8).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN).set_delay(0.1)
	
	tween.finished.connect(func():
		# Running the higher order function after moving towards the enemy is completed
		onHit.call()
		# Moving back to the starting position
		var returnTween = create_tween()
		returnTween.tween_property(self, "global_position", startingPos, 0.5).set_ease(Tween.EASE_OUT)
		returnTween.finished.connect(func():
			Global.attacking = false
		)
	)

func deal_damage(target):
	target.take_damage(enemyStats.power)

func take_damage(damage):
	print("Took ", (damage - enemyStats.defense), " damage")
	health -= damage - enemyStats.defense
	print(health)
	healthbar.value = health
	
	if health <= 0:
		queue_free()

func drawCircle():
	if not circle:
		circle = load("res://scenes/objects/Circle.tscn").instantiate()
	
		add_child(circle)

func removeCircle():
	if circle:
		get_node("Circle").queue_free()
		circle = null
