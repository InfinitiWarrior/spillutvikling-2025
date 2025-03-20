extends TextureButton

signal weapon_equip

var weapon

func _ready():
	GlobalUI.visible = false

func _on_button_down() -> void:
	emit_signal("weapon_equip", weapon)
