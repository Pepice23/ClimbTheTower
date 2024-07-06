extends Node2D

@onready var animation_player = $Battle/AnimationPlayer
@onready var background_image = $Background
@onready var attack_timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	Battle.connect("begin_battle", on_begin_battle)
	animation_player.connect("animation_finished", on_attack_animation_finished)
	Battle.connect("stop_attack_timer", battle_finished)
	Battle.connect("player_wins_boss_battle", player_wins_boss_battle)
	Battle.connect("player_loses_boss_battle", player_loses_boss_battle)
	Battle.connect("player_wins_normal_battle", player_wins_normal_battle)
	Battle.start_battle()

func _on_attack_timer_timeout():
	animation_player.play("weapon_attack")

func on_begin_battle():
	attack_timer.start()

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
		animation_player.play("enemy_appear")
	if animation_name == "enemy_appear":
		EnemyData.prepare_next_enemy()
		Battle.start_battle()

func battle_finished():
	attack_timer.stop()
	animation_player.play("RESET")

func player_wins_normal_battle():
	PlayerData.increase_current_enemy()
	PlayerData.increase_current_xp_minmax()
	PlayerData.increase_current_gold(10)

func player_wins_boss_battle():
	PlayerData.increase_current_floor()
	PlayerData.increase_current_xp_flat(20)
	PlayerData.increase_current_gold(40)
	Helpers.choose_random_background()
	background_image.texture = load(Helpers.random_background)

func player_loses_boss_battle():
	PlayerData.reset_current_floor()