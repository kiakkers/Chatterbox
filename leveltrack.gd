extends AudioStreamPlayer
var t1 = preload("res://noises/T1.mp3")
var t2 = preload("res://noises/T2.mp3")
var t3 = preload("res://noises/T3.mp3")
var t4 = preload("res://noises/T4.mp3")
var t5 = preload("res://noises/T5.mp3")
var random = RandomNumberGenerator.new()
func _ready() -> void:
	random.randomize()
	var n = random.randi_range(1,5)
	if n == 1:
		stream = t1
	elif n == 2:
		stream = t2
	elif n == 3:
		stream = t3
	elif n == 4:
		stream = t4
	else:
		stream = t5
	play()

func _on_finished() -> void:
	play()
