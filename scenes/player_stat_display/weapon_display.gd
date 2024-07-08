extends HBoxContainer

@onready var weapon_image = $WeaponImage
@onready var weapon_name_text = $VBoxContainer/WeaponName
@onready var weapon_damage_text = $VBoxContainer/WeaponStats/DamageText

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("change_player_weapon_name_text", update_weapon_name)
	PlayerData.connect("change_player_weapon_damage_text", update_damage_text)
	PlayerData.connect("change_player_weapon_image", update_weapon_image)
	set_defaults()

func update_weapon_name():
	weapon_name_text.text = PlayerData.player_weapon[0]

func update_damage_text():
	weapon_damage_text.text = "%s" % [Helpers.format_number(PlayerData.player_weapon[1])]

func update_weapon_image():
	weapon_image.texture = load(PlayerData.player_weapon[2])

func set_defaults():
	update_weapon_name()
	update_damage_text()
	update_weapon_image()