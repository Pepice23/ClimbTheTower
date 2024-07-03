extends Node

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
