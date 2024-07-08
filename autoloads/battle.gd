extends Node

var boss_battle = false

signal begin_battle
signal player_auto_attack
signal stop_attack_timer
signal player_wins_boss_battle
signal player_loses_boss_battle
signal player_wins_normal_battle
signal disable_attack_button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_battle():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		start_boss_battle()
	else:
		start_normal_battle()

func start_boss_battle():
	boss_battle = true
	emit_signal("begin_battle")

func start_normal_battle():
	emit_signal("begin_battle")

func auto_attack():
	if EnemyData.enemy_current_hp > 0:
		EnemyData.enemy_current_hp -= PlayerData.player_damage
	if EnemyData.enemy_current_hp <= 0:
		EnemyData.enemy_current_hp = 0
		emit_signal("stop_attack_timer")
		emit_signal("player_wins_normal_battle")
		emit_signal("disable_attack_button")
	emit_signal("player_auto_attack")

func boss_auto_attack():
	if EnemyData.enemy_current_hp > 0 and EnemyData.boss_time_current > 0:
		EnemyData.enemy_current_hp -= PlayerData.player_damage
	if EnemyData.enemy_current_hp <= 0 and EnemyData.boss_time_current > 0:
		EnemyData.enemy_current_hp = 0
		emit_signal("stop_attack_timer")
		emit_signal("player_wins_boss_battle")
	if EnemyData.boss_time_current == 0 and EnemyData.enemy_current_hp > 0:
		print("Player lost boss battle")
		emit_signal("stop_attack_timer")
		emit_signal("player_loses_boss_battle")
	emit_signal("player_auto_attack")
	