extends Node3D
func on():
	$chainspike/Armature_001/Skeleton3D/Bone_006/Area3D.monitoring = true
func off():
	$chainspike/Armature_001/Skeleton3D/Bone_006/Area3D.monitoring = false
	
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hit()
