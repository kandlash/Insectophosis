extends "res://scripts/cards/card_base.gd"


@export var hp : int = 3
@export var dmg : int = 1
@export var next_stage_card : PackedScene
@export var mutation_variants_cards: Array[PackedScene]
@onready var hp_label := $hp_label
@onready var attack_label := $attack_label
@onready var attack_ray := $attack_RayCast3D

var is_ready = false
var is_enemy = false

var player_attack_ray_dir = Vector3(3, 0, 0)
var enemy_attack_ray_dir = Vector3(-3, 0, 0)

signal update_turn_ended

func _ready() -> void:
	super._ready()
	
	hp_label.text = str(hp)
	attack_label.text = str(dmg)

func attack(is_enemy):
	attack_ray.target_position = enemy_attack_ray_dir if is_enemy else player_attack_ray_dir
	attack_ray.force_raycast_update()
	
	var tween = create_tween()
	prev_position = position
	tween.tween_property(
		self,
		"position",
		position + Vector3(-0.8 if is_enemy else 0.8, 0.3, 0),
		0.3
	).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(get_back)
	
	if not attack_ray.is_colliding():
		if is_enemy:
			Globals.player.hp -= dmg
			Globals.game_ui.update_player_hp()
		else:
			Globals.enemy.hp -= dmg
			Globals.game_ui.update_enemy_hp()
		return
	var collider = attack_ray.get_collider()
	if not collider.is_in_group("cards"):
		return
	await get_back_ended
	if collider:
		collider.get_damage(dmg, self)

func get_damage(damage: int, card=null):
	hp -= damage
	if hp <= 0:
		death()
	update_hp_label()

func death():
	queue_free()

func update_hp_label():
	hp_label.text = str(hp)

func update_dmg_label():
	attack_label.text = str(dmg)

func make_ready():
	is_ready = true	

func update_turn():
	pass
	
func mutate():
	var random_mutation : PackedScene = mutation_variants_cards.pick_random()
	if not random_mutation:
		return
	var parent = get_parent()
	var new_mutation_card = random_mutation.instantiate()
	new_mutation_card.position = position
	parent.add_child(new_mutation_card)
	queue_free()

func metamorphose():
	if not next_stage_card:
		return
	var parent = get_parent()
	var new_card = next_stage_card.instantiate()
	new_card.position = position
	parent.add_child(new_card)
	queue_free()
