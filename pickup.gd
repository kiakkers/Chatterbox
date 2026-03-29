extends Node3D
var p
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	p = get_tree().get_first_node_in_group("meter")
	print("nodeeeee",p)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.ui.max_jumps += 1
		body.velocity.y = 55
		
		body.ui.update_segments()
		$AnimationPlayer2.play("g")
		$Node3D/GPUParticles3D.emitting = false
		$Area3D.queue_free()
