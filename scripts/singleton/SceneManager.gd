extends Node

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		PauseMenuScreen()

func loadScene(scene):
	get_tree().change_scene_to_packed(load(scene))

func Menu():
	GlobalUI.visible = false
	PauseMenu.visible = false
	loadScene("res://gui/Menu.tscn")

func Map():
	GlobalUI.visible = true
	loadScene("res://gui/Map.tscn")

func RewardScreen():
	GlobalUI.visible = true
	loadScene("res://gui/RewardScreen.tscn")

func WeaponSelect():
	GlobalUI.visible = true
	loadScene("res://gui/WeaponSelection.tscn")

func PauseMenuScreen():
	if PauseMenu.visible:
		PauseMenu.visible = false
		#Global.cameraMovable = true
	else:
		PauseMenu.visible = true
		#Global.cameraMovable = false
