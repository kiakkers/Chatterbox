extends MeshInstance3D

@onready var material: StandardMaterial3D = get_active_material(0)
var mic 
func _ready():
	mic = get_tree().get_first_node_in_group("Mic")
	material = material.duplicate() as StandardMaterial3D
	set_surface_override_material(0, material)
	
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

func set_mesh_alpha(alpha_value: float):
	material.albedo_color.a = clamp(alpha_value, 0.0, 1.0)
func _physics_process(delta: float) -> void:
	if is_instance_valid(mic):
		set_mesh_alpha(mic.volume/100) 
