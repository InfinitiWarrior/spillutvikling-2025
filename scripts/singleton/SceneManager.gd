extends Node

func loadScene(scene):
	get_tree().change_scene_to_packed(load(scene))

func Menu():
	loadScene("res://gui/Menu.tscn")

func Map():
	loadScene("res://gui/Map.tscn")
