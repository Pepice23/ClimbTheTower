extends Node

var random_background = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# This function takes a number and returns a formatted string
func format_number(num: float) -> String:
	if num < 1000:
		return str(int(num)) # Return as integer if less than 1000
	
	var units := ["", "K", "M", "B", "T"]
	var unit_index := 0
	
	while num >= 1000 and unit_index < units.size() - 1:
		num /= 1000
		unit_index += 1
	
	return String("%0.2f" % num) + units[unit_index]

func choose_random_background():
	var background_folder = "res://assets/backgrounds/"
	var background_files = []
	var dir = DirAccess.open(background_folder)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and file_name.to_lower().ends_with(".png"):
				background_files.append(background_folder + "/" + file_name)
			file_name = dir.get_next()
		
		dir.list_dir_end()
		
		if background_files.size() > 0:
			random_background = background_files[randi() % background_files.size()]
			# var background_sprite = get_node("BackgroundSprite")
			# background_sprite.texture = load(random_background)
	else:
		print("Failed to open directory: " + background_folder)
