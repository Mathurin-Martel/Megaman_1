@tool
extends StaticBody2D

enum Door_Type{
	HORIZONTAL,
	VERTICAL
}

"""enum Opening_Direction{
	UP,
	LEFT,
	RIGHT,
	DOWN
}"""

@onready var visuals : Node2D = $Visuals
@onready var hitbox : CollisionShape2D = $CollisionShape2D
#Pour une raison que j'ignore (Mémo pour plus tard, apprendre la raison) il est impossible de changer la position
# d'ouverture_area car elle sont enfant d'Areas 2D qui ont leur propre position
@onready var ouverture : Area2D = $Ouverture 
@onready var ouverture_area : CollisionShape2D = $Ouverture/CollisionShape2D
@onready var timer_cooldown : Timer = $"Timer"

var taille_porte_dynamique:int

@export var door_type : Door_Type
@export var supplement_area: float = 16.0
@export var taille_init: int = 1:
	set(value):
		taille_init = max(0, value)
		taille_porte_dynamique=taille_init
		if is_inside_tree():
			mettre_a_jour_porte(taille_init)
			configurer_hitbox(taille_init)
			configurer_ouverture()
			#configurer_fermeture()
@export var nombre_de_portes: int = 1:
	set(value):
		nombre_de_portes = max(1, value)
		if is_inside_tree():
			mettre_a_jour_porte(taille_init)
			configurer_hitbox(taille_init)
			configurer_ouverture()

var taille_hitbox_base: float = 16.0
var action_porte:String = "null"

func _ready() -> void:
	mettre_a_jour_porte(taille_init)
	configurer_hitbox(taille_init)
	configurer_ouverture()
	#configurer_fermeture()

func _on_timer_timeout() -> void:
	var fini=false
	print("action_porte is "+str(action_porte))
	if action_porte=="null":
		return
	elif action_porte=="Ouverture":
		fini=ouverture_porte()
		if fini:
			action_porte = "null"
		else: 
			timer_cooldown.start()
	else: # Donc que c'est "Fermeture"
		fini=fermeture_porte()
		if fini:
			action_porte = "null"
		else: 
			timer_cooldown.start()

func ouverture_porte()->bool:
	if taille_porte_dynamique<=0:
		return true
	taille_porte_dynamique=taille_porte_dynamique-1
	print("Ouverture: Taille de la porte = "+str(taille_porte_dynamique))
	mettre_a_jour_porte(taille_porte_dynamique)
	configurer_hitbox(taille_porte_dynamique)
	if taille_porte_dynamique==0:
		EventBus.emit_signal("animation_porte_fini")
		return true
	else:
		return false

func fermeture_porte()->bool:
	if taille_porte_dynamique>=taille_init:
		return true
	taille_porte_dynamique=taille_porte_dynamique+1
	print("Fermeture: Taille de la porte = "+str(taille_porte_dynamique))
	mettre_a_jour_porte(taille_porte_dynamique)
	configurer_hitbox(taille_porte_dynamique)
	if taille_porte_dynamique==0:
		EventBus.emit_signal("animation_porte_fini")
		return true
	else:
		return false

func mettre_a_jour_porte(taille : int):
	if not is_inside_tree():
		return
	# Il faut supprimer les anciens sprites
	for enfant in visuals.get_children():
		enfant.queue_free()
	
	if door_type==Door_Type.HORIZONTAL:
		visuals.position.x=8.0
		visuals.position.y=0.0
	else:
		visuals.position.x=0.0
		visuals.position.y=8.0
	
	for x in range(nombre_de_portes):
		for y in range(taille):
			var sprite_porte = Sprite2D.new()
			sprite_porte.texture = preload("res://Assets/Sprites/Characters_Objects/Objets/Doors.png")
			sprite_porte.region_enabled = true
			if door_type==Door_Type.HORIZONTAL:
				sprite_porte.region_rect=Rect2(0, 0, 16, 16)
				sprite_porte.position.x = (y * taille_hitbox_base)
				sprite_porte.position.y = (x * taille_hitbox_base)
			else: # Donc que la porte est a la verticale
				sprite_porte.region_rect=Rect2(16, 0, 16, 16)
				sprite_porte.position.x = (x * taille_hitbox_base)
				sprite_porte.position.y = (y * taille_hitbox_base)
			visuals.add_child(sprite_porte)

func configurer_hitbox(taille : int):
	#Variables de base
	var hauteur = taille_hitbox_base
	var largeur = taille_hitbox_base
	
	var hitbox_shape = hitbox.shape as RectangleShape2D
	
	if door_type==Door_Type.HORIZONTAL:
		hauteur = taille_hitbox_base * nombre_de_portes
		largeur = largeur * taille
		
		hitbox.position.x = largeur / 2.0
		hitbox.position.y = 8.0*(nombre_de_portes-1)
	else: # Donc que la porte est a la verticale
		hauteur = hauteur * taille
		largeur = taille_hitbox_base * nombre_de_portes
		
		hitbox.position.x = 8.0*(nombre_de_portes-1)
		hitbox.position.y = hauteur / 2.0
	
	#Fin
	hitbox_shape.size = Vector2(largeur,hauteur)

func configurer_ouverture():
	#Variables de base
	var hauteur = taille_hitbox_base
	var largeur = taille_hitbox_base
	
	var ouverture_area_shape=ouverture_area.shape as RectangleShape2D
	
	if door_type==Door_Type.HORIZONTAL:
		hauteur = (taille_hitbox_base* nombre_de_portes)+supplement_area
		largeur = largeur * taille_init
		
		ouverture.position.x = largeur / 2.0
		ouverture.position.y = 8.0*(nombre_de_portes-1)
	else: # Donc que la porte est a la verticale
		hauteur = hauteur * taille_init
		largeur = (taille_hitbox_base* nombre_de_portes)+supplement_area
		
		ouverture.position.x = 8.0*(nombre_de_portes-1)
		ouverture.position.y = hauteur / 2.0
		
	ouverture_area_shape.size = Vector2(largeur,hauteur)

func _on_ouverture_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mega Man"):
		print("Enter porte")
		action_porte="Ouverture"
		EventBus.emit_signal("freeze_megaman")
		timer_cooldown.start()

func _on_ouverture_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mega Man"):
		print("Exit porte")
		action_porte="Fermeture"
		EventBus.emit_signal("freeze_megaman")
		timer_cooldown.start()
