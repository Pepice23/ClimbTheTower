extends VBoxContainer

@onready var enemy_level_text = $HBoxContainer/LevelText
@onready var hp_progress_bar = $HPProgressBar
@onready var hp_progress_bar_text = $HPProgressBar/HPProgressBarLabel
@onready var boss_timer_container = $BossTimerContainer
@onready var boss_timer_progress_bar = $BossTimerContainer/BossTimerProgressBar
@onready var boss_timer_progress_bar_text = $BossTimerContainer/BossTimerProgressBar/BossTimerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_defaults()
	set_boss_defaults()
	PlayerData.connect("show_boss_timer", toggle_boss_timer_container_visibility)
	PlayerData.connect("change_enemy_level", enemy_level_update)
	PlayerData.connect("change_enemy_health", update_hp_progress)

func toggle_boss_timer_container_visibility():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		boss_timer_container.visible = true
	else:
		boss_timer_container.visible = false

func enemy_level_update():
	enemy_level_text.text = str(PlayerData.current_floor)

func set_progress_fill_color():
	var style_box_hp = StyleBoxFlat.new()
	var style_box_boss_timer = StyleBoxFlat.new()
	style_box_hp.bg_color = Color.RED
	style_box_boss_timer.bg_color = Color.YELLOW_GREEN
	hp_progress_bar.add_theme_stylebox_override("fill", style_box_hp)
	boss_timer_progress_bar.add_theme_stylebox_override("fill", style_box_boss_timer)

func set_defaults():
	set_progress_fill_color()
	hp_progress_bar.value = EnemyData.enemy_current_hp
	hp_progress_bar.max_value = EnemyData.enemy_max_hp
	update_hp_progress()

func update_hp_progress():
	hp_progress_bar.value = EnemyData.enemy_current_hp
	hp_progress_bar_text.text = "HP: %d / %d" % [EnemyData.enemy_current_hp, EnemyData.enemy_max_hp]

func set_boss_defaults():
	boss_timer_progress_bar.value = EnemyData.boss_time_current
	boss_timer_progress_bar.max_value = EnemyData.boss_time_max
	update_boss_timer_progress()

func update_boss_timer_progress():
	boss_timer_progress_bar.value = EnemyData.boss_time_current
	boss_timer_progress_bar_text.text = "%d seconds left" % [EnemyData.boss_time_current]