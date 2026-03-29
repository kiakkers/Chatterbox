extends Control


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.show()
	$warning.show()
	$three.show()
	$GPUParticles2D.emitting = true
	$AnimationPlayer.play("pulse")
	$AnimatedSprite2D.show()
	await get_tree().create_timer(2).timeout
	$three.hide()
	$two.show()
	$AnimationPlayer.play("pulse")
	await get_tree().create_timer(2).timeout
	$two.hide()
	$one.show()
	$AnimationPlayer.play("pulse")
	await get_tree().create_timer(2).timeout
	$warning.hide()
	$one.hide()
	$AnimationPlayer.play("showfogicon")
	if !Global.roomscleared > 3:
		$"../fogrise".play("rise")
		$"../iconrise".play("r")
	else:
		$"../fogrise".play("rise_longfloor")
		$"../iconrise".play("r_longfloor")
	$"../AudioStreamPlayer3D".stream_paused = false
	
	$"../../CharacterBody3D/UI/thefog".show()
	$GPUParticles2D.emitting = false
	
