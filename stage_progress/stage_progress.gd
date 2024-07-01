extends HBoxContainer

@onready var floor_progress_bar = $FloorProgressBar
@onready var floor_progress_text = $FloorProgressBar/FloorProgressText
@onready var enemy_progress_bar = $EnemyProgressBar
@onready var enemy_progress_text = $EnemyProgressBar/EnemyProgressText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	set_progress_fill_color()
	
func set_progress_fill_color():
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color.BLUE
	floor_progress_bar.add_theme_stylebox_override("fill", style_box)
	enemy_progress_bar.add_theme_stylebox_override("fill", style_box)

	floor_progress_bar.value = 5
	enemy_progress_bar.value = 5