@tool
extends Node2D

@onready var visuals: Node2D = $Visuals
@onready var hitbox_pic: Area2D = $"Hitbox Pic"
@export var taille: int = 1:
	set(value):
		taille = max(1, value)
		if is_inside_tree():
			mettre_a_jour_pics()
			configurer_area_2d()
			print(str(hitbox_pic.get_child_count()))

var longueur_pic: float = 16.0

func _ready() -> void:
	mettre_a_jour_pics()
	configurer_area_2d()

func mettre_a_jour_pics():
	if not is_inside_tree():
		return
	# Il faut supprimer les anciens sprites
	for enfant in visuals.get_children():
		enfant.queue_free()
	for x in range(taille):
		var nouveau_sprite = Sprite2D.new()
		nouveau_sprite.texture = preload("res://Assets/Sprites/Characters_Objects/Objets/Pic.png")
		nouveau_sprite.position.x = x * longueur_pic
		visuals.add_child(nouveau_sprite)

func configurer_area_2d():
	if not is_inside_tree():
		return
	# Il faut supprimer les anciennes collisions
	for enfant in hitbox_pic.get_children():
		enfant.queue_free()
	for x in range(taille):
		var new_collision = CollisionPolygon2D.new()
		new_collision.polygon = PackedVector2Array([
			Vector2(-8.0, 8.0),
			Vector2(8.0, 8.0),
			Vector2(0.5, -8.0)
		])
		new_collision.position.x = longueur_pic * x
		hitbox_pic.add_child(new_collision)

func _on_pic_entered(body: Node2D) -> void:
	if body is MegaMan:
		body.die()
	else:
		#Changer ca pour que les ennemis crèvent
		queue_free()
