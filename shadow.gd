extends Sprite3D
var colour = Color(0.0, 0.0, 0.0, 0.2)
var FADE = 0
func _physics_process(delta: float) -> void:
	FADE = ($"../../..".global_position.y - global_position.y)/100
	FADE = clamp(FADE,0,1)
	colour = Color(0.0,0.0,0.0,0.3-FADE*8)
	modulate = colour
