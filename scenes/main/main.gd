extends Node2D

@onready var animation_player = $Battle/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_attack_timer_timeout():
	animation_player.play("weapon_attack")

func _on_attack_button_pressed():
	PlayerData.player_manual_attack()

func _on_add_xp_pressed():
	PlayerData.increase_current_xp(80)

func _on_add_damage_pressed():
	PlayerData.increase_current_damage()

func _on_add_gold_pressed():
	PlayerData.increase_current_gold()

func _on_choose_bg_pressed():
	Helpers.choose_random_background()