extends Node2D

@onready var click_sfx = $click
@onready var swish_sfx = $swish

func click():
	click_sfx.play()
	await click_sfx.finished

func swish():
	swish_sfx.play()
	await swish_sfx.finished
