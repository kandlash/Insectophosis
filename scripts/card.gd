extends StaticBody3D

var is_selected = false
var prev_position

@export var card_name : String = "card name"
@export var hp : int = 3
@export var dmg : int = 1
@export var price : int = 1
@export var next_stage_card = null
@onready var name_label := $name_label
@onready var hp_label := $hp_label
@onready var attack_label := $attack_label
@onready var price_label := $price_label
@onready var attack_ray := $attack_RayCast3D

var is_ready = false
var is_enemy = false

signal get_back_ended

var player_attack_ray_dir = Vector3(3, 0, 0)
var enemy_attack_ray_dir = Vector3(-3, 0, 0)

func _ready() -> void:
	var newMaterial = StandardMaterial3D.new() # Создаём новый материал
	newMaterial.albedo_color = Color(
		randf_range(0, 1.0),
		randf_range(0, 1.0),
		randf_range(0, 1.0)
	)
	$card.material_override = newMaterial
	name_label.text = card_name
	hp_label.text = str(hp)
	attack_label.text = str(dmg)
	price_label.text = str(price)

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
	collider.get_damage(dmg)

func get_back():
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 prev_position,
	 0.15).set_trans(Tween.TRANS_SPRING)
	get_back_ended.emit()

func get_damage(damage: int):
	hp -= damage
	if hp <= 0:
		queue_free()
	update_hp_label()

func update_hp_label():
	hp_label.text = str(hp)
	
func make_ready():
	is_ready = true	

func make_selected():
	prev_position = position
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 Vector3(position.x + 0.5, position.y, position.z),
	 0.15).set_trans(Tween.TRANS_SPRING)

func make_unselected():
	get_back()
