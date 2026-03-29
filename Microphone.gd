extends AudioStreamPlayer

@onready var mic_bus_index = AudioServer.get_bus_index("Mic")
var capture : AudioEffectCapture
var volume = 0.0
func _ready():
	stream = AudioStreamMicrophone.new()
	play()

	capture = AudioServer.get_bus_effect(mic_bus_index, 0)
	if capture:
		capture.clear_buffer()
func _process(_delta):

	var available = capture.get_frames_available()

	if available > 0:
		var frames = capture.get_buffer(available)

		if frames.size() == 0:
			print("no frames found")
		
			return

		var sum := 0.0
		for frame in frames:
			sum += abs(frame.x) + abs(frame.y)

		volume = (sum / (frames.size() * 2.0)) * 6000
