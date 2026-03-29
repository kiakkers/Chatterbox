extends Control
var mic
var prev_vol = 0.0
func _ready() -> void:
	mic = get_tree().get_first_node_in_group("Mic")
	$treshold.value = Global.volume_input_treshold
func _process(delta: float) -> void:
	if is_instance_valid(mic):
		$vol.value = mic.volume

		if mic.volume > Global.volume_input_treshold:
			$vol/Label3.show()
			prev_vol = mic.volume
			reset()
		else:
			$vol/Label3.hide()

func reset():
	
	await get_tree().create_timer(2).timeout
	prev_vol = 0.0


func _on_h_slider_value_changed(value: float) -> void:
	if value > 350:
		Global.volume_input_treshold = value
		$treshold.value = value
		Global.save_data()
	else:
		$Label5/AnimationPlayer.play("flash")
		$treshold.value = 350
	
