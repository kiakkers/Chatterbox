extends Button

var p = preload("res://Level.tscn")
func _on_pressed() -> void:
	var g = get_tree().get_root()
	$"../../../../..".queue_free()
	var l = p.instantiate()
	g.add_child(l)



func _on_mouse_entered() -> void:
	$AnimationPlayer.play("mouse_hover")


func _on_mouse_exited() -> void:
	$AnimationPlayer.play("mouse_LEAVE")
