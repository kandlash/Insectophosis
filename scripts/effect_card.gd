extends "res://scripts/card_base.gd"

@export var effect_desc : String = "effect description"
@onready var effect_description: Label3D = $effect_description

func _ready() -> void:
	super._ready()
	effect_description.text = effect_desc
	is_effect_card = true

func make_on_card_effect(card):
	pass

func make_on_global_effect():
	pass
