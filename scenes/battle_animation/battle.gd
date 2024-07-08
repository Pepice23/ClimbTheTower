extends Node2D

@onready var weapon = $Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("change_player_weapon_image", update_weapon)
	update_weapon()

func update_weapon():
	weapon.texture = load(PlayerData.player_weapon[2])