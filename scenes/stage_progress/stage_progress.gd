extends HBoxContainer

@onready var floor_progress_bar = $FloorProgressBar
@onready var floor_progress_text = $FloorProgressBar/FloorProgressText
@onready var enemy_progress_bar = $EnemyProgressBar
@onready var enemy_progress_text = $EnemyProgressBar/EnemyProgressText

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("change_current_enemy", update_enemy_progress)
	PlayerData.connect("change_current_floor", update_floor_progress)
	set_progress_fill_color()
	set_defaults()
	
func set_progress_fill_color():
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color.BLUE
	floor_progress_bar.add_theme_stylebox_override("fill", style_box)
	enemy_progress_bar.add_theme_stylebox_override("fill", style_box)

func set_defaults():
	floor_progress_bar.value = PlayerData.current_floor
	enemy_progress_bar.value = PlayerData.current_enemy
	update_floor_progress()
	update_enemy_progress()

func update_floor_progress():
	floor_progress_bar.value = PlayerData.current_floor
	floor_progress_text.text = "Floor: %d / %d" % [PlayerData.current_floor, PlayerData.floor_max]

func update_enemy_progress():
	enemy_progress_bar.value = PlayerData.current_enemy
	enemy_progress_text.text = "Enemy: %d / %d" % [PlayerData.current_enemy, PlayerData.enemy_max]
	if PlayerData.current_enemy == PlayerData.enemy_max:
		enemy_progress_text.text = "Boss of the floor!"