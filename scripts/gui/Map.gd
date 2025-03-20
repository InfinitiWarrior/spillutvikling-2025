extends Control

var nodes : Control

@onready var rewardListControlNotInstance : PackedScene = preload("res://scenes/objects/RewardList.tscn")
@onready var rewardListItem : PackedScene = preload("res://scenes/objects/RewardListItem.tscn")

var rewardListControl = null

func _ready():
	nodes = get_node("Nodes")

	loadMapState()

func _on_level_pressed(node):
	SoundManager.click()
	
	if rewardListControl:
		return

	rewardListControl = rewardListControlNotInstance.instantiate()
	
	var itemContainer = rewardListControl.get_node("RewardList").get_node("RewardVBoxContainer")
	
	var startButton = rewardListControl.get_node("ButtonContainer").get_node("Start")
	var closeButton = rewardListControl.get_node("ButtonContainer").get_node("Close")
	
	startButton.level = node.level
	
	startButton.connect("start_button_hover", Callable(self, "on_start_button_hover"))
	closeButton.connect("close_button_hover", Callable(self, "on_close_button_hover"))
	
	var rewards = LevelManager.byIndex(node.level).getLevelRewards()
	
	if rewards:
		if rewards.pearls:
			itemContainer.add_child(getRewardListItem(rewards.pearls, load("res://sprites/GlobalUI/pearl.png")))
		if rewards.corals:
			itemContainer.add_child(getRewardListItem(rewards.corals, load("res://sprites/GlobalUI/coral.png")))
		if rewards.experience:
			itemContainer.add_child(getRewardListItem(rewards.experience, load("res://sprites/GlobalUI/experience.png")))
		if rewards.aquaticUnlocked:
			itemContainer.add_child(getRewardListItem(100, rewards.aquaticUnlocked.texture))
	
		rewardListControl.global_position = Vector2(node.global_position.x - 180, node.global_position.y - 250)
		add_child(rewardListControl)
		
		Global.cameraMovable = false

func getRewardListItem(rewardChance, texture):
	var rewardListItemObj = rewardListItem.instantiate()
	
	var chance = rewardListItemObj.get_node("Chance")
	var itemTexture = rewardListItemObj.get_node("ItemTexture")
	
	chance.text = str(rewardChance)
	itemTexture.texture = texture
	
	return rewardListItemObj

func loadMapState():
	var levelUnlocked = PlayerManager.playerStats.levelUnlocked

	var enumerate = 1
	for node in nodes.get_children():
		node.connect("level_pressed", Callable(self, "_on_level_pressed"))

		if enumerate <= levelUnlocked:
			node.get_node("Sprite2D").texture = load("res://sprites/UI/unlockedCircle.png")
		enumerate += 1

func on_start_button_hover(level):
	GlobalUI.visible = false
	rewardListControl = null
	Global.cameraMovable = true
	LevelManager.byIndex(level).loadScene()

func on_close_button_hover():
	rewardListControl.queue_free()
	rewardListControl = null
	Global.cameraMovable = true
