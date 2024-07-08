extends Node2D

@onready var weapon = $Weapon
@onready var enemy = $Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("change_player_weapon_image", update_weapon)
	EnemyData.connect("change_enemy_picture", update_enemy)
	update_weapon()

func update_weapon():
	weapon.texture = load(PlayerData.player_weapon[2])

func update_enemy():
	enemy.texture = load(Helpers.random_enemy_image)