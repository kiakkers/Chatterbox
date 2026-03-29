extends Sprite2D

var mic
var face_neutral = preload("res://cb_neutral.png")
var face_medium = preload("res://cb_medium.png")
var face_loud = preload("res://cb_loud.png")
var face_extremelyloud = preload("res://cb_veryloud.png")

var timer = 4

func _ready() -> void:
	mic = get_tree().get_first_node_in_group("Mic")

func refresh():
	timer = 4
	mic = get_tree().get_first_node_in_group("Mic")
	if mic.volume < 20:
		texture = face_neutral
		$anims.play("return to neutral")
	elif mic.volume < 100:
		texture = face_medium
		$anims.play("medium")
	elif mic.volume < 200:
		texture = face_loud
		$anims.play("loud")
	else:
		texture = face_extremelyloud
		$anims.play("loud")

func _process(delta: float) -> void:
	timer -= delta * 4
	if timer <= 0:
		refresh()
