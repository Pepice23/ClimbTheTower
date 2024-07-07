extends Node

var weapon_data = {
	"poor": ["Poor Weapon", 0.8],
	"uncommon": ["Uncommon Weapon", 1],
	"rare": ["Rare Weapon", 1.2],
	"epic": ["Epic Weapon", 1.5],
	"legendary": ["Legendary Weapon", 2]
}
var base_damage = 10
var weapon_damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_armor_multiplier():
	if PlayerData.player_level < 10:
		return 1
	elif PlayerData.player_level >= 10 and PlayerData.player_level < 20:
		return 2
	elif PlayerData.player_level >= 20 and PlayerData.player_level < 30:
		return 4
	elif PlayerData.player_level >= 30 and PlayerData.player_level < 40:
		return 6
	elif PlayerData.player_level >= 40 and PlayerData.player_level < 50:
		return 8
	elif PlayerData.player_level >= 50 and PlayerData.player_level < 60:
		return 10
	elif PlayerData.player_level >= 60 and PlayerData.player_level < 70:
		return 12
	elif PlayerData.player_level >= 70 and PlayerData.player_level < 80:
		return 14
	elif PlayerData.player_level >= 80 and PlayerData.player_level < 90:
		return 16
	elif PlayerData.player_level >= 90:
		return 18

func select_random_quality():
	var weapon_qualities = weapon_data.keys()
	var random_index = randi() % weapon_qualities.size()
	var weapon_quality = weapon_qualities[random_index]
	var weapon_data_tuple = weapon_data[weapon_quality]
	var weapon_name = weapon_data_tuple[0]
	var weapon_multiplier = weapon_data_tuple[1]
	return [weapon_name, weapon_multiplier]

func create_random_weapon():
	var weapon_quality = select_random_quality()
	var weapon_name = weapon_quality[0]
	var weapon_multiplier = weapon_quality[1]
	weapon_damage = base_damage * weapon_multiplier * pow(1.1, PlayerData.player_level)
	return [weapon_name, weapon_damage]