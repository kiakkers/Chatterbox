extends Area3D
var cleared = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		cleared = true
		$Control/AnimationPlayer.play("g")


func _on_body_exited(body: Node3D) -> void:
	if cleared:
		if body.is_in_group("player"):
			$Control/AnimationPlayer.play("away")
			await  get_tree().create_timer(0.3).timeout
			queue_free()
