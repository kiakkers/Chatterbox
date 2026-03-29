extends RayCast3D
func _physics_process(delta: float) -> void:
	if is_colliding():
		$shadow.global_position = get_collision_point()
		$shadow.show()
	else:
		$shadow.hide()
