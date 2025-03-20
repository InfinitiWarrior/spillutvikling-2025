extends Control

@onready var RewardVBox: VBoxContainer = $RewardVBox
@onready var RewardScene = load("res://scenes/objects/Reward.tscn")

var rewards = Global.reward
var stats = PlayerManager.playerStats

func _ready():
	if not rewards or not stats:
		return false

	if not isAlreadyCleared():
		if rewards.levelUnlocked:
			stats.levelUnlocked = rewards.levelUnlocked
		
		if rewards.aquaticUnlocked:
			addRewardGUI("CHARACTER: ", rewards.aquaticUnlocked.texture)
			EntityManager.unlock(rewards.aquaticUnlocked)
		
	if rewards.pearls:
		addRewardGUI("Pearls x " + str(rewards.pearls), load("res://sprites/GlobalUI/pearl.png"))
		stats.pearls += rewards.pearls
	
	if rewards.corals:
		addRewardGUI("Corals x " + str(rewards.corals), load("res://sprites/GlobalUI/coral.png"))
		stats.corals += rewards.corals
	
	if rewards.experience:
		addRewardGUI("Exp x " + str(rewards.experience), load("res://sprites/GlobalUI/experience.png"))
		stats.experience += rewards.experience
	
	if rewards.weapon:
		if randi() % 100 < rewards.weaponChance:
			ItemManager.unlock(ItemManager.byId(rewards.weapon.id))
			print(ItemManager.byId(rewards.weapon.id).unlocked)
			
			addRewardGUI("WEAPON x ", rewards.weapon.texture)
	
	SaveManager.save()

func isAlreadyCleared():
	return rewards.levelUnlocked <= stats.levelUnlocked

func addRewardGUI(text : String, texture : Texture):
	var rewardScene = RewardScene.instantiate()
	
	var rewardLabel = rewardScene.get_node("RewardLabel")
	var rewardTexture = rewardScene.get_node("RewardTexture")
	
	rewardLabel.text = text
	rewardTexture.texture = texture
	
	RewardVBox.add_child(rewardScene)
