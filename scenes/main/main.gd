extends Node2D

@onready var animation_player = $Battle/AnimationPlayer
@onready var background_image = $Background
@onready var attack_timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	Battle.connect("begin_normal_battle", on_begin_normal_battle)
	animation_player.connect("animation_finished", on_attack_animation_finished)
	Battle.connect("stop_attack_timer", battle_finished)
	Battle.start_battle()

func _on_attack_timer_timeout():
	animation_player.play("weapon_attack")

func _on_attack_button_pressed():
	EnemyData.player_manual_attack()

func _on_add_xp_pressed():
	PlayerData.increase_current_xp(80)

func _on_add_damage_pressed():
	PlayerData.increase_current_damage()

func _on_add_gold_pressed():
	PlayerData.increase_current_gold()

func _on_choose_bg_pressed():
	Helpers.choose_random_background()
	background_image.texture = load(Helpers.random_background)

func on_begin_normal_battle():
	attack_timer.start()

func on_attack_animation_finished(animation_name):
	if animation_name == "weapon_attack":
		Battle.auto_attack()
	if animation_name == "RESET":
		animation_player.play("enemy_disappear")
	if animation_name == "enemy_disappear":
		PlayerData.increase_current_enemy()
		PlayerData.increase_current_xp(5)
		PlayerData.increase_current_gold(10)
		animation_player.play("enemy_appear")
	if animation_name == "enemy_appear":
		EnemyData.prepare_next_enemy()
		Battle.start_battle()

func battle_finished():
	attack_timer.stop()
	animation_player.play("RESET")
	