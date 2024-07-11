extends Node2D

@onready var animation_player = $Battle/AnimationPlayer
@onready var background_image = $Background
@onready var attack_timer = $AttackTimer
@onready var attack_button = $AttackButton

# Called when the node enters the scene tree for the first time.
func _ready():
	Battle.connect("begin_battle", on_begin_battle)
	animation_player.connect("animation_finished", on_attack_animation_finished)
	Battle.connect("stop_attack_timer", battle_finished)
	Battle.connect("player_wins_boss_battle", player_wins_boss_battle)
	Battle.connect("player_loses_boss_battle", player_loses_boss_battle)
	Battle.connect("player_wins_normal_battle", player_wins_normal_battle)
	Battle.connect("disable_attack_button", disable_attack_button)
	Battle.start_battle()

func _on_attack_timer_timeout():
	animation_player.play("weapon_attack")

func on_begin_battle():
	attack_timer.start()
	attack_button.disabled = false

func on_attack_animation_finished(animation_name):
	if animation_name == "weapon_attack":
		if Battle.boss_battle:
			EnemyData.decrease_boss_timer()
			Battle.boss_auto_attack()
		else:
			Battle.auto_attack()

	if animation_name == "RESET":
		animation_player.play("enemy_disappear")

	if animation_name == "enemy_disappear":
		EnemyData.prepare_next_enemy()
		animation_player.play("enemy_appear")
		
	if animation_name == "enemy_appear":
		Battle.start_battle()

func battle_finished():
	attack_timer.stop()
	animation_player.play("RESET")

func player_wins_normal_battle():
	PlayerData.increase_current_enemy()
	PlayerData.increase_current_xp_minmax()
	PlayerData.increase_current_gold(10)
	var roll = Helpers.dice_roll()
	if roll > 90:
		Weapons.create_random_weapon()

func player_wins_boss_battle():
	PlayerData.increase_current_floor()
	PlayerData.increase_current_xp_flat(20)
	PlayerData.increase_current_gold(40)
	Weapons.create_random_weapon()
	Helpers.choose_random_background()
	background_image.texture = load(Helpers.random_background)

func player_loses_boss_battle():
	PlayerData.reset_current_floor()

func _on_attack_button_pressed():
	EnemyData.player_manual_attack()

func disable_attack_button():
	attack_button.disabled = true