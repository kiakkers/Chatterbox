extends Node3D

var trap1 = preload("res://Traps/Spinlazer.tscn")

func _ready() -> void:
	var max_platform = 3
	
	if Global.roomscleared > 3:
		max_platform = 5
		
	var n = Global.number(1, max_platform)
	print("platform ", str(n))

	if !Global.roomscleared == 2:
		$ttr.queue_free()
	if !Global.roomscleared == 3:
		$ttr2.queue_free()
	if !Global.roomscleared == 4:
		$ttr3.queue_free()
	if !Global.roomscleared == 1:
		$UNO.queue_free()

		if n == 1:
			$DUO.queue_free()
			$TRES.queue_free()
			$QUADRO.queue_free()
			$CINCO.queue_free()
		elif n == 2:
			$JUAN.queue_free()
			$TRES.queue_free()
			$QUADRO.queue_free()
			$CINCO.queue_free()
		elif n == 3:
			$JUAN.queue_free()
			$DUO.queue_free()
			$QUADRO.queue_free()
			$CINCO.queue_free()
		elif n == 4:
			$TRES.queue_free()
			$DUO.queue_free()
			$JUAN.queue_free()
			$CINCO.queue_free()
		elif n == 5:
			$JUAN.queue_free()
			$DUO.queue_free()
			$TRES.queue_free()
			$QUADRO.queue_free()
	else:
		$JUAN.queue_free()
		$DUO.queue_free()
		$TRES.queue_free()
		$QUADRO.queue_free()
		$CINCO.queue_free()

	await get_tree().create_timer(0.1).timeout
	
	setrraps()

func setrraps():
	var g = get_tree().get_nodes_in_group("pickup")
	if Global.roomscleared < 4:
		for i in g:
			i.queue_free()
