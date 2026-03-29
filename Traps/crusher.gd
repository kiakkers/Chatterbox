extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hit()
func on():
	$crusher/Armature/Skeleton3D/Bone_001/Plane_001/Area3D.monitoring = true

func off():
	$crusher/Armature/Skeleton3D/Bone_001/Plane_001/Area3D.monitoring = false
