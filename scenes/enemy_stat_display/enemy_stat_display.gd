extends VBoxContainer

@onready var level_text = $HBoxContainer/LevelText
@onready var hp_progress_bar = $HPProgressBar
@onready var hp_progress_bar_text = $HPProgressBar/HPProgressBarLabel
@onready var boss_timer_container = $BossTimerContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("show_boss_timer", toggle_boss_timer_container_visibility)
	PlayerData.connect("change_enemy_level", level_update)

func toggle_boss_timer_container_visibility():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		boss_timer_container.visible = true
	else:
		boss_timer_container.visible = false

func level_update():
	level_text.text = str(PlayerData.current_floor)
