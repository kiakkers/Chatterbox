extends Control

var times = 0
func _on_timer_timeout() -> void:
	times += 1
	$Timer.start()
	
var time_mins = 0
var time_sec = 0
func settimescore():
	$Node2D/s.hide()
	$"..".canmove = false
	Global.roomscleared += 1

	if times < 25:
		$Node2D/s.show()
	elif times < 30:
		$Node2D/a.show()
	elif times < 35:
		$Node2D/b.show()
	elif times < 40:
		$Node2D/c.show()
	elif times < 50:
		$Node2D/d.show()

	time_mins += int(times / 60)
	time_sec = times % 60

	var sec_text = str(time_sec).pad_zeros(2)
	$TIME.text = str(time_mins) + ": " + sec_text

var p = preload("res://Level.tscn")
func nextlv():
	var g =get_tree().get_root()
	$"../../../..".queue_free()
	var l = p.instantiate()
	g.add_child(l)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("DEBUG"):
		$AnimationPlayer.speed_scale = 3
	else:
		$AnimationPlayer.speed_scale = 1
