extends TextureRect

@onready var gridContainer = $Weapons/GridContainer
@onready var ItemHolder = preload("res://scenes/objects/ItemDisplay.tscn")


func _ready():
	var grids = gridContainer.get_children()
	
	for grid in grids:
		print(grid)
