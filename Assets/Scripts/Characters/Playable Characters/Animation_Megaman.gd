extends Node2D

@onready var CodeSignals: Node = $"../Code Signals"

@export var megaman : MegaMan
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

var direction=1 #Si jamais le joueur ne touche pas la manette alors on dit qu'il est tourné vers la droite
#Sert pour l'animations idle shooting. Comme idle shooting s'enclenche quand le joueur ne bouge pas 
#on doit garder en mémoire la direction dans laquelle est tourné megaman.
var animation_time=0 # Pour certaines on peut switcher en gardant le temps

var on_ladder_end=false
var move_up=false
var move_down=false

func _ready() -> void:
	if CodeSignals==null:
		print("Error: Code Signals est null")
	#animation_player.play("teleportation")
	#print("Playing idle")
	animation_player.play("idle")
	EventBus.entered_ladder_end_platform.connect(_on_entered_ladder_end)
	EventBus.exited_ladder_end_platform.connect(_on_exited_ladder_end)
	CodeSignals.on_move_up.connect(_on_move_up)
	CodeSignals.on_move_down.connect(_on_move_down)
	CodeSignals.off_move_up_or_down.connect(off_move_up_or_down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if animation_player.speed_scale == 0.0: #Parce que l'animation de climb affecte speed_scale
			animation_player.speed_scale = 1.0
	if megaman.direction == -1 || megaman.direction == 1:
		direction=megaman.direction
	#Est ce que le joueur grimpe une échelle?
	if !CodeSignals.climbing_ladder:
		#Est ce que le joueur tire?
		if !megaman.is_shooting:
			reste_des_animations()
		else :
			shooting_animations()
	else :
		climbing_animations()

func reste_des_animations():
	if megaman.is_on_floor():
		if abs(megaman.velocity.x)>0.0:
			if direction == -1 :
				if animation_player.current_animation=="walk shooting left":
					# Si l'ancienne animation c'était Megaman en train de tirer alors 
					#on reprend l'animation walk au même moment qu'on a quitté walk shooting
					animation_time = animation_player.current_animation_position
					#print("Playing walk left")
					animation_player.play("walk left")
					animation_player.seek(animation_time, true)
				else :
					#print("Playing walk left")
					animation_player.play("walk left")
			else:
				if animation_player.current_animation=="walk shooting right":
					animation_time = animation_player.current_animation_position
					#print("Playing walk right")
					animation_player.play("walk right")
					animation_player.seek(animation_time, true)
				else :
					#print("Playing walk right")
					animation_player.play("walk right")
		else:
			#print("Playing idle")
			animation_player.play("idle")
	else:# Donc qu'il est en train de sauter ou de tomber
		if direction == -1 :
			animation_player.play("jump left")
		elif direction==1 :
			animation_player.play("jump right")

func shooting_animations():
	if megaman.is_on_floor(): #Donc qu'il est au sol
		if abs(megaman.velocity.x)>0.0:
			if direction==-1: #Donc qu'il va vers la gauche
				if animation_player.current_animation=="walk left":
					animation_time = animation_player.current_animation_position
					#print("Playing walk shooting left")
					animation_player.play("walk shooting left")
					animation_player.seek(animation_time, true)
				else :
					#print("Playing walk shooting left")
					animation_player.play("walk shooting left")
			else:
				if animation_player.current_animation=="walk right":
					animation_time = animation_player.current_animation_position
					#print("Playing walk shooting right")
					animation_player.play("walk shooting right")
					animation_player.seek(animation_time, true)
				else :
					#print("Playing walk shooting right")
					animation_player.play("walk shooting right")
		else:
			if direction==-1: #Donc qu'il est tourné vers la gauche
				#print("Playing idle shooting left")
				animation_player.play("idle shooting left")
			elif direction==1:
				#print("Playing idle shooting right")
				animation_player.play("idle shooting right")
	else :
		#Je sais plus pourquoi j'ai mis ces conditions
		#Mais ca permet de régler le problème de direction
		if direction==-1: #Donc qu'il va vers la gauche
			#print("Playing jump shooting left")
			animation_player.play("jump shooting left")
		elif direction==1:
			#print("Playing jump shooting right")
			animation_player.play("jump shooting right")

func climbing_animations():
	if on_ladder_end && CodeSignals.climbing_ladder:
		#print("climb finish")
		animation_player.play("climb finish")
	else:
		if !megaman.is_shooting: # Donc qu'il ne tire pas
			#print("climb")
			animation_player.play("climb")
			if move_up: 
				animation_player.speed_scale = 1.0
			elif move_down:
				animation_player.speed_scale = -1.0
			else:
				animation_player.speed_scale = 0.0
		else:# Donc qu'il tire
			if direction==-1:
				#print("climb shooting left")
				animation_player.play("climb shooting left")
				#Mettre l'animation de climb au moment ou megaman est left
			elif direction==1:
				#print("climb shooting right")
				animation_player.play("climb shooting right")
				#Mettre l'animation de climb au moment ou megaman est right
			else:
				print("Error: Climb shooting has no direction")
	
	#Si l'animation de climb se finit a droite ou a gauche changer climb finish avec un sprite_flip_h
	
#Je vois le problème arriver : Si je mets un escalier il ne fera pas l'animation "walk". 
#Il fera "jump" ou "fall"
#Après vérification : En faisant une pente a 45 degrés, le personnage monte la pente en "walk" mais la descent en "fall" 

func _on_entered_ladder_end():
	#print("enter ladder end")
	on_ladder_end=true

func _on_exited_ladder_end():
	#print("exit ladder end")
	on_ladder_end=false

func _on_move_up():
	move_up=true
	move_down=false

func _on_move_down():
	move_up=false
	move_down=true

func off_move_up_or_down():
	move_up=false
	move_down=false
