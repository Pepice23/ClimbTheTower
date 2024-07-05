extends Node

signal begin_normal_battle
signal player_auto_attack
signal stop_attack_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_battle():
	if PlayerData.current_enemy == PlayerData.enemy_max:
		start_boss_battle()
	else:
		start_normal_battle()

func start_boss_battle():
	print("boss battle started")

func start_normal_battle():
	print("normal battle started")
	emit_signal("begin_normal_battle")

func auto_attack():
	if EnemyData.enemy_current_hp > 0:
		EnemyData.enemy_current_hp -= PlayerData.player_damage
	if EnemyData.enemy_current_hp <= 0:
		EnemyData.enemy_current_hp = 0
		emit_signal("stop_attack_timer")
	emit_signal("player_auto_attack")
