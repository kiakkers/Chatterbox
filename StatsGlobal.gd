extends Node

var is_exe_game = true

var tracktime = 0
var roomscleared = 1
var highestroomscleared = 0

var maximum_jumps: int = 3

var random = RandomNumberGenerator.new()
const SAVE_PATH = "user://Chatterbox.save"

var prev_number = [-999]
var randomnumberindex = 0

var sensitivity = 4000
var mastervol = 1
var volume_input_treshold = 6
var has_done_calibration = false


func number(low,high):
	random.randomize()
	var n = random.randi_range(low,high)
	while n == prev_number[randomnumberindex]:
		n = random.randi_range(low,high)
	prev_number.append(n)
	randomnumberindex += 1
	return n

# saving is unavailable on the web version. 

func save_data():
	if is_exe_game:
		if roomscleared > highestroomscleared:
			highestroomscleared = roomscleared

		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

		var data = {
			"maximum_jumps": maximum_jumps,
			"sensitivity": sensitivity,
			"mastervol":mastervol,
			"volume_input_treshold": volume_input_treshold,
			"has_done_calibration": has_done_calibration,
			"highestroomscleared": highestroomscleared
		}

		file.store_var(data)
		file.close()


func load_data():
	if is_exe_game:
		if not FileAccess.file_exists(SAVE_PATH):
			return
		
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		maximum_jumps = data.get("maximum_jumps", 3)
		sensitivity = data.get("sensitivity", 4000)
		mastervol = data.get("mastervol",1)
		volume_input_treshold = data.get("volume_input_treshold", 6)
		has_done_calibration = data.get("has_done_calibration", false)
		highestroomscleared = data.get("highestroomscleared", 0)
