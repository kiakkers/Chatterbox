extends Node3D
func _ready() -> void:
	$Area3D.add_to_group("explodr")
func explod():
	$GPUParticles3D.emitting = true
	$GPUParticles3D.set_as_top_level(true)
	get_parent().queue_free()
