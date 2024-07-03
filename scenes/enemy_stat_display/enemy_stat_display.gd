extends VBoxContainer

@onready var boss_timer_container = $BossTimerContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("show_boss_timer", toggle_boss_timer_container_visibility)

func toggle_boss_timer_container_visibility():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		boss_timer_container.visible = true
	else:
		boss_timer_container.visible = false