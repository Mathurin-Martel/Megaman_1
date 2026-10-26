#Trouver un moyen pour que Rolling_Cutter.gd puisse détecter s'il y en a déja un 
#et refusé d'être créé.
#Changer des fonction dans megaman et ChoixProjectile pour que si le projectile refuse d'être 
#créé alors aucune énergie n'est consommé.
extends SuperProjectile
#Variable pour Fire_Storm_Ball
var megaman : MegaMan
var pivot : Node2D
var distance_to_main_character: float = 24.0
@export var nombre_de_secondes : float = 1.0
@export var nombre_de_tours : float = 3.625 
#Dans la vidéo ca a l'air de faire 3 tours et demi + 1 moitié d'un quart
var angle_total : float

func _ready() -> void:
	super._ready()
	if type==NomsCommuns.Weapon_Info.FIRE_STORM_BLAST:
		animation_player.play("Blast")
	elif type==NomsCommuns.Weapon_Info.FIRE_STORM_BALL:
		megaman = GameManager.get_player()
		#Changer ca par une demande au level_manager
		pivot.reparent(megaman)
		self.reparent(pivot)
		pivot.position=Vector2(0.0,0.0)
		self.position = Vector2(direction_bullet * distance_to_main_character,0.0)
		angle_total = 0.0
		animation_player.play("Ball")
		animation_player.get_animation("Ball").loop_mode = Animation.LOOP_NONE
	else:
		print("Error : type inconnu! Joue Blast a la place")
		animation_player.play("Blast")

func _process(delta: float) -> void:
	if type==NomsCommuns.Weapon_Info.FIRE_STORM_BLAST:
		if direction_bullet != -1 && direction_bullet != 1:
			print("Problème direction")
		else :
			velocity.x = direction_bullet * speed * speed_multiplier
			move_and_slide()
	elif type==NomsCommuns.Weapon_Info.FIRE_STORM_BALL:
		var angle = (TAU / nombre_de_secondes * delta) * nombre_de_tours
		#Selon la vidéo il fait le 3,5 + 1/8 de tour en anti horaire. 
		#Selon google Ai il le fait en 1 seconde. Pas réussi a trouver l'information ailleurs mais ca semble
		#Être cohérent avec la vidéo
		pivot.rotate(-angle)
		angle_total += angle
		if angle_total >= TAU * nombre_de_tours:
			pivot.queue_free()

func create(position_depart : Vector2, direction : int) -> Array:
	self.global_position=position_depart
	self.type = NomsCommuns.Weapon_Info.FIRE_STORM_BLAST
	self.direction_bullet = direction
	var fire_storm = load("res://Assets/Scenes/Megaman/Projectile/Fire_Storm.tscn")
	var ball : SuperProjectile = fire_storm.instantiate()
	ball.set_g_position(position_depart)
	ball.set_type(NomsCommuns.Weapon_Info.FIRE_STORM_BALL)
	ball.set_direction(direction)
	return [self, ball.create_pivot(position_depart), ball]

func create_pivot(position_depart : Vector2) -> Node2D: 
	pivot = Node2D.new()
	pivot.global_position = position_depart
	return pivot
