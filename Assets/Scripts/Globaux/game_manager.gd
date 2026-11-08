extends Node

@onready var camera = get_tree().get_first_node_in_group("Camera")

enum Scenes_Names {
	A
}

#Path des non-niveaux. Exemples:Game Over, Choix des niveaux, Start Menu
var Scenes={}

#Path des niveaux
var title_screen = "res://Assets/Scenes/Game Scenes/Levels/Functional Level/Title_Screen.tscn"
var level_select_screen = "res://Assets/Scenes/Game Scenes/Levels/Functional Level/Level_Select_Screen.tscn"
var Levels = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn",
	NomsCommuns.Level_Names.MOUNTAIN_MINES : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn",
	NomsCommuns.Level_Names.FROZEN_JUNGLE : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn",
	NomsCommuns.Level_Names.ORB_CITY : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn",
	NomsCommuns.Level_Names.STEEL_FOUNDRY : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn",
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : "res://Assets/Scenes/Game Scenes/Levels/Playable Levels/Bombman_Level.tscn"
}

var starting_level = NomsCommuns.Level_Names.ORB_CITY
var level_container : Node2D
var hud : HUD

var current_level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.ORB_CITY
var current_level : Node2D = null

var player : SuperMainCharacter = null

func _ready() -> void:
	hud = get_tree().get_first_node_in_group("HUD")
	level_container = get_tree().get_first_node_in_group("Level Container")
	load_title_screen()
	EventBus.load_level_select_screen.connect(_load_level_select_screen)
	EventBus.load_level.connect(_load_playable_level)

func load_title_screen():
	load_level(title_screen)
	EventBus.emit_signal("set_level_select_screen_camera", current_level)

func _load_level_select_screen() :
	load_level(level_select_screen)
	EventBus.emit_signal("set_level_select_screen_camera", current_level)

func load_level(level_to_load : String):
	var level_blueprint=load(level_to_load) as PackedScene
	if !level_blueprint:
		return
	for child in level_container.get_children():
		child.queue_free()
		await child.tree_exited
		#Note sur comment await fonctionne.
		#Quand j'appelle await il met en pause cette fonction
		#Cependant la fonction qui l'a appelé elle continuera son éxécution.
		#C'est donc une sorte de return un peu bizarre
	current_level = level_blueprint.instantiate()
	level_container.add_child(current_level)

func _load_playable_level(level_to_load : NomsCommuns.Level_Names):
	await load_level(Levels[level_to_load])
	#Il faut attendre qu'elle se finisse sinon ca crée des problèmes avec create_player_node()
	create_player_node()
	EventBus.emit_signal("set_camera")

func create_player_node():
	var player_scene = load("res://Assets/Scenes/Characters Objects Scenes/Playable Characters/Megaman.tscn") as PackedScene
	player = player_scene.instantiate()
	current_level.add_child(player)
	player.global_position = current_level.send_checkpoint_start().global_position
	camera.set_megaman(player)

func get_player():
	return player

func get_current_level():
	return current_level

func get_level_name():
	return current_level_name
