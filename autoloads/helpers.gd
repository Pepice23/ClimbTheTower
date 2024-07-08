extends Node

var random_background = ""
var random_weapon_image = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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

func dice_roll():
	var roll = randi() % 100 + 1
	return roll

func choose_random_weapon_image(weapon_quality: String):
	var weapon_images_folder = ""
	if weapon_quality == "poor":
		weapon_images_folder = "res://assets/weapons/poor/"
	elif weapon_quality == "uncommon":
		weapon_images_folder = "res://assets/weapons/uncommon/"
	elif weapon_quality == "rare":
		weapon_images_folder = "res://assets/weapons/rare/"
	elif weapon_quality == "epic":
		weapon_images_folder = "res://assets/weapons/epic/"
	elif weapon_quality == "legendary":
		weapon_images_folder = "res://assets/weapons/legendary/"
	var weapon_images_files = []
	var dir = DirAccess.open(weapon_images_folder)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and file_name.to_lower().ends_with(".png"):
				weapon_images_files.append(weapon_images_folder + "/" + file_name)
			file_name = dir.get_next()
		
		dir.list_dir_end()
		
		if weapon_images_files.size() > 0:
			random_weapon_image = weapon_images_files[randi() % weapon_images_files.size()]
		else:
			print("No PNG files found in directory: " + weapon_images_folder)
	else:
		print("Failed to open directory: " + weapon_images_folder)
	
	return random_weapon_image