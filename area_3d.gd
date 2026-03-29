extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.die()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("explodr"):
		area.explod()
