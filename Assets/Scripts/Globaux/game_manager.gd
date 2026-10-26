extends Node

@onready var camera = get_tree().get_first_node_in_group("Camera")

enum Scenes_Names {
	A
}

#Path des non-niveaux. Exemples:Game Over, Choix des niveaux, Start Menu
var Scenes={}

#Path des niveaux
var Levels = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "res://Assets/Game/Levels/Bomb Man/bomb_man_level.tscn",
	NomsCommuns.Level_Names.ORB_CITY : "res://Assets/Game/Levels/Bomb Man/bomb_man_level.tscn",
	NomsCommuns.Level_Names.STEEL_FOUNDRY : "steel_foundry"
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
	load_level(starting_level)
	
func next_area():
	#Mettre le changement de la variable current_level
	load_level(current_level_name)

func load_level(level_name):
	var level=load(Levels[level_name]) as PackedScene
	if !level:
		print("Niveau pas chargée.")
		return
	# Removing the previous scene
	for child in level_container.get_children():
		child.queue_free()
		await child.tree_exited
	# Setting up the new scene
	current_level = level.instantiate()
	level_container.add_child(current_level)
	create_player_node()

func create_player_node():
	var player_scene = load("res://Assets/Scenes/Megaman/megaman.tscn") as PackedScene
	player = player_scene.instantiate()
	current_level.add_child(player)
	player.global_position = current_level.send_checkpoint_start().global_position
	camera.set_megaman(player)

func go_to_level(level_name:String):
	get_tree().change_scene_to_packed(Levels[level_name])
	print("The player has moved to "+str(level_name))

func get_player():
	return player

func get_current_level():
	return current_level

func get_level_name():
	return current_level_name
