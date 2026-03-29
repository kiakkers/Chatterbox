extends Node3D
var player
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	look()
func _physics_process(delta: float) -> void:
	if $"pee lazer/Cylinder/Node3D/RayCast3D".is_colliding():
		var x = $"pee lazer/Cylinder/Node3D/RayCast3D".get_collider()
		if x.is_in_group("player"):
			x.hit()
		$left.show()
		$left.global_position = $"pee lazer/Cylinder/Node3D/RayCast3D".get_collision_point()
	else:
		$left.hide()
func on():
	
	$initate2.playing = true
	$"pee lazer/Cylinder/Node3D/RayCast3D".enabled = true

func off():
	$initate2.playing= false
	$"pee lazer/Cylinder/Node3D/RayCast3D".enabled = false

func look():
	$"pee lazer/Cylinder/Node3D".look_at(Vector3.ZERO)
	$"pee lazer/Cylinder/Node3D".rotation_degrees.x = 0
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "g":
		$Sprite3D/AnimationPlayer.play("g")
