extends CharacterBody3D

@export var speed: float = 5.0
@onready var ui = $UI/Control
@export var turn_speed: float = 10.0
@onready var model: Node3D = $MeshInstance3D
@onready var camera_holder: Node3D = $"../CameraHolder"
@onready var camera: Camera3D = $"../CameraHolder/Camera3D"
@onready var anim_player: AnimationPlayer = $MeshInstance3D/Chatterbox_player/AnimationPlayer
var fx = preload("res://JumpFx.tscn")
var mic
var prev_vol = 0.0
@export var canmove = false
var can = false

const SCREAM_SOFT = 30
const SCREAM_MEDIUM = 90
const SCREAM_LOUD = 200

func jumpfx():
	var g = get_tree().get_root()
	var x = fx.instantiate()
	g.add_child(x)
	x.global_position = global_position
func _ready() -> void:
	$win2.play()
	mic = get_tree().get_first_node_in_group("Mic")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	anim_player.play("idle") 
var landchedk = false
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		landchedk = true
		velocity.y -= 9.8 * delta * 3
	if is_on_floor() and landchedk:
		landchedk = false
		$MeshInstance3D/Chatterbox_player/AnimationPlayer2.play("boing")
	if canmove and can:

	
		var input_dir := Input.get_vector("a","d","w","s") 
		var cam_basis := camera_holder.global_transform.basis
		var direction := (cam_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		direction.y = 0


		if (direction != Vector3.ZERO) and canmove:
			if mic.volume < 30:
				anim_player.play("move")
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			if is_on_floor():
				$footstep.playing = true
			var target_rotation = atan2(-direction.x, -direction.z)
			model.rotation.y = lerp_angle(model.rotation.y, target_rotation, turn_speed * delta)
		else:
			$footstep.playing = false
			
			velocity.x = lerp(velocity.x, 0.0, speed*delta)
			velocity.z = lerp(velocity.z, 0.0, speed*delta)
			if is_on_floor():
				anim_player.play("idle")


		if is_instance_valid(mic) and mic.volume > 30:

			if (mic.volume > prev_vol * 1.01) and (mic.volume > Global.volume_input_treshold):
				if $UI/Control.can_jump:
					velocity.y += mic.volume * delta *1.7
					if mic.volume > SCREAM_LOUD:
						anim_player.play("scream loud")
					elif mic.volume > SCREAM_MEDIUM:
						anim_player.play("scream medium")
					elif mic.volume > SCREAM_SOFT:
						anim_player.play("scream soft")
					$UI/Control.trigger()
					jumpfx()
				prev_vol = mic.volume
				
				
				
		else:
			prev_vol = 0.0
		if velocity.y > 17.0:
			velocity.y = lerp(velocity.y, 17.0,delta*30)
		velocity.y = clamp(velocity.y,-999,20)
		if Input.is_action_just_pressed("a") or Input.is_action_just_pressed("w") or Input.is_action_just_pressed("s") or Input.is_action_just_pressed("d"):
				$UI/Control/AnimationPlayer.stop()
				$UI/Control/AnimationPlayer.play("blep smol")

		#if Input.is_action_just_pressed("DEBUG"):
			#velocity.y = 40

	move_and_slide()
	
func die():
	if candie:
		Global.roomscleared = 1
		$Control/Label.show()
		remove_tutorials()
		canmove = false
		$fogged.play()
		if is_instance_valid($"../../../AudioStreamPlayer3D"):
			$"../../../AudioStreamPlayer3D".queue_free()
		$MeshInstance3D/Chatterbox_player/AnimationPlayer.stop()
		$MeshInstance3D/Chatterbox_player/AnimationPlayer.play("death")
var candie = true
func win():
	
	if canmove:
		$lvclear/AnimationPlayer/Label.show()
		candie = false
		remove_tutorials()
		$lvclear/AnimationPlayer.play("win")
		$win.play()
		canmove = false
		
		if Global.roomscleared > Global.highestroomscleared:
			Global.highestroomscleared = Global.roomscleared
			Global.save_data()
func free_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Control/Label.text = "High score: " + str(Global.highestroomscleared )
func hit():
	if canmove:
		$MeshInstance3D/Chatterbox_player/AnimationPlayer.play("hit")
		canmove = false
func remove_traps():
	var pltf = get_tree().get_nodes_in_group("platform")
	for i in pltf:
		i.queue_free()
func remove_tutorials():
	var t = get_tree().get_nodes_in_group("ttr")
	for i in t: 
		i.queue_free()
