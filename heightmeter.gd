extends Node2D

var low
var high
var plr
@export var plrnode :NodePath
@onready var sprite_to_move = $"../Player"

func _ready() -> void:
	low = 0.0
	
	high = 36.0
	if Global.roomscleared > 3:
		high = 75.0
	print("low point and high points: "+ str(low) + str(high))
	plr = get_node(plrnode)
	if not plr:
		print("player not found!")
func _physics_process(delta: float) -> void:
	
	if plr:
		
		
	
		var player_y = plr.global_position.y
		sprite_to_move.global_position.y = remap(
			player_y,
			low,
			high,
			260.0, 50.0
		)
		sprite_to_move.global_position.y = clamp(sprite_to_move.global_position.y,50.0,260.0)
