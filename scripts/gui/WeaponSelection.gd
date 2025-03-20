extends Control


@onready var gridContainer = $Weapons/GridContainer
@onready var aquaticHolder = $AquaticHolder
@onready var itemHolder = $EquippedItems/ItemHolder

@onready var aquaticArray = EntityManager.unlockedAquaticArray.array

@onready var ItemHolderScene = preload("res://scenes/objects/ItemDisplay.tscn")

var index = 0
var equippedItem = null

func _ready():
	ItemManager.unlock(ItemManager.byId(1))
	ItemManager.unlock(ItemManager.byId(2))
	ItemManager.unlock(ItemManager.byId(3))
	displayAquaticTexture(index)
	process()

func displayEquippedWeapon():
	equippedItem = aquaticArray[index].equippedWeapon

	if equippedItem:
		itemHolder.texture = equippedItem.texture
	else:
		itemHolder.texture = null

func displayWeapons():
	for child in gridContainer.get_children(): # Clearing the gridContainer before putting in something, because I want to use display depending on the Aquatic selected
		child.queue_free()

	for weapon in ItemManager.getWeapons():
		if weapon.unlocked and weapon.aquaticOwner == aquaticArray[index].id:
			var itemHolder = ItemHolderScene.instantiate()
			itemHolder.get_node("ItemBoxContainer").texture = weapon.texture
			itemHolder.weapon = weapon

			gridContainer.add_child(itemHolder)

func displayAquaticTexture(index : int):
	aquaticHolder.texture = aquaticArray[index].texture

func nextAquatic():
	if index != aquaticArray.size() - 1:
		index += 1
		displayAquaticTexture(index)

func prevAquatic():
	if index > 0:
		index -= 1
		displayAquaticTexture(index)

func _on_arrow_left_button_down() -> void:
	prevAquatic()
	process()

func _on_arrow_right_button_down() -> void:
	nextAquatic()
	process()

func connectToWeapons():
	for child in gridContainer.get_children():
		child.connect("weapon_equip", Callable(self, "on_weapon_equip"))

func on_weapon_equip(weapon : Weapon):
	aquaticArray[index].equippedWeapon = weapon
	SaveManager.save()
	displayEquippedWeapon()
	
func process():
	displayWeapons()
	connectToWeapons()
	displayEquippedWeapon()
