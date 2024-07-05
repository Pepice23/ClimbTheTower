extends Node

var current_floor = 1
var current_enemy = 14
var floor_max = 100
var enemy_max = 15
var player_damage = 10
var player_level = 1
var player_current_xp = 0
var player_max_xp = 400
var player_gold = 0

signal change_current_enemy
signal change_current_floor
signal show_boss_timer
signal change_enemy_level
signal change_enemy_health
signal change_player_current_xp
signal change_player_max_xp
signal change_player_level
signal change_player_damage
signal change_player_gold

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func increase_current_enemy():
	current_enemy += 1
	emit_signal("change_current_enemy")
	emit_signal("show_boss_timer")

func reset_current_enemy():
	current_enemy = 1
	emit_signal("change_current_enemy")
	emit_signal("show_boss_timer")

func increase_current_floor():
	current_floor += 1
	reset_current_enemy() # If the floor changes enemy will be reset
	Battle.boss_battle = false
	emit_signal("change_current_floor")
	emit_signal("change_enemy_level")

func reset_current_floor():
	reset_current_enemy()
	Battle.boss_battle = false

func increase_current_xp(percent=80):
	player_current_xp += percent / 100.0 * player_max_xp
	check_and_level_up()
	emit_signal("change_player_current_xp")

func calculate_new_max_xp():
	player_max_xp *= 1.15
	player_max_xp = int(player_max_xp)
	emit_signal("change_player_max_xp")

func check_and_level_up():
	if player_current_xp >= player_max_xp:
		player_current_xp -= player_max_xp
		emit_signal("change_player_current_xp")
		player_level += 1
		emit_signal("change_player_level")
		calculate_new_max_xp()

func increase_current_gold(amount=1000):
	player_gold += amount
	emit_signal("change_player_gold")

func increase_current_damage(amount=10):
	player_damage += amount
	emit_signal("change_player_damage")