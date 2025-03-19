extends TextureRect


@onready var gridContainer = $Weapons/GridContainer
@onready var aquaticTexture = $Aquatic

@onready var aquatic = EntityManager.unlockedAquaticArray

@onready var ItemHolder = preload("res://scenes/objects/ItemDisplay.tscn")


func _ready():
	#EntityManager.unlock(EntityManager.getAquatic(1))
	print(EntityManager.unlockedAquaticArray.array)
	ItemManager.unlock(ItemManager.byId(1))
	#print(ItemManager.byId(1))
	#print("Weapon: ", ItemManager.getWeapons()[0].name)
	#displayAquaticTexture()
	displayWeapons()
	#print(aquatic.array)
	#SaveManager.save()

func displayWeapons():
	for weapon in ItemManager.getWeapons():
		if weapon.unlocked:
			var itemHolder = ItemHolder.instantiate()
			itemHolder.get_node("ItemBoxContainer").texture = weapon.texture
			
			gridContainer.add_child(itemHolder)

func displayAquaticTexture():
	aquaticTexture.texture = aquatic.texture
