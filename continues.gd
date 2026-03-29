extends Button
@export var does_this_lead_to_level = true

var level = preload("res://Level.tscn")
func _on_pressed() -> void:
	if does_this_lead_to_level:
		$"../../..".queue_free()
		$"../../../../WorldEnvironment".queue_free()
		var g = get_tree().get_root()
		var l = level.instantiate()
		g.add_child(l)
	else:
		$"..".hide()


func _on_mouse_entered() -> void:
	$"../AnimatedSprite2D/AnimationPlayer".play("hover")


func _on_mouse_exited() -> void:
	$"../AnimatedSprite2D/AnimationPlayer".play("away")
