extends Control

var bus_name = "Master"
var bus_index

func _ready():
	Global.load_data()

	bus_index = AudioServer.get_bus_index(bus_name)
	$vol.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

	$vol.value = Global.mastervol
	$sens.value = Global.volume_input_treshold
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc") and canc:
		if visible == false:
			get_tree().paused = true
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)



func _on_vol_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db($vol.value))
	AudioServer.set_bus_mute(bus_index, value < 0.01)
	Global.mastervol = value
	Global.save_data()



func _on_sens_value_changed(value: float) -> void:
	Global.volume_input_treshold= value

	Global.save_data()


func _on_button_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_cali_pressed() -> void:
	$callibration.show()


func _on_button_2_mouse_entered() -> void:
	$Button2/AnimationPlayer.play("enter")



func _on_button_2_mouse_exited() -> void:
	$Button2/AnimationPlayer.play("away")

var canc = true
func _on_button_2_pressed() -> void:
	$Control.show()
	$Control/Label2.text = "Your high score: " + str(Global.highestroomscleared)
	canc = false
	
