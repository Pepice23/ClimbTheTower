extends VBoxContainer

@onready var player_level_text = $HBoxContainer/LevelText
@onready var xp_progress_bar = $XPProgressBar
@onready var xp_progress_bar_text = $XPProgressBar/XPProgressBarLabel
@onready var damage_text = $HBoxContainer2/DamageText
@onready var gold_text = $HBoxContainer3/GoldText

# Called when the node enters the scene tree for the first time.
func _ready():
	set_defaults()
	PlayerData.connect("change_player_level", player_level_update)
	PlayerData.connect("change_player_current_xp", update_current_xp_progress)
	PlayerData.connect("change_player_max_xp", update_max_xp_progress)

func player_level_update():
	player_level_text.text = str(PlayerData.player_level)

func set_progress_fill_color():
	var style_box_xp = StyleBoxFlat.new()
	style_box_xp.bg_color = Color.PURPLE
	xp_progress_bar.add_theme_stylebox_override("fill", style_box_xp)

func set_defaults():
	set_progress_fill_color()
	xp_progress_bar.value = PlayerData.player_current_xp
	xp_progress_bar.max_value = PlayerData.player_max_xp
	update_current_xp_progress()
	update_max_xp_progress()

func update_current_xp_progress():
	xp_progress_bar.value = PlayerData.player_current_xp
	xp_progress_bar_text.text = "XP: %s / %s" % [Helpers.format_number(PlayerData.player_current_xp), Helpers.format_number(PlayerData.player_max_xp)]

func update_max_xp_progress():
	xp_progress_bar.max_value = PlayerData.player_max_xp
	xp_progress_bar_text.text = "XP: %s / %s" % [Helpers.format_number(PlayerData.player_current_xp), Helpers.format_number(PlayerData.player_max_xp)]

func update_damage_text():
	damage_text.text = "Damage: %s" % [Helpers.format_number(PlayerData.player_damage)]

func update_gold_text():
	gold_text.text = "Gold: %s" % [Helpers.format_number(PlayerData.player_gold)]