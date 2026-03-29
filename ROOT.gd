extends Node3D

var levelbase = preload("res://Level Instances.tscn")
var random = RandomNumberGenerator.new()

var crushertrap = preload("res://Traps/crusher.tscn")
var macetrap = preload("res://Traps/ballsmasher3000.tscn")
var stationarylazer = preload("res://Traps/singlelazer.tscn")
var spinlazer = preload("res://Traps/Spinlazer.tscn")

func get_random_trap(is_top):
	var traps = []
	
	if is_top:
		traps = [crushertrap, macetrap]
	else:
		traps = [stationarylazer, spinlazer]

	return traps[random.randi_range(0, traps.size() - 1)]


func spawn_traps_at_points(points, trap_count, is_top):

	points.shuffle()

	for i in range(min(trap_count, points.size())):
		var spawn_point = points[i]

		var trap_scene = get_random_trap(is_top)
		var trap = trap_scene.instantiate()

		get_tree().get_root().add_child(trap)
		trap.global_position = spawn_point.global_position


func initiate_traps():

	random.randomize()

	var tops = get_tree().get_nodes_in_group("top")
	var bottoms = get_tree().get_nodes_in_group("bottom")

	var floor = Global.roomscleared

	if floor <= 2:
		return

	var traps_to_spawn = 0

	if floor == 3:
		traps_to_spawn = 1
	else:
		traps_to_spawn = floor - 2

	var top_traps = max(1, traps_to_spawn / 2)
	var bottom_traps = traps_to_spawn - top_traps

	spawn_traps_at_points(tops, top_traps, true)
	spawn_traps_at_points(bottoms, bottom_traps, false)
func _ready():
	 
	var delete = get_tree().get_nodes_in_group("platform")
	for i in delete:
		i.queue_free()
	var l = get_tree().get_nodes_in_group("Levelbase")
	for i in l:
		i.queue_free()
	var g = get_tree().get_root()
	var i = levelbase.instantiate()
	g.add_child(i)
	if Global.roomscleared > 3:
		
		var i2 = levelbase.instantiate()
		g.add_child(i2)
		i2.global_position.y = 37.05
		$"SubViewportContainer/Highest Point".global_position.y = 75.2
	else:
		$RoomBasetile2.queue_free()
		$SubViewportContainer/SubViewport/LevelclearZone.global_position.y = -8.62

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	i.global_position = global_position
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	await get_tree().create_timer(0.4).timeout
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	initiate_traps()
	await get_tree().create_timer(0.4).timeout 
