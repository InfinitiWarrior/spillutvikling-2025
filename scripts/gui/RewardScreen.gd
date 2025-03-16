extends Control

@onready var rewardLabel: Label = $RewardLabel
var rewards = Global.reward
var stats = PlayerManager.playerStats

func _ready():
	if not isAlreadyCleared():
		if rewards.levelUnlocked:
			print("LEVEL ALREADY CLEARED")
			stats.levelUnlocked = rewards.levelUnlocked
		
		if rewards.aquaticUnlocked:
			EntityManager.unlock(rewards.aquaticUnlocked)
		
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
