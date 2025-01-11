extends StaticBody3D

var is_selected = false
var prev_position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var newMaterial = StandardMaterial3D.new() # Создаём новый материал
	newMaterial.albedo_color = Color(
		randf_range(0, 1.0),
		randf_range(0, 1.0),
		randf_range(0, 1.0)
	)
	$card.material_override = newMaterial


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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
