extends Control

var max_jumps = 1000
var can_drop = true
var recharge_time = 10
var can_jump = false
var mic
func _ready() -> void:
	mic = get_tree().get_first_node_in_group("Mic")
	max_jumps = Global.maximum_jumps
	update_segments()

func trigger():
	if can_drop:
		can_drop = false
		
		if max_jumps > 0:
			max_jumps -= 1
			print("jumping")
			can_jump = true
			recharge_time = 10
			$"../../MeshInstance3D".scale.y += mic.volume/200
			$"../../MeshInstance3D".scale.y = clamp($"../../MeshInstance3D".scale.y,1,1.35)
			$"../../../CameraHolder".cam_shake(mic.volume/50)
			$AnimationPlayer.play("blep")
			$"../../../CameraHolder/Camera3D".fov += mic.volume/250
			$"../../../CameraHolder/Camera3D".fov = clamp($"../../../CameraHolder/Camera3D".fov,75.0,90.0)
			$facesprite.refresh()
			
			update_segments()
		else:
			can_jump = false

var landcheck = false
var tmer =0.4
func _physics_process(delta: float) -> void:
	print(str(max_jumps))
	if not can_drop:
		tmer -= delta
		if tmer < 0:
			can_drop = true
			tmer = 0.4
	if $"../../MeshInstance3D".scale.y > 1.0: 
		$"../../MeshInstance3D".scale.y = lerp($"../../MeshInstance3D".scale.y,1.0,delta*2)
	if $"../../../CameraHolder/Camera3D".fov > 75.0:
		$"../../../CameraHolder/Camera3D".fov = lerp($"../../../CameraHolder/Camera3D".fov, 75.0, delta*4)
	if $"../..".is_on_floor():
		if landcheck:
			landcheck = false
			can_jump = true
			$"2".emitting = true
			$"1".emitting = true
			$"3".emitting = true
			max_jumps = Global.maximum_jumps
			update_segments()
	if !$"../..".is_on_floor():
		landcheck = true

	$Label.text = str(max_jumps)
	$Label2.text = str(recharge_time)

	if max_jumps < 3:
		if recharge_time > 0:
			recharge_time -= delta * 5
		elif recharge_time <= 0:
			max_jumps += 1
			recharge_time = 10
			update_segments()


func update_segments():

	match max_jumps:

		3:
			$fill1/AnimationPlayer.play("RESET")
			$fill2/AnimationPlayer.play("RESET")
			$fill3/AnimationPlayer.play("RESET")
			$"3".emitting = true

		2:
			$fill1/AnimationPlayer.play("g")
			$fill2/AnimationPlayer.play("RESET")
			$fill3/AnimationPlayer.play("RESET")
			$"2".emitting = true

		1:
			$fill1/AnimationPlayer.play("t")
			$fill2/AnimationPlayer.play("g")
			$fill3/AnimationPlayer.play("RESET")
			$"1".emitting = true

		0:
			$fill1/AnimationPlayer.play("t")
			$fill2/AnimationPlayer.play("t")
			$fill3/AnimationPlayer.play("g")
