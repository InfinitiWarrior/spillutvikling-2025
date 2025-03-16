extends Node
class_name Level

var enemies
var aquatics

@export var rewards : Reward

var enemyToAttack = 0

func _ready():
	initialize()

func _process(delta):
	removeDead()
	
	if gameOver() and not Global.attacking: # Global.attacking waits for the attack to finish
		EntityManager.renderQueue = [] # We reset the renderQueue
		if aquatics.size() > 0: # Victory
			Global.reward = rewards
		SceneManager.RewardScreen()
	
	elif isEnemyTurn() and not Global.attacking: # Global.attacking is used so that two things can't attack at the same time
		enemies[enemyToAttack].attack(aquatics.pick_random())
		enemyToAttack += 1

		if enemyToAttack == enemies.size(): # All enemies have attacked when this is true
			enemyToAttack = 0
			resetTurns()

func gameOver():
	if not enemies or not aquatics:
		return true
	return false

func resetTurns():
	for aquatic in aquatics:
		aquatic.turnReady = true

func isEnemyTurn():
	for aquatic in aquatics:
		if aquatic.turnReady:
			return false
	return true

func removeDead():
	enemies = enemies.filter(func(enemy): return is_instance_valid(enemy))
	aquatics = aquatics.filter(func(aquatic): return is_instance_valid(aquatic))

func initialize():
	enemies = get_node("Enemies").get_children() if get_node("Enemies") else null
	
	placeAquatics()

func placeAquatics():
	for aquatic in EntityManager.getUnlockedAquaticArray():
		EntityManager.render(aquatic.name)
	
	aquatics = EntityManager.renderQueue
	
	var total_aquatics = EntityManager.renderQueue.size()
	
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	
	var aquatics_per_row = 3  # Define how many aquatics per row
	var aquaticMoreThanRow = total_aquatics >= aquatics_per_row
	
	var spacing = screen_width * 0.1 # Space between aquatics
	var rowSpacing = aquatics_per_row * spacing if aquaticMoreThanRow else total_aquatics * spacing # Gets the spacing depending on whether we have a full row or not
	
	var start_x = screen_width * 0.2  # Left padding
	var start_y = (screen_height / 2) - rowSpacing / 2 # Start in the middle vertically

	# Loop through the aquatics in the render queue and place them
	for i in range(total_aquatics):
		var aquatic = EntityManager.renderQueue[i]

		# Calculate the position of the aquatic based on its index
		var row = i % aquatics_per_row
		var col = i / aquatics_per_row

		# Calculate the x and y position
		var x_pos = start_x + col * spacing
		var y_pos = start_y + row * (screen_height * 0.2)  # Space between rows

		# Place the aquatic at the calculated position
		aquatic.global_position = Vector2(x_pos, y_pos)
		add_child(aquatic)  # Make sure it gets added to the scene tree
