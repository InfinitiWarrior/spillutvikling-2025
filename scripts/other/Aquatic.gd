class_name Aquatic
extends CharacterBody2D

@export var aquaticStats : AquaticStats
@onready var animatedSprite = $AnimatedSprite2D
@export var healthbar : TextureProgressBar
var health

var turnReady = true

func _ready():
	aquaticStats = EntityManager.getUnlockedAquatic(aquaticStats.id)
	health = (aquaticStats.maximumHealth + (GlobalUI.getLevelValue() * 10))
	
	healthbar.max_value = health
	healthbar.value = health
	idle_animate()

func idle_animate():
	animatedSprite.play("idle")

func attack(target):
	if not target:
		return
	print("Attack: ", target)
	move_to_and_back(target, func(): deal_damage(target))

func Support(target):
	print("Support: ", target)
	move_to_and_back(target, func(): buff_someone(target))

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
	var power = aquaticStats.power
	if aquaticStats.equippedWeapon:
		power += aquaticStats.equippedWeapon.power

	SoundManager.swish()
	target.take_damage(power)

func take_damage(damage):
	print("Took ", (damage - aquaticStats.defense), " damage")
	health -= (damage - aquaticStats.defense)
	print(health)
	healthbar.value = health
	
	if health <= 0:
		queue_free()

func buff_someone(target):
	target.buffTarget(20 + (GlobalUI.getLevelValue() * 10))

func buffTarget(buff):
	print("Healed ", buff, " health")
	health += buff
	health = (aquaticStats.maximumHealth + (GlobalUI.getLevelValue() * 10)) if health > (aquaticStats.maximumHealth + (GlobalUI.getLevelValue() * 10)) else health
	print(health)
	healthbar.value = health
