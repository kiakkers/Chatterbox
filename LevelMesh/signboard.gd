extends Node3D

func _ready() -> void:
	Global.load_data()
	if Global.is_exe_game:
		if Global.highestroomscleared > 0:
			$Label3D2.text = str(Global.highestroomscleared) + " floors"
		else:
			$Label3D2.text =  " 0 floors"
	else:
		hide()
