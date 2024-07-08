extends Node

var enemy_current_hp = 400
var enemy_max_hp = 400
var boss_time_max = 30
var boss_time_current = 30
var base_hp = 10

signal change_enemy_health
signal change_boss_timer
signal change_enemy_picture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func prepare_next_enemy():
	enemy_max_hp = base_hp * 0.8 * pow(1.1, PlayerData.current_floor) * PlayerData.current_enemy + 1
	enemy_current_hp = enemy_max_hp
	Helpers.choose_random_enemy_image()
	emit_signal("change_enemy_health")
	emit_signal("change_enemy_picture")

func player_manual_attack():
	if enemy_current_hp >= PlayerData.player_damage:
		enemy_current_hp -= PlayerData.player_damage
		emit_signal("change_enemy_health")

func decrease_boss_timer():
	boss_time_current -= 1
	emit_signal("change_boss_timer")

func reset_boss_timer():
	boss_time_current = boss_time_max
	emit_signal("change_boss_timer")