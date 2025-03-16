extends Control

@onready var rewardLabel: Label = $RewardLabel
var rewards = Global.reward
var stats = PlayerManager.playerStats

func _ready():
	if not isAlreadyCleared():
		print("LEVEL NOT CLEARED")
		if rewards.levelUnlocked:
			stats.levelUnlocked = rewards.levelUnlocked
		
		if rewards.aquaticUnlocked:
			EntityManager.unlock(rewards.aquaticUnlocked)
	else:
		print("rewards unlocked level ", stats.levelUnlocked)
		print("LEVEL ALREADY CLEARED")
		
	if rewards.pearls:
		stats.pearls += rewards.pearls
	
	if rewards.corals:
		stats.corals += rewards.corals
	
	if rewards.experience:
		print(PlayerManager.playerStats.experience)
		stats.experience += rewards.experience
	
	SaveManager.save()
	
	print(PlayerManager.playerStats.experience)

func isAlreadyCleared():
	return rewards.levelUnlocked < stats.levelUnlocked
