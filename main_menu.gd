extends Node3D
func _ready() -> void:
	Global.load_data()
	var del = get_tree().get_nodes_in_group("platform")
	for i in del:
		i.queue_free()
	var del2 = get_tree().get_nodes_in_group("Levelbase")
	for i in del2:
		i.queue_free()
	if Global.has_done_calibration == true:
		$SubViewportContainer/SubViewport/calmic.show()
		$SubViewportContainer/SubViewport/Label.show()
var level = preload("res://Level.tscn")
func _on_play_pressed() -> void:
	if Global.has_done_calibration:
		#$SubViewportContainer/SubViewport/mic/AudioStreamPlayer.queue_free()
		#get_tree().change_scene_to_file("res://Level.tscn")
		$SubViewportContainer.queue_free()
		$WorldEnvironment.queue_free()
		var g = get_tree().get_root()
		var l = level.instantiate()
		g.add_child(l)
		
	else:
		$SubViewportContainer/SubViewport/callibration.show()
		Global.has_done_calibration = true
		Global.save_data()


func _on_quit_pressed() -> void:
	$Control.show()


func _on_play_mouse_entered() -> void:
	$SubViewportContainer/SubViewport/play/AnimationPlayer.play("hover")


func _on_play_mouse_exited() -> void:
	$SubViewportContainer/SubViewport/play/AnimationPlayer.play("away")



func _on_quit_mouse_entered() -> void:
	$SubViewportContainer/SubViewport/quit/AnimationPlayer.play("hover")



func _on_quit_mouse_exited() -> void:
	$SubViewportContainer/SubViewport/quit/AnimationPlayer.play("away")


func _on_calmic_pressed() -> void:
	$SubViewportContainer/SubViewport/callibration.show()
	$SubViewportContainer/SubViewport/callibration/continues.does_this_lead_to_level = false
