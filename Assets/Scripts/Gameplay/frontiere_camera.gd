@tool 
extends Area2D

enum Orientation{
	HORIZONTAL,
	VERTICAL
}

enum RestrictionSituation{
	UNRESTRICTED, #La caméra suit le joueur en x mais a des limites
	RESTRICTED #La caméra reste sur un point fixe en x (elle fonctionne comme elle le fait en y)
}

enum Direction{
	GOING_UP,
	GOING_DOWN,
	GOING_LEFT,
	GOING_RIGHT,
	NEITHER
}

@onready var hitbox : CollisionShape2D = $CollisionShape2D
@export var orientation : Orientation:
	set(value):
		orientation=value
		if is_inside_tree():
			set_up_hitbox()
@export var grand_cote : int = 48:
	set(value):
		grand_cote=value
		if is_inside_tree():
			set_up_hitbox()
@export var petit_cote : int = 8:
	set(value):
		petit_cote=value
		if is_inside_tree():
			set_up_hitbox()

@export var side_g_h_for_x: RestrictionSituation #GH = Gauche ou Haut
@export var side_g_h_for_x_marker1_name:String = "No Marker"
@export var side_g_h_for_x_marker2_name:String = "No Marker" #Optionnelle si Restricted
@export var side_d_b_for_x: RestrictionSituation #Side DB = Droite ou Bas
@export var side_d_b_for_x_marker1_name:String = "No Marker"
@export var side_d_b_for_x_marker2_name:String = "No Marker" #Optionnelle si Restricted

var chemin_markers: String = "../../Camera Markers/"

@onready var side_g_h_for_x_marker1:Marker2D = get_node(chemin_markers+side_g_h_for_x_marker1_name)
@onready var side_g_h_for_x_marker2:Marker2D #Optionnelle si Restricted
@onready var side_d_b_for_x_marker1:Marker2D = get_node(chemin_markers+side_d_b_for_x_marker1_name)
@onready var side_d_b_for_x_marker2:Marker2D #Optionnelle si Restricted

@export var side_g_h_for_y: RestrictionSituation #GH = Gauche ou Haut
@export var side_g_h_for_y_marker1_name:String = "No Marker"
@export var side_g_h_for_y_marker2_name:String = "No Marker" #Optionnelle si Restricted
@export var side_d_b_for_y: RestrictionSituation #Side DB = Droite ou Bas
@export var side_d_b_for_y_marker1_name:String = "No Marker"
@export var side_d_b_for_y_marker2_name:String = "No Marker" #Optionnelle si Restricted

@onready var side_g_h_for_y_marker1:Marker2D = get_node(chemin_markers+side_g_h_for_x_marker1_name)
@onready var side_g_h_for_y_marker2:Marker2D #Optionnelle si Restricted
@onready var side_d_b_for_y_marker1:Marker2D = get_node(chemin_markers+side_d_b_for_x_marker1_name)
@onready var side_d_b_for_y_marker2:Marker2D #Optionnelle si Restricted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up_hitbox()
	"""var camera_markers = get_node("../../Camera Markers")
	print(camera_markers.name)
	print("Ses enfants sont : " + str(camera_markers.get_children()))
	print("Nom = "+str(self.name))"""
	"""print("Situation Side G H for X:"+str(side_g_h_for_x))
	print("Premier Marker:"+str(side_g_h_for_x_marker1))"""
	if side_g_h_for_x==RestrictionSituation.UNRESTRICTED:
		side_g_h_for_x_marker2 = get_node(chemin_markers+side_g_h_for_x_marker2_name)
		"""print("Second Marker:"+str(side_g_h_for_x_marker2))
	print("Situation Side D B for X:"+str(side_d_b_for_x))
	print("Premier Marker:"+str(side_d_b_for_x_marker1))"""
	if side_d_b_for_x==RestrictionSituation.UNRESTRICTED:
		side_d_b_for_x_marker2 = get_node(chemin_markers+side_d_b_for_x_marker2_name)
		"""print("Second Marker:"+str(side_d_b_for_x_marker2))
	print("Situation Side G H for Y:"+str(side_d_b_for_y))
	print("Premier Marker:"+str(side_d_b_for_y_marker1))"""
	if side_g_h_for_y==RestrictionSituation.UNRESTRICTED:
		side_g_h_for_y_marker2 = get_node(chemin_markers+side_g_h_for_y_marker2_name)
		"""print("Second Marker:"+str(side_g_h_for_y_marker2))
	print("Situation Side D B for Y:"+str(side_d_b_for_y))
	print("Premier Marker:"+str(side_d_b_for_y_marker1))"""
	if side_d_b_for_y==RestrictionSituation.UNRESTRICTED:
		side_d_b_for_y_marker2 = get_node(chemin_markers+side_d_b_for_y_marker2_name)
		#print("Second Marker:"+str(side_d_b_for_x_marker2))

