extends VBoxContainer

@onready var level_text = $HBoxContainer/LevelText
@onready var hp_progress_bar = $HPProgressBar
@onready var hp_progress_bar_text = $HPProgressBar/HPProgressBarLabel
@onready var boss_timer_container = $BossTimerContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_defaults()
	PlayerData.connect("show_boss_timer", toggle_boss_timer_container_visibility)
	PlayerData.connect("change_enemy_level", level_update)
	PlayerData.connect("change_enemy_health", update_hp_progress)

func toggle_boss_timer_container_visibility():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		boss_timer_container.visible = true
	else:
		boss_timer_container.visible = false

func level_update():
	level_text.text = str(PlayerData.current_floor)

func set_progress_fill_color():
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color.RED
	hp_progress_bar.add_theme_stylebox_override("fill", style_box)

func set_defaults():
	set_progress_fill_color()
	hp_progress_bar.value = EnemyData.enemy_current_hp
	hp_progress_bar.max_value = EnemyData.enemy_max_hp
	update_hp_progress()

func update_hp_progress():
	hp_progress_bar.value = EnemyData.enemy_current_hp
	hp_progress_bar_text.text = "HP: %d / %d" % [EnemyData.enemy_current_hp, EnemyData.enemy_max_hp]