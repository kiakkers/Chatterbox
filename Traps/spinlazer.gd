extends Node3D
func _physics_process(delta: float) -> void:
	rotation_degrees.x = -180
	if $"pee lazer/Cylinder/RayCast3D".is_colliding():
		var x = $"pee lazer/Cylinder/RayCast3D".get_collider()
		if x.is_in_group("player"):
			x.hit()
		$left.show()
		$left.global_position = $"pee lazer/Cylinder/RayCast3D".get_collision_point()
	else:
		$left.hide()
	if $"pee lazer/Cylinder/RayCast3D2".is_colliding():
		var x = $"pee lazer/Cylinder/RayCast3D2".get_collider()
		if x.is_in_group("player"):
			x.hit()
		$right.show()
		$right.global_position = $"pee lazer/Cylinder/RayCast3D2".get_collision_point()
	else:
		$right.hide()
func on():

	$initate2.playing = true
	$"pee lazer/Cylinder/RayCast3D".enabled = true
	$"pee lazer/Cylinder/RayCast3D2".enabled = true
func off():
	$initate2.playing= false
	$"pee lazer/Cylinder/RayCast3D".enabled = false
	$"pee lazer/Cylinder/RayCast3D2".enabled = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "g":
		$Sprite3D/AnimationPlayer.play("g")
