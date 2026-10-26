@tool
extends StaticBody2D

@onready var visuals: Node2D = $Visuals
@onready var ladder_collision: CollisionShape2D = $Ladder/CollisionShape2D
@onready var low_entrance: CollisionShape2D = $"Low Entrance"/CollisionShape2D
@export var taille: int = 1:
	set(value):
		taille = max(1, value)
		if is_inside_tree():
			mettre_a_jour_echelle()
			configurer_area_2d()

var hauteur_case: float = 16.0
var largeur_hitbox: int = 5
var custom_offset : float = 0.0

func _ready() -> void:
	mettre_a_jour_echelle()
	configurer_area_2d()

func mettre_a_jour_echelle():
	if not is_inside_tree():
		return
	# Il faut supprimer les anciens sprites
	for enfant in visuals.get_children():
		enfant.queue_free()
	for x in range(taille):
		var nouveau_sprite = Sprite2D.new()
		nouveau_sprite.texture = preload("res://Assets/Sprites/Characters_Objects/Objets/Ladder.png")
		nouveau_sprite.position.y = x * hauteur_case
		visuals.add_child(nouveau_sprite)

func configurer_area_2d():
	var hauteur = taille * hauteur_case
	#Partie Hitbox de l'échelle
	var shape = ladder_collision.shape as RectangleShape2D
	shape.size = Vector2(largeur_hitbox,hauteur)
	ladder_collision.position.y = hauteur / 2.0
	#Partie Low Entrance
	low_entrance.position.y = hauteur

func _on_ladder_entered(body: Node2D) -> void:
	if body.is_in_group("Mega Man"):
		#print("Enter Ladder")
		EventBus.emit_signal("entered_ladder", global_position.x-custom_offset)

func _on_ladder_exited(body: Node2D) -> void:
	if body.is_in_group("Mega Man"):
		#print("Exit Ladder")
		EventBus.emit_signal("exited_ladder")

func _on_end_platform_entered(body: Node2D) -> void:
	if body.is_in_group("Mega Man"):
		#print("Enter Ladder End")
		EventBus.emit_signal("entered_ladder_end_platform")

func _on_end_platform_exited(body: Node2D) -> void:
	#if body.is_in_group("Mega Man"):
	if body is MegaMan:
		#print("Exit Ladder End")
		EventBus.emit_signal("exited_ladder_end_platform")

func _on_high_entrance_entered(body: Node2D) -> void:
	#if body.is_in_group("Mega Man"):
	if body is MegaMan:
		#print("Exit High Entrance")
		EventBus.emit_signal("entered_ladder_high_entrance", global_position.x-custom_offset)

func _on_high_entrance_exited(body: Node2D) -> void:
	#if body.is_in_group("Mega Man"):
	if body is MegaMan:
		#print("Exit High Entrance")
		EventBus.emit_signal("exited_ladder_high_entrance")

func _on_low_entrance_entered(body: Node2D) -> void:
	if body is MegaMan:
		#print("Enter Low Entrance")
		EventBus.emit_signal("entered_ladder_low_entrance")

func _on_low_entrance_exited(body: Node2D) -> void:
	if body is MegaMan:
		#print("Exit Low Entrance")
		EventBus.emit_signal("exited_ladder_low_entrance")
