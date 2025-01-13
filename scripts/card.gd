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

var is_ready = false

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
	
func attack():
	pass
	
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
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 prev_position,
	 0.15).set_trans(Tween.TRANS_SPRING)
