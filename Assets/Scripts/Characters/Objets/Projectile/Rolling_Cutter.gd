#Trouver un moyen pour que Rolling_Cutter.gd puisse détecter s'il y en a déja un 
#et refusé d'être créé.
#Changer des fonction dans megaman et ChoixProjectile pour que si le projectile refuse d'être 
#créé alors aucune énergie n'est consommé.
extends SuperProjectile
#Variable pour Fire_Storm_Ball
@export var distance_max: float = 6.0*16.0 
#Dans la vidéo le boomerang a l'air d'aller au bout de la 6ème tile
@export var hauteur_max: float = 1.5*16.0 
#Dans la vidéo le boomerang a l'air d'aller a un peu plus d'une tile en dessous et en dessous
var courbe : Path2D
var courbe_follow : PathFollow2D
var sur_le_retour : bool = false
var touche_player = false
#touche_player est la pour éviter un souci très particulier. 
#Si megaman touche le rolling cutter avant que celui soit sur le retour
#ET que megaman ne sort pas de l'Area2d du Rolling Cutter 
#alors le Rolling Cutter ne disparaitra jamais et restera collé a Megaman

func _ready() -> void:
	super._ready()
	animation_player.play("Rolling_Cutter")
	courbe_follow.reparent(courbe)
	self.reparent(courbe_follow)

func _process(delta: float) -> void:
	if direction_bullet != -1 && direction_bullet != 1:
		print("Problème direction")
	else :
		if courbe_follow.progress_ratio >= 1.0:
			sur_le_retour=true
			var direction_to_reach_player = (GameManager.get_player().global_position - self.global_position).normalized()
			velocity = direction_to_reach_player * speed * speed_multiplier
			move_and_slide()
		else:
			courbe_follow.progress = courbe_follow.progress + (speed * speed_multiplier * delta)
		
		if sur_le_retour && touche_player :
			efface_rolling_cutter()

func create(position_depart : Vector2, direction : int) -> Array: 
	#On réécrit la fonction de SuperProjectile ne n'utilisant pas l'ancienne
	self.global_position = position_depart 
	direction_bullet = direction
	return [create_courbe(position_depart, direction_bullet), create_courbe_follow(position_depart), self]

func create_courbe(position_depart : Vector2, direction : int) -> Path2D:
	if direction != -1 && direction != 1 :
		print("Error: Rolling Cutter Courbe doesn't have a valid direction!. It's "+str(direction))
		print("Par défaut direction = 1")
		direction = 1
	courbe = Path2D.new()
	courbe.curve=Curve2D.new()
	courbe.global_position = position_depart
	courbe.curve.add_point(Vector2(0.0,0.0)) # Point 1
	courbe.curve.add_point(Vector2(direction_bullet * (distance_max/2.0),-hauteur_max), Vector2(direction_bullet * (-hauteur_max), 0.0), Vector2(direction_bullet * hauteur_max, 0.0)) # Point 2
	courbe.curve.add_point(Vector2(direction_bullet * distance_max,0.0)) # Point 3
	courbe.curve.add_point(Vector2(direction_bullet * (distance_max/2.0),hauteur_max), Vector2(direction_bullet * hauteur_max, 0.0)) # Point 2
	return courbe

func create_courbe_follow(position_depart : Vector2) -> PathFollow2D:
	courbe_follow = PathFollow2D.new()
	courbe_follow.global_position = position_depart
	courbe_follow.loop=false
	return courbe_follow

func efface_rolling_cutter():
	courbe.queue_free()
	#Ca efface le reste aussi
	#S'il y avait d'autre objet pas parenté dans la courbe alors je les aurais queue_free ici.

func _on_body_entered(body : Node2D):
	super._on_body_entered(body)
	if body is MegaMan:
		if sur_le_retour:
			efface_rolling_cutter()
		else : touche_player = true

func _on_body_exited(body: Node2D) -> void:
	if body is MegaMan:
		touche_player = false
