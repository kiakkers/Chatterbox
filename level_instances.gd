extends Node3D
var platfroms = preload("res://platfrom instances.tscn")
func _ready():
	var  r = get_tree().get_nodes_in_group("platform")
	for i in r:
		i.queue_free()
	var g = get_tree().get_root()
	var p = platfroms.instantiate()
	g.add_child(p)
	p.global_position = global_position
	if !Global.roomscleared == 1:
		if Global.roomscleared > 3:
			var p2 = platfroms.instantiate()
			g.add_child(p2)
			p2.global_position = global_position
			p2.global_position.y += 35
		var n = Global.number(1,3)
		$Chatterbox_debug/ONE.hide()
		if n == 1:
			$Chatterbox_debug/ONE.show()
		elif n == 2:
			$Chatterbox_debug/TWo.show()
		elif n == 3:
			$Chatterbox_debug/three.show()
		print(str(n))
	else:
		$Chatterbox_debug/TWo.show()
		$Chatterbox_debug/ONE.hide()
