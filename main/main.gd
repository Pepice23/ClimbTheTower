extends Node2D

@onready var animation_player = $Battle/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_increase_enemy_pressed():
	PlayerData.increase_current_enemy()

func _on_reset_enemy_pressed():
	PlayerData.reset_current_enemy()

func _on_inc_floor_res_enemy_pressed():
	PlayerData.increase_current_floor()

func _on_attack_timer_timeout():
	animation_player.play("weapon_attack")