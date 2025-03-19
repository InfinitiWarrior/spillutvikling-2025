extends Node

func loadScene(scene):
	get_tree().change_scene_to_packed(load(scene))

func Menu():
	GlobalUI.visible = false
	loadScene("res://gui/Menu.tscn")

func Map():
	GlobalUI.visible = true
	loadScene("res://gui/Map.tscn")

func RewardScreen():
	GlobalUI.visible = true
	loadScene("res://gui/RewardScreen.tscn")

func WeaponSelect():
	GlobalUI.visible = true
	SaveManager.loadSave()
	loadScene("res://gui/WeaponSelection.tscn")
