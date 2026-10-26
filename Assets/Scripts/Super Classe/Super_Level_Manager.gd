extends Node
class_name Super_Level_Manager

var level_name : NomsCommuns.Level_Names

#Partie Caméra
enum RestrictionSituation{
	UNRESTRICTED, #La caméra suit le joueur en x mais a des limites
	RESTRICTED #La caméra reste sur un point fixe en x (elle fonctionne comme elle le fait en y)
}

@export var x_restriction_situation: RestrictionSituation
@export var x_marker1_name: String = "No Marker"
@export var x_marker2_name: String = "No Marker" #Optionnelle si Restricted

var chemin_markers="Camera Markers/"

@onready var x_marker1: Marker2D = get_node(chemin_markers+x_marker1_name)
@onready var x_marker2: Marker2D #Optionnelle si Restricted

@export var y_restriction_situation: RestrictionSituation
@export var y_marker1_name: String = "No Marker"
@export var y_marker2_name: String = "No Marker" #Optionnelle si Restricted

@onready var y_marker1: Marker2D = get_node(chemin_markers+y_marker1_name)
@onready var y_marker2: Marker2D #Optionnelle si Restricted
 
#Partie Checkpoints
@export var Checkpoints: Node2D

func _ready() -> void:
	#Partie Caméra
	if x_restriction_situation==RestrictionSituation.UNRESTRICTED:
		x_marker2 = get_node(chemin_markers+x_marker2_name)
	if y_restriction_situation==RestrictionSituation.UNRESTRICTED:
		y_marker2 = get_node(chemin_markers+y_marker2_name)
	send_info_to_camera()

func send_info_to_camera(): #A appelé au début de chaque niveau
	#print("Level Manager")
	#print("Situation X:"+str(x_restriction_situation))
	#print("Premier Marker:"+str(x_marker1))
	if x_restriction_situation==RestrictionSituation.UNRESTRICTED:
		#print("Second Marker:"+str(x_marker2))
		EventBus.emit_signal("transition_camera_x_unrestricted", x_marker1, x_marker2)
	else:
		EventBus.emit_signal("transition_camera_x_restricted", x_marker1)
	#print("Situation Y:"+str(y_restriction_situation))
	#print("Premier Marker:"+str(y_marker1))
	if y_restriction_situation==RestrictionSituation.UNRESTRICTED:
		#print("Second Marker:"+str(y_marker2))
		EventBus.emit_signal("transition_camera_y_unrestricted", y_marker1, y_marker2)
	else:
		EventBus.emit_signal("transition_camera_y_restricted", y_marker1)

func send_checkpoint_start():
	return Checkpoints.get_checkpoint(0)

func get_level_name():
	return level_name
