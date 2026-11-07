@tool
extends Node2D

signal select_screen_boss_special_start
signal select_screen_boss_animation_over

@onready var box_sprite : Sprite2D = $"BoxSprite"
@onready var boss_body : Node2D = $"Boss Body"
@onready var boss_sprite : Sprite2D = $"Boss Body/BossSprite"
@onready var weapon_body : Node2D = $"Boss Body/Weapon Body"
@onready var animation_player : AnimationPlayer = $"AnimationPlayer"
@onready var timer_between_jump_and_special : Timer = $"Timers/Timer Between Jump And Special"
@onready var timer_between_special_and_text : Timer = $"Timers/Timer Between Special and Text"

var boss_strings = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "cutman_",
	NomsCommuns.Level_Names.MOUNTAIN_MINES : "gutsman_",
	NomsCommuns.Level_Names.FROZEN_JUNGLE : "iceman_",
	NomsCommuns.Level_Names.ORB_CITY : "bombman_",
	NomsCommuns.Level_Names.STEEL_FOUNDRY : "fireman_",
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : "elecman_",
	NomsCommuns.Level_Names.MAIN_ENTRANCE : "wily_",
	NomsCommuns.Level_Names.SKYWAY : "wily_",
	NomsCommuns.Level_Names.DRAINAGE_SEWERS : "wily_",
	NomsCommuns.Level_Names.MANUFACTORY : "wily_",
}

var boss_string : String = "bombman_"
@export var level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.ORB_CITY :
	set(value):
		level_name = value
		if (level_name == NomsCommuns.Level_Names.ORB_CITY  ||
			level_name == NomsCommuns.Level_Names.MOUNTAIN_MINES ||
			level_name == NomsCommuns.Level_Names.ABANDONED_SAWMILL ||
			level_name == NomsCommuns.Level_Names.ELECTRICITY_TOWER ||
			level_name == NomsCommuns.Level_Names.FROZEN_JUNGLE || 
			level_name == NomsCommuns.Level_Names.STEEL_FOUNDRY) : 
				#Enlever ca quand j'aurais rajouté wily. Par défaut mettre wily
			boss_string = boss_strings[level_name]
			if is_inside_tree():
				print("Test boss_string = "+str(boss_string))
				print("Test animation player = "+str(animation_player))
				animation_player.play(boss_string+"idle")

@export var time_between_jump_and_special : float = 1.5
@export var time_between_special_and_text : float = 1.5

var level_select_screen_platform : Marker2D

var boss_body_initial_position : Vector2

func _ready() -> void:
	timer_between_jump_and_special.wait_time = time_between_jump_and_special 
	timer_between_special_and_text.wait_time = time_between_special_and_text
	boss_body_initial_position = boss_body.global_position
	animation_player.play(boss_string+"idle")

func set_level_select_screen_platform(new_level_select_screen_platform : Marker2D) :
	level_select_screen_platform = new_level_select_screen_platform

func start_boss_animation():
	hide_box()
	make_boss_jump()
	timer_between_jump_and_special.start()

func _on_timer_between_jump_and_special_timeout() -> void:
	print("Test timer jump/special out")
	emit_signal("select_screen_boss_special_start")
	make_boss_special()
	timer_between_special_and_text.start()

func _on_timer_between_special_and_text_timeout() -> void:
	print("Test timer special/text out")
	if (level_name == NomsCommuns.Level_Names.FROZEN_JUNGLE ||
	 	level_name == NomsCommuns.Level_Names.STEEL_FOUNDRY):
		animation_player.play(boss_string+"idle3")
	else:
		animation_player.play(boss_string+"idle2")
	emit_signal("select_screen_boss_animation_over")

func make_boss_jump():
	var depart = boss_body.global_position
	var arrivee = level_select_screen_platform.global_position
	var hauteur_en_plus = 75.0
	var duree = 1.0
	var temps = 0.0
	animation_player.play(boss_string+"jump")
	while temps <= duree:
		var progression = temps / duree
		var x = lerp(depart.x, arrivee.x, progression)
		#progression va de 0 a 1. lerp bouge le personnage de depart.x a arrivée.x. 
		#progression représente le niveau de progression entre depart.x et arrivée.x
		#Si depart.x = 0, arrivee.x = 100 et progression = 0,25 alors lerp(depart.x, arrivee.x, t) = 25
		
		#La formule suivante a été trouvée avec l'aide de ChatGPT.
		#L'explication suivante vient cependant entièrement de moi.
		var y = lerp(depart.y, arrivee.y, progression) - 4.0 * hauteur_en_plus * progression * (1.0 - progression)
		#progression * (1.0 * progression) permet de faire une parabole. 
		#Ca commence a 0 monte a 0.5 * 0.5 = 0.25 puis redescend a 0.
		#Pourquoi 4.0? Parce qu'on compense le 0.25 de la parabole.
		#Ainsi le saut aura reelement comme maximum y_origine + hauteur_en_plus
		
		boss_body.global_position = Vector2(x, y)
		await get_tree().process_frame
		temps += get_process_delta_time()
	#Toujours mettre la ligne suivante car il est fortement possible 
	#que progression n'arrive jamais a 1
	boss_body.global_position = arrivee
	print("Test fait idle2")
	animation_player.play(boss_string+"idle2")

func make_boss_special() :
	#Chaque boss lance son projectile d'une facon différente
	#Gutsman n'a pas de projectile. Il rigole.
	if level_name == NomsCommuns.Level_Names.ORB_CITY :
		make_bombman_shoot()
	else :
		print("Test fait special")
		animation_player.play(boss_string + "special")

func make_bombman_shoot():
	#Partie lance la bombe en l'air
	var hauteur = 20
	var depart_y = weapon_body.global_position.y
	var arrivee_y = level_select_screen_platform.global_position.y - hauteur
	var duree = 0.25
	var temps = 0.0
	animation_player.play(boss_string+"launch")
	while temps < duree:
		var t = temps / duree
		var y = lerp(depart_y, arrivee_y, t) - 4.0 * t * (1.0 - t)
		weapon_body.global_position.y = y
		await get_tree().process_frame
		temps += get_process_delta_time()
	weapon_body.global_position.y = arrivee_y
	
	#Partie bombe redescend
	temps = 0.0
	arrivee_y = depart_y
	depart_y = weapon_body.global_position.y
	while temps < duree:
		var progression = temps / duree
		var y = lerp(depart_y, arrivee_y, progression) - 4.0 * progression * (1.0 - progression)
		weapon_body.global_position.y = y
		await get_tree().process_frame
		temps += get_process_delta_time()
		if progression >= 0.90 :
			#Bombman baisse le bras avant que la bombe ne revienne a son point initial
			#Le 0.90 est arbitraire mais visuellement c'est pas mal
			animation_player.play(boss_string+"idle2")
	weapon_body.global_position.y = arrivee_y
	animation_player.play(boss_string+"idle2")

func make_gutsman_laugh():
	animation_player.play("gutsman_laugh")

func make_cutman_animation():
	animation_player.play("cutman_animation")

func hide_box():
	box_sprite.visible = false

func change_box_shader_state(new_state : bool) :
	box_sprite.material.set_shader_parameter("using_shader", !new_state)
	#Faut inverser pour que ca clignote bien avec le texte de Level Select Screen
