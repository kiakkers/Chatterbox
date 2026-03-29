extends RayCast3D
func _physics_process(delta: float) -> void:
	if is_colliding():
		get_parent().queue_free()
