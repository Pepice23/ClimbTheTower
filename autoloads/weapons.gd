extends Node

var weapon_data = {
	"poor": ["Poor Weapon", 1],
	"uncommon": ["Uncommon Weapon", 1.2],
	"rare": ["Rare Weapon", 1.4],
	"epic": ["Epic Weapon", 1.6],
	"legendary": ["Legendary Weapon", 2]
}
var base_damage = 10
var weapon_damage = 0
var weapon_scale_factor = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_weapon_scale_factor():
	if PlayerData.player_level < 10:
		weapon_scale_factor = 1.22
	elif PlayerData.player_level >= 10 and PlayerData.player_level < 20:
		weapon_scale_factor = 1.233
	elif PlayerData.player_level >= 20 and PlayerData.player_level < 30:
		weapon_scale_factor = 1.25
	elif PlayerData.player_level >= 30 and PlayerData.player_level < 40:
		weapon_scale_factor = 1.27
	elif PlayerData.player_level >= 40 and PlayerData.player_level < 50:
		weapon_scale_factor = 1.288
	elif PlayerData.player_level >= 50 and PlayerData.player_level < 60:
		weapon_scale_factor = 1.297
	elif PlayerData.player_level >= 60 and PlayerData.player_level < 70:
		weapon_scale_factor = 1.304
	elif PlayerData.player_level >= 70 and PlayerData.player_level < 80:
		weapon_scale_factor = 1.31
	elif PlayerData.player_level >= 80 and PlayerData.player_level < 90:
		weapon_scale_factor = 1.315
	elif PlayerData.player_level >= 90:
		weapon_scale_factor = 1.32

func select_random_quality():
	var weapon_quality
	var wi = ""
	var roll = Helpers.dice_roll()
	if roll <= 50:
		weapon_quality = "poor"
		wi = Helpers.choose_random_weapon_image("poor")
	elif roll > 50 and roll <= 75:
		weapon_quality = "uncommon"
		wi = Helpers.choose_random_weapon_image("uncommon")
	elif roll > 75 and roll <= 90:
		weapon_quality = "rare"
		wi = Helpers.choose_random_weapon_image("rare")
	elif roll > 90 and roll <= 98:
		weapon_quality = "epic"
		wi = Helpers.choose_random_weapon_image("epic")
	elif roll > 98:
		weapon_quality = "legendary"
		wi = Helpers.choose_random_weapon_image("legendary")
	var weapon_data_tuple = weapon_data[weapon_quality]
	var weapon_name = weapon_data_tuple[0]
	var weapon_multiplier = weapon_data_tuple[1]
	return [weapon_name, weapon_multiplier, wi]

func create_random_weapon():
	var weapon_quality = select_random_quality()
	var weapon_name = weapon_quality[0]
	var weapon_multiplier = weapon_quality[1]
	var weapon_image = weapon_quality[2]
	get_weapon_scale_factor()
	weapon_damage = base_damage * weapon_multiplier * pow(weapon_scale_factor, PlayerData.player_level)
	if weapon_damage > PlayerData.player_weapon[1]:
		PlayerData.player_weapon = [weapon_name, weapon_damage, weapon_image]
		PlayerData.player_weapon_changed()