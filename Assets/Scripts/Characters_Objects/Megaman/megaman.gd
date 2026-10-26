extends SuperMainCharacter
class_name MegaMan

# Ici je met les variable concernant les nodes attachés a Megaman
#@onready var camera : Camera2D = $"Camera2D"
@onready var sprite2d : Sprite2D = $"Animation Megaman/Sprite2D"
@onready var bout_du_canon : Marker2D = $"Bout Du Canon"
@onready var rock_marker = $Rock_Marker
@onready var SoundPlayer : AudioStreamPlayer = $"SoundPlayer"
@onready var CodeSignals : Node = $"Code Signals"
@onready var Timers : Node = $Timers
#Changer pour ShootPlayer.

#Ici c'est les variables @export

# Ici c'est la liste des sons que fait Megaman
var sound_list={
	Sound_Names.SHOOT : preload("res://Assets/Audio/Sound/shooting.mp3")
}

var direction=0

var is_shooting=false;
var direction_bullet=1;
var is_holding_super_arm_rock = false
var rock_a_proximite = null
#Si le joueur ne bouge pas il doit quand même pouvoir tirer

func _init() -> void: #Ici j'initialise toutes les variables 'abstraites" de SuperMainCharacter
	liste_armes=NomsCommuns.Weapon_Names.values()
	liste_armes_obtenus={
		NomsCommuns.Weapon_Names.MEGA_BUSTER : true,
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : true,
		NomsCommuns.Weapon_Names.SUPER_ARM : true,
		NomsCommuns.Weapon_Names.ICE_SLASHER : true,
		NomsCommuns.Weapon_Names.HYPER_BOMB : true,
		NomsCommuns.Weapon_Names.FIRE_STORM : true,
		NomsCommuns.Weapon_Names.THUNDER_BEAM : true,
		NomsCommuns.Weapon_Names.MAGNET_BEAM : true
	}
	#Créer une fonction utilisée par Game_Manager qui set ces valeurs 
	energy_levels={
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : energy_max_level,
		NomsCommuns.Weapon_Names.SUPER_ARM : energy_max_level,
		NomsCommuns.Weapon_Names.ICE_SLASHER : energy_max_level,
		NomsCommuns.Weapon_Names.HYPER_BOMB : energy_max_level,
		NomsCommuns.Weapon_Names.FIRE_STORM : energy_max_level,
		NomsCommuns.Weapon_Names.THUNDER_BEAM : energy_max_level,
		NomsCommuns.Weapon_Names.MAGNET_BEAM : energy_max_level
	}

func _input(event):
	# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * sqrt(jump_multiplier)
	if event.is_action_pressed("change form"):
		change_weapon()
	if event.is_action_pressed("deplete health"):
		change_health(-1)
	if event.is_action_pressed("deplete energy"):
		change_energy(-1)

func _ready() -> void:
	super._ready()
	if rock_marker == null :
		rock_marker = $Rock_Marker #Enlever ca quand j'aurais fini le signal PlayerIsHere
	CodeSignals.code_signals_connect()

func _process(delta: float) -> void:
	handle_signals()
	rock_detection()
	mouvements(delta)
	move_and_slide()
	if Input.is_action_pressed("shoot"):
		megaman_shooting()

func handle_signals():
	if Input.is_action_pressed("move_up"):
		CodeSignals.emit_signal("on_move_up")
	elif Input.is_action_pressed("move_down"):
		CodeSignals.emit_signal("on_move_down")
	else:
		CodeSignals.emit_signal("off_move_up_or_down")

func mouvements(delta):
	if CodeSignals.on_ladder:
		if !CodeSignals.climbing_ladder:
			if ((Input.is_action_pressed("move_up") && !CodeSignals.on_ladder_high_entrance) #Si le joueur appuie sur Haut et qu'il n'est pas déja en haut de l'échelle
				or (Input.is_action_pressed("move_down") && (!CodeSignals.on_ladder_low_entrance || !is_on_floor()))):
				#Si le joueur appuie sur Bas et qu'il ne touche pas le bas ni le sol de l'échelle
				CodeSignals.climbing_ladder=true
		if CodeSignals.climbing_ladder: #Donc que Megaman monte une échelle
		# Oui c'est bizarre mais c'est pour réglé un problème du a l'animation insolvable par celle-ci
		# En idle megaman a un hitbox plus large qu'en climb.
		#Du coup idle est on_ladder mais climb ne l'est pas a cause de sa hitbox moins large
			set_collision_mask_value(10, false)
			ladder_movements()
			move_and_slide()
			return #Pour couper la fonction. Comme ca la suite n'est pas activée
	#Le joueur n'interagit pas avec l'échelle donc on remet la collision 
	#avec la plateforme en haut de celle-ci
	set_collision_mask_value(10, true)
	if not is_on_floor():
		in_the_air(delta)
	ground_and_air_movements()

func in_the_air(delta):
	velocity += get_gravity() * delta

func ground_and_air_movements():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
		direction_bullet=direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

func ladder_movements():
	velocity.x=0
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		direction_bullet=direction
	if Input.is_action_pressed("shoot"): #Quand Megaman tire il s'arrête
		velocity.y = 0
	#Trouver un moyen pour que Megaman tombe après qu'il ait sauté. Et ce même si le joueur appuie sur une autre touche.
	elif Input.is_action_pressed("jump") && !Timers.on_ladder_jump_cooldown: 
		#Quand Megaman saute il quitte l'échelle. Il peut immédiatement se rattacher mais il doit attendre 1 seconde pour re sauter
		print("Jumping from Ladder")
		CodeSignals.climbing_ladder=false
		Timers.start_cooldown("Ladder Jump Cooldown")
	else: #Dans les autres cas Megaman bouge sur l'échelle
		if Input.is_action_pressed("move_up"):
			global_position.x=CodeSignals.ladder_x
			velocity.y = -1 * ladder_speed
		elif Input.is_action_pressed("move_down"):
			if is_on_floor():#Si il touche un sol
				if CodeSignals.on_ladder_low_entrance: #Donc qu'il est en bas de l'échelle
					velocity.y=0
					CodeSignals.climbing_ladder=false
				else: #Donc qu'il est en haut de l'échelle 
					global_position.x=CodeSignals.ladder_x
					velocity.y = 1 * ladder_speed
			else:#Donc qu'il est sur l'échelle
				global_position.x=CodeSignals.ladder_x
				velocity.y = 1 * ladder_speed
		else:
			velocity.y = 0

func change_weapon():
	super.change_weapon()
	sprite2d.set_colors(liste_armes[curseur_liste_armes])
	#print(str(liste_armes))
	#print("Change de forme. liste.size = "+str(liste_armes.size()-1)+". curseur = "+str(curseur_liste_armes)+". forme = "+str(NomsCommuns.weapon_names_to_string(liste_armes[curseur_liste_armes])))
	
func _change_weapon(arme_choisi : NomsCommuns.Weapon_Names):
	super._change_weapon(arme_choisi)
	sprite2d.set_colors(liste_armes[curseur_liste_armes])
	#print(str(liste_armes))
	#print("Change de forme. liste.size = "+str(liste_armes.size()-1)+". curseur = "+str(curseur_liste_armes)+". forme = "+str(NomsCommuns.weapon_names_to_string(liste_armes[curseur_liste_armes])))

func rock_detection():
	if !CodeSignals.liste_rocks.is_empty() :
		var rock_id = null
		var rock_distance_to_megaman = INF
		for rock_id_in_liste in CodeSignals.liste_rocks.keys():
			var distance_to_rock = self.global_position.distance_to(CodeSignals.liste_rocks[rock_id_in_liste])
			if distance_to_rock < rock_distance_to_megaman :
				rock_id = rock_id_in_liste
				rock_distance_to_megaman = distance_to_rock
		#Après cette boucle on a trouvé le rocher le plus proche de megaman
		EventBus.emit_signal("set_rock_shining", rock_id)
		rock_a_proximite = rock_id
	else:
		return

func get_rock_marker() -> Marker2D:
	return rock_marker

func megaman_shooting():
	is_shooting=true
	await get_tree().process_frame
	if !Timers.on_weapon_little_cooldown:
		if liste_armes[curseur_liste_armes]!=NomsCommuns.Weapon_Names.SUPER_ARM :
			var liste_projectiles : Array = ChoixProjectile.create(bout_du_canon.global_position, direction_bullet, liste_armes[curseur_liste_armes]) 
		
			for x in liste_projectiles.size():
				get_parent().add_child(liste_projectiles[x])
		
			if liste_armes[curseur_liste_armes]!=NomsCommuns.Weapon_Names.MEGA_BUSTER:
				deplete_energy(1) 
				#Si toutes les armes n'ont pas la même consommation alors rajouter une variable energie_consommé
		else : 
			if !is_holding_super_arm_rock:
				if rock_a_proximite !=null :
					EventBus.emit_signal("take_rock", rock_a_proximite)
					is_holding_super_arm_rock = true
					rock_a_proximite=null
				else:
					print("Error: rock_a_proximité est null")
			else :
				EventBus.emit_signal("launch_rocks", direction_bullet)
				is_holding_super_arm_rock = false
				# L'ajout au parent se fera dans Rock.gd
				deplete_energy(1)
				
		
		SoundPlayer.stream=sound_list[Sound_Names.SHOOT]
		SoundPlayer.play()
		Timers.start_cooldown("Little Weapon Cooldown")
	else:
		is_shooting=false
