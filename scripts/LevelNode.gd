class_name LevelNode
extends RefCounted

var scene : PackedScene
var prev : LevelNode = null
var next : LevelNode = null

var index : int = 0

func _init(scene: PackedScene, index):
	self.scene = scene
	self.index = index
