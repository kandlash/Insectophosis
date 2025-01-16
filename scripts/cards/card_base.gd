extends StaticBody3D

var is_selected = false
var prev_position
signal get_back_ended
@export var card_name : String = "card name"
@export var price : int = 1
@onready var name_label := $name_label
@onready var price_label := $price_label

var is_effect_card = false

func _ready() -> void:
	var newMaterial = StandardMaterial3D.new() # Создаём новый материал
	newMaterial.albedo_color = Color(
		randf_range(0, 1.0),
		randf_range(0, 1.0),
		randf_range(0, 1.0)
	)
	$card.material_override = newMaterial
	name_label.text = card_name
	price_label.text = str(price)
	prev_position = position

func make_selected():
	prev_position = position
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 Vector3(position.x + 0.5, position.y, position.z),
	 0.15).set_trans(Tween.TRANS_SPRING)

func make_unselected():
	get_back()

func get_back():
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 prev_position,
	 0.15).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(get_back_ended.emit)
