extends Node3D

var player
var character_body
var camera
var sensitivity := 0.2
var yaw := 0.0
var pitch := 0.0
var max_pitch := 89.0
var min_pitch := -89.0
var random = RandomNumberGenerator.new()

var trauma := 0.0
var trauma_decay := 1.5
var noise = FastNoiseLite.new()
var noise_time := 0.0

func cam_shake(power):
	trauma = clamp(trauma + power, 0.0, 1.0)
@export var readytofollow = false
func _ready():
	player = get_tree().get_first_node_in_group("player")
	character_body = $"../CharacterBody3D"
	camera = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	noise.seed = randi()
	noise.frequency = 10.0
	
	if Global.roomscleared > 3:
		$AnimationPlayer.play("levelintro")
	else:
		$AnimationPlayer.play("levelintro_short")
		$AnimationPlayer.speed_scale = 1.0
func timebegin():
	readytofollow = true
	$"../CharacterBody3D".can = true
	$AnimationPlayer/Label.hide()
	if ! Global.roomscleared == 1:
		%Timer.start()
		
	
func _process(delta):
	if readytofollow:
		$Camera3D.look_at($CameraRotationOffset.global_position)
		if true:
			if !character_body.is_on_floor():
				$CameraRotationOffset.global_position = lerp($CameraRotationOffset.global_position ,$RtargetFar.global_position,delta*2 )
			else:
				$CameraRotationOffset.global_position = lerp($CameraRotationOffset.global_position ,$Rtargetnear.global_position,delta*2 )
		if trauma > 0.0:
			noise_time += delta * 50.0
			var shake = trauma * trauma
			$Camera3D.h_offset = noise.get_noise_2d(noise_time, 0) * shake * 0.6
			$Camera3D.v_offset = noise.get_noise_2d(0, noise_time) * shake * 0.6
			trauma = max(trauma - trauma_decay * delta, 0.0)
		else:
			$Camera3D.h_offset = lerp($Camera3D.h_offset, 0.0, delta * 3)
			$Camera3D.v_offset = lerp($Camera3D.v_offset, 0.0, delta * 3)

		if Input.is_action_pressed("zoom_out"):
			$Camera3D.global_position = lerp($Camera3D.global_position, $pos_far.global_position, delta * 2)
		if Input.is_action_pressed("zoom_in"):
			$Camera3D.global_position = lerp($Camera3D.global_position, $pos_near.global_position, delta * 2)

		if player:
			global_position = global_position.lerp(player.global_position, delta * 8)
		else:
			player = get_tree().get_first_node_in_group("player")

		if camera:
			camera.rotation_degrees.x = pitch
			camera.rotation_degrees.y = yaw
		#if $CollisionPrevention.is_colliding():
			#$Camera3D.global_position = $CollisionPrevention.get_collision_point()
		#else:
			#$Camera3D.global_position = $pos_far.global_position
func _unhandled_input(event):
	if readytofollow:
		if event is InputEventMouseMotion:
			yaw -= event.relative.x * sensitivity
			pitch -= event.relative.y * sensitivity
			pitch = clamp(pitch, min_pitch, max_pitch)
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("DEBUG"):
		$AnimationPlayer.speed_scale = 3
	else:
		$AnimationPlayer.speed_scale = 1
