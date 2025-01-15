extends StaticBody3D

var is_empty = true



func _on_child_order_changed() -> void:
	is_empty = !is_empty
	if $CollisionShape3D:
		$CollisionShape3D.disabled = !$CollisionShape3D.disabled
