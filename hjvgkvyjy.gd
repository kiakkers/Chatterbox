extends AudioStreamPlayer
func _ready() -> void:
	play(Global.tracktime)

func _on_timer_timeout() -> void:
	Global.tracktime += 0.05
	$Timer.start()
	
