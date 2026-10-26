extends Node

"""func test_ladder_floor()->bool:
	# false = Pas sur l'échelle
	# true = Sur l'échelle
	if is_on_floor():#Si is_on_floor mais que le sol est celui du haut de l'échelle
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var body = collision.get_collider()
			print("Collision n°"+str(i+1)+" sur "+str(get_slide_collision_count())+". "+str(body))
			if body is CollisionObject2D:
				if body.get_collision_layer_value(10):
					return true
	print("Test return 0")
	return false"""
	
#@onready var fermeture : Area2D = $Fermeture
#@onready var fermeture_area : CollisionShape2D = $Fermeture/CollisionShape2D
#@export var opening_direction : Opening_Direction
#@export var fermeture_offset: float = 32.0
"""func configurer_fermeture():
	#Variables de base
	var hauteur = taille_hitbox_base
	var largeur = taille_hitbox_base
	
	var fermeture_area_shape=fermeture_area.shape as RectangleShape2D
	
	if door_type==Door_Type.HORIZONTAL:
		hauteur = taille_hitbox_base
		largeur = largeur * taille
		if opening_direction==Opening_Direction.UP:
			fermeture.position.x = largeur / 2.0
			fermeture.position.y = -fermeture_offset
		else:
			if opening_direction==Opening_Direction.DOWN:
				fermeture.position.x = largeur / 2.0
				fermeture.position.y = fermeture_offset
			else: #La porte est a l'horizontale. Elle ne peut donc pas s'ouvrir ou se fermer lorsque le joueur
			  #la touche par la gauche ou la droite
				print("Error: La porte ne peut pas s'ouvrir dans cette direction")
	else: # Donc que la porte est a la verticale
		hauteur = hauteur * taille
		largeur = taille_hitbox_base
		if opening_direction==Opening_Direction.LEFT:
			fermeture.position.x = -fermeture_offset
			fermeture.position.y = hauteur / 2.0
		else:
			if opening_direction==Opening_Direction.RIGHT:
				fermeture.position.x = fermeture_offset
				fermeture.position.y = hauteur / 2.0
			else: #La porte est a la verticale. Elle ne peut donc pas s'ouvrir ou se fermer lorsque le joueur
				  #la touche par le haut ou le bas
				pass
				# La premiere fonction print déja
	
	fermeture_area_shape.size = Vector2(largeur,hauteur)"""