func set_up_hitbox():
	var hitbox_shape = hitbox.shape as RectangleShape2D
	if orientation==Orientation.HORIZONTAL:
		hitbox_shape.size = Vector2(grand_cote,petit_cote)
	else:
		hitbox_shape.size = Vector2(petit_cote,grand_cote)

func send_signal(side:String):
	if side=="G H":
		if side_g_h_for_x==RestrictionSituation.UNRESTRICTED:
			EventBus.emit_signal("transition_camera_x_unrestricted", side_g_h_for_x_marker1, side_g_h_for_x_marker2)
		else:
			EventBus.emit_signal("transition_camera_x_restricted", side_g_h_for_x_marker1)
		if side_g_h_for_y==RestrictionSituation.UNRESTRICTED:
			EventBus.emit_signal("transition_camera_y_unrestricted", side_g_h_for_y_marker1, side_g_h_for_y_marker2)
		else:
			EventBus.emit_signal("transition_camera_y_restricted", side_g_h_for_y_marker1)
	elif side=="D B":
		if side_d_b_for_x==RestrictionSituation.UNRESTRICTED:
			EventBus.emit_signal("transition_camera_x_unrestricted", side_d_b_for_x_marker1, side_d_b_for_x_marker2)
		else:
			EventBus.emit_signal("transition_camera_x_restricted", side_d_b_for_x_marker1)
		if side_d_b_for_y==RestrictionSituation.UNRESTRICTED:
			EventBus.emit_signal("transition_camera_y_unrestricted", side_d_b_for_y_marker1, side_d_b_for_y_marker2)
		else:
			EventBus.emit_signal("transition_camera_y_restricted", side_d_b_for_y_marker1)
	else:
		print("Error : value of side is bad")

var direction_initiale=null

func choose_side_and_send_signal(body:CharacterBody2D):
	if orientation==Orientation.HORIZONTAL:
		if body.global_position.y < self.global_position.y: 
			#Donc que le joueur descend car y=0 est plus haut que y=1
			direction_initiale=Direction.GOING_DOWN
			send_signal("D B")
		elif body.global_position.y > self.global_position.y:
			#Donc que le joueur monte car y=0 est plus haut que y=1
			direction_initiale=Direction.GOING_UP
			send_signal("G H")
		else:
			#Dans le cas improbable ou le joueur rentre dans l'area en ayant le même y que la frontiere
			direction_initiale=Direction.NEITHER
	else:
		if body.global_position.x < self.global_position.x: 
			#Donc que le joueur va a droite car y=0 est plus haut que y=1
			direction_initiale=Direction.GOING_RIGHT
			send_signal("D B")
		elif body.global_position.x > self.global_position.x:
			#Donc que le joueur va a gauche car y=0 est plus haut que y=1
			direction_initiale=Direction.GOING_LEFT
			send_signal("G H")
		else:
			#Dans le cas improbable ou le joueur rentre dans l'area en ayant le même x que la frontiere
			direction_initiale=Direction.NEITHER

func _on_body_entered(body: Node2D) -> void:
	if body is MegaMan:
		choose_side_and_send_signal(body)

func _on_body_exited(body: Node2D) -> void:
	if body is MegaMan:
		if direction_initiale==Direction.GOING_DOWN:
			if body.global_position.y > self.global_position.y:
				#Donc qu'il a continué sa descente
				pass
			elif body.global_position.y < self.global_position.y:
				#Donc qu'il a annulé sa descente et qu'il est monté
				send_signal("G H")
			else:
				print("Error: Player exited from the side, even though he's not supposed to.")
		elif direction_initiale==Direction.GOING_UP:
			if body.global_position.y < self.global_position.y:
				#Donc qu'il a continué sa montée
				pass
			elif body.global_position.y > self.global_position.y:
				#Donc qu'il a annulé sa montée et qu'il est descendu
				send_signal("D B")
			else:
				print("Error: Player exited from the side, even though he's not supposed to.")
		elif direction_initiale==Direction.GOING_RIGHT:
			if body.global_position.x > self.global_position.x:
				#Donc qu'il a continué d'aller a droite
				pass
			elif body.global_position.x < self.global_position.x:
				#Donc qu'il a fini par aller a gauche
				send_signal("G H")
			else:
				print("Error: Player exited from the up or down, even though he's not supposed to.")
		elif direction_initiale==Direction.GOING_LEFT:
			if body.global_position.x < self.global_position.x:
				#Donc qu'il a continué d'aller a gauche
				pass
			elif body.global_position.x > self.global_position.x:
				#Donc qu'il a fini par aller a droite
				send_signal("D B")
			else:
				print("Error: Player exited from the up or down, even though he's not supposed to.")
		elif direction_initiale==Direction.NEITHER:
			if body is MegaMan:
				choose_side_and_send_signal(body)
		else:
			print("Error: direction_initiale isn't a recognized valuen")
	direction_initiale=null
