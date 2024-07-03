extends Node

var current_floor = 1
var current_enemy = 1
var floor_max = 100
var enemy_max = 15

signal change_current_enemy
signal change_current_floor
signal show_boss_timer

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
	emit_signal("change_current_floor")