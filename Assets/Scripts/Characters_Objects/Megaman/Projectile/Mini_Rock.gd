extends SuperProjectile

var liste_animations = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "Briques Verte",
	NomsCommuns.Level_Names.MOUNTAIN_MINES : "Poussiere",
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : "Ordinateur",
	NomsCommuns.Level_Names.MAIN_ENTRANCE : "Metal",
	NomsCommuns.Level_Names.DRAINAGE_SEWERS : "Briques Bleue",
	NomsCommuns.Level_Names.MANUFACTORY : "Metal"
}

var angle : int
var level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.ABANDONED_SAWMILL

func _ready() -> void:
	super._ready()
	if level_name in liste_animations.values() :
		animation_player.play(liste_animations[level_name])
	else:
		animation_player.play(liste_animations[NomsCommuns.Level_Names.ABANDONED_SAWMILL])

func _process(delta: float) -> void:
	if direction_bullet != -1 && direction_bullet != 1:
		print("Problème direction")
	else :
		var angle_en_radians := deg_to_rad(angle)
		var angle_utile := Vector2(cos(angle_en_radians), -sin(angle_en_radians))
		velocity = angle_utile * speed * speed_multiplier
		velocity.x = velocity.x * direction_bullet 
		move_and_slide()

func create(position_depart : Vector2, direction : int) -> Array:
	self.direction_bullet = direction
	self.angle = 0
	self.global_position = position_depart + Vector2(-direction_bullet * 8, 8)
	var mini_rock = load("res://Assets/Scenes/Megaman/Projectile/Mini_Rock.tscn")
	var projectile1 : SuperProjectile = mini_rock.instantiate()
	projectile1.global_position = position_depart + Vector2(-direction_bullet * 8, -8)
	projectile1.set_direction(direction)
	projectile1.multiply_speed(110)
	projectile1.set_angle(0)
	var projectile2 : SuperProjectile = mini_rock.instantiate()
	projectile2.global_position = position_depart + Vector2(direction_bullet * 8, -8)
	projectile2.set_direction(direction)
	projectile2.multiply_speed(110)
	projectile2.set_angle(25) 
	var projectile3 : SuperProjectile = mini_rock.instantiate()
	projectile3.global_position = position_depart + Vector2(direction_bullet * 8, 8)
	projectile3.set_direction(direction)
	projectile3.set_angle(30)
	return [self, projectile1, projectile2, projectile3]
	
# Selon la vidéo, les projectiles sont créés ainsi :
#-------------------------------
#| projectile 2 | projectile 1 |
#| projectile 3 |     self     |
#-------------------------------
# projectile 1 et self vont tous droit mais projectiles 1 va plus vite que self. De combien? Je ne sais pas.
# projectile 2 et 3 partent avec des angles différents et projectile 2 va plus vite que 3
# Selon la vidéo projectile 2 a l'air d'avoir un angle de 25° et projectile 3 de 30°
# Les projectiles spawnent pile dans le bloc lancé

#Changer les create pour qu'il donne la position de départ

func set_angle(new_angle):
	angle = new_angle

func multiply_speed(multiplicateur_pourcentage : float):
	speed = speed * (multiplicateur_pourcentage/100)

func set_level_name(rock_level_name : NomsCommuns.Level_Names):
	level_name = rock_level_name
