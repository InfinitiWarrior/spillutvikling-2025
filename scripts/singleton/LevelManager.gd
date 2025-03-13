extends Node

var head : LevelNode = null
var tail : LevelNode = null
var current : LevelNode = null

var levelMap : Dictionary = {}

func _ready():
	addLevel(preload("res://levels/Level1.tscn"))
	addLevel(preload("res://levels/Level2.tscn"))

func addLevel(scene):
	var index = (tail.index + 1) if tail else 1
	var node = LevelNode.new(scene, index)
	levelMap[index] = node

	if head == null:
		head = node
		tail = node
		current = node
	else:
		node.prev = tail
		tail.next = node

		tail = node

func loadScene():
	get_tree().change_scene_to_packed(current.scene)

func next():
	current = current.next
	return self

func prev():
	current = current.prev
	return self

func byIndex(index : int):
	current = levelMap[index]
	return self
