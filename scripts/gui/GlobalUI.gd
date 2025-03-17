extends CanvasLayer

@onready var pearls = $Pearls
@onready var corals = $Corals
@onready var experience = $Experience

@onready var pearlValue = pearls.get_node("Value")
@onready var coralValue = corals.get_node("Value")
@onready var experienceValue = experience.get_node("Value")

func _process(delta):
	experienceValue.text = str(getLevel(PlayerManager.playerStats.experience))
	pearlValue.text = str(PlayerManager.playerStats.pearls)
	coralValue.text = str(PlayerManager.playerStats.corals)

func requiredXP(level: int):
	const BASE_XP: int = 100
	const XP_MULTIPLIER: float = 2
	
	return int(BASE_XP * pow(XP_MULTIPLIER, level - 1))

func getLevel(xp: int) -> int:
	var level := 1
	while xp >= requiredXP(level):
		xp -= requiredXP(level)
		level += 1
	return level
