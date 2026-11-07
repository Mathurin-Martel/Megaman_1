extends Sprite2D

@onready var press_start_text : RichTextLabel  = $"Texte Clignotant/Press Start"
@onready var new_game_text : RichTextLabel  = $"Texte Clignotant/New Game"
@onready var continue_text : RichTextLabel  = $"Texte Clignotant/Continue"
@onready var options_text : RichTextLabel  = $"Texte Clignotant/Options"
@onready var flickering_animation : AnimationPlayer  = $"FlickeringAnimation"

var curseur_liste_texte : int = 0
var liste_texte : Array[RichTextLabel]
var choix_est_fait : bool = false

@export var clignotant_on : bool = false :
	set(value):
		clignotant_on = value
		if is_inside_tree() :
			press_start_text.material.set_shader_parameter("using_shader", clignotant_on)
			liste_texte[curseur_liste_texte].material.set_shader_parameter("using_shader", clignotant_on)

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	liste_texte = [new_game_text, continue_text, options_text]
	flickering_animation.play("flickering")

func _input(event: InputEvent) -> void:
	if !choix_est_fait : 
		#Pour empecher aux joueurs de faire des action après qu'il ait choisi un niveau
		if event.is_action_pressed("move_left"):
			liste_texte[curseur_liste_texte].material.set_shader_parameter("using_shader", false)
			change_curseur_liste_texte(-1)
		if event.is_action_pressed("move_right"):
			liste_texte[curseur_liste_texte].material.set_shader_parameter("using_shader", false)
			change_curseur_liste_texte(1)
		if event.is_action_pressed("jump"):
			choix_est_fait = true
			EventBus.emit_signal("load_level_select_screen")

func change_curseur_liste_texte(deplacement : int) :
	if curseur_liste_texte + deplacement >= len(liste_texte):
		curseur_liste_texte = 0
	elif curseur_liste_texte + deplacement < 0: #Donc si curseur == 0
		curseur_liste_texte = len(liste_texte)-1
	else :
		curseur_liste_texte = curseur_liste_texte + deplacement
