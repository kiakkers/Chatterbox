extends Button


func _on_pressed() -> void:
	$"../ColorRect2".show()

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("hovah")


func _on_mouse_exited() -> void:
	$AnimationPlayer.play("away")
