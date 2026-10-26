extends CharacterBody2D
class_name SuperEnnemy

signal free_spawner

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var specific_animations: AnimationPlayer = $Animation/SpecificAnimations
@onready var common_animations: AnimationPlayer = $Animation/CommonAnimations
@onready var body_damage_hitbox: Area2D = $"Body Damage"

@export var score :  int
@export var character_name : String
@export var speed = 0
@export var jump_power = 0
@export var max_health : int
@export var body_damage: int
var current_health : int
var player : SuperMainCharacter = null
var direction : int
var direction_player : int
var dead : bool = false

@export var damage_sheet={
	"Mega Buster"=1,
	"Bomb"=1,
	"Cut"=1,
	"Elec"=1,
	"Fire"=1,
	"Guts"=1,
	"Ice"=1
}

var loot_sheet={ #Les chances que j'ai trouvée sur Internet sont sur 128
	"Rien"=24,
	"Bonus Ball"=69,
	"Small Energy Refill"=15,
	"Small Health Refill"=15,
	"Large Energy Refill"=2,
	"Large Health Refill"=2,
	"1-Up"=1
}
#S'il y avait plus de loot et si le choix de l'ennemi l'influencait alors voila comment je ferais :
#Tous les ennemis posséderaient leur propre version du dictionnaire (avec leur propres clés)
#Ensuite ils enverraient a la fonction random_loot le nombre total en argument ici se seraient 128)
#Ou alors la fonction le calculeraient toute seule en faisant un tour du dictionnaire

func _ready() -> void:
	if max_health==null:
		print("Max_health of "+name+" missing.")
		return
	current_health=max_health
	body_damage_hitbox.body_entered.connect(_on_body_entered)
	visible_notifier.screen_exited.connect(_on_screen_exited)
	common_animations.animation_finished.connect(_animation_death_finished)
	#print("a connecté")

func _process(_delta: float) -> void:
	if current_health<=0:
		death()
	if dead:
		velocity.x=0
		velocity.y=0

func where_is_player():
#Quand le niveau se charge le joueur peut mettre du temps a arriver et donc a envoyer le signal
	#if player != null : 
	if player.global_position.x <= self.global_position.x:
		direction_player=-1
	else:
		direction_player=1
	#else:
		#direction = -1

func take_damage(projectile : String):
	if !damage_sheet.has(projectile):
		current_health=current_health-1
		print("Le projectile n'existe pas dans la damage sheet")
	else:
		current_health=current_health-damage_sheet.get(projectile)
	print(current_health)
	
func death():
	dead=true
	#Rajouter score et drops d'objets
	common_animations.play("common death")

func _animation_death_finished(_animation_name:String):
	if dead:
		emit_signal("free_spawner")
		queue_free()

func _on_screen_exited():
	queue_free()
	emit_signal("free_spawner")

func _on_body_entered(body):
	if body is MegaMan:
		body.take_damage(body_damage)
		print("Corps touché")

func set_player_infos(player_infos : SuperMainCharacter):
	player=player_infos
