extends Node2D

@onready var Level_Labels = $"Elements/Level Labels"
@onready var Level_Boxes = $"Elements/Level Boxes"
@onready var Plateforme : Marker2D = $"Elements/Plateforme"
@onready var background_animation : AnimationPlayer = $"BackgroundAnimation"
@onready var flickering_animation : AnimationPlayer = $"FlickeringAnimation"
@onready var boss_name_text : RichTextLabel  = $"Elements/Score Text/Boss Name"
@onready var clear_points_text : RichTextLabel  = $"Elements/Score Text/Clear Points"
@onready var number_text : RichTextLabel  = $"Elements/Score Text/Number"
@onready var select_text : RichTextLabel = $"Elements/Other Text/Select"
#Pour faire clignoter "Select Stage Press Start" on n'a besoin que d'un seul élément car les shaders sont liés
@onready var timer_between_text_and_loading : Timer = $"Timer Between Text And Loading"

var curseur_liste_texte : int = 0
var liste_texte : Array[RichTextLabel]
var Boxes : Dictionary
var curseur_liste_levels : int = 0
var liste_levels=[NomsCommuns.Level_Names.ABANDONED_SAWMILL, 
NomsCommuns.Level_Names.MOUNTAIN_MINES, NomsCommuns.Level_Names.FROZEN_JUNGLE,
NomsCommuns.Level_Names.ORB_CITY, NomsCommuns.Level_Names.STEEL_FOUNDRY, 
NomsCommuns.Level_Names.ELECTRICITY_TOWER] 
#Dans ready rajouter les niveaux de wily dans cette liste quand les 6 niveaux ont été complété
#Faut les rajouter un par un. On ne peut pas choisir le niveau 1 de wily s'il a déja été fait.
var Boss_Names = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "CUTMAN",
	NomsCommuns.Level_Names.MOUNTAIN_MINES : "GUTSMAN",
	NomsCommuns.Level_Names.FROZEN_JUNGLE : "ICEMAN",
	NomsCommuns.Level_Names.ORB_CITY : "BOMBMAN",
	NomsCommuns.Level_Names.STEEL_FOUNDRY : "FIREMAN",
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : "ELECMAN",
}

var choix_est_fait : bool = false

@export var clignotant_on : bool = false :
	set(value):
		clignotant_on = value
		if is_inside_tree() :
			if test_level(liste_levels[curseur_liste_levels]) :
				Boxes[liste_levels[curseur_liste_levels]].change_box_shader_state(clignotant_on)
			select_text.material.set_shader_parameter("using_shader", clignotant_on)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_animation.play("Phase1")
	flickering_animation.play("flickering")
	
	Boxes = {
		NomsCommuns.Level_Names.ABANDONED_SAWMILL : get_node("Elements/Level Boxes/Cutman Box"),
		NomsCommuns.Level_Names.MOUNTAIN_MINES : get_node("Elements/Level Boxes/Gutsman Box"),
		NomsCommuns.Level_Names.FROZEN_JUNGLE : get_node("Elements/Level Boxes/Iceman Box"),
		NomsCommuns.Level_Names.ORB_CITY : get_node("Elements/Level Boxes/Bombman Box"),
		NomsCommuns.Level_Names.STEEL_FOUNDRY : get_node("Elements/Level Boxes/Fireman Box"),
		NomsCommuns.Level_Names.ELECTRICITY_TOWER : get_node("Elements/Level Boxes/Elecman Box"),
	}
	for key in Boxes.keys():
		if test_level(key) : 
			#A enlever plus tard. Pour l'instant seul bombman n'est as un sprite2d
			Boxes[key].set_level_select_screen_platform(Plateforme)
			#On n'utilise pas EventBus. Le nombre de niveaux étant connu a l'avance 
			#et les boites étant placés manuellement on peut connecter directement.
			#Pour aller de Level Select Screen a Level Select Boss 
			#il suffit de déclencher la fonction manuellement.
			#Pour aller dans l'autre sens, on utilise des signaux 
			#mais il viennent directement de Level Select Boss
			Boxes[key].select_screen_boss_special_start.connect(_launch_screen_color_stabilisation)
			Boxes[key].select_screen_boss_animation_over.connect(_launch_text_animation)
	
	liste_texte = [boss_name_text, clear_points_text, number_text]
	for x in len(liste_texte) :
		liste_texte[x].visible_ratio = 0.0

func launch_screen_color_flickering():
	background_animation.play("Phase2")

func _launch_screen_color_stabilisation():
	background_animation.play("Phase3")

func _launch_text_animation():
	boss_name_text.text = Boss_Names[liste_levels[curseur_liste_levels]]
	var boss_score = RandomNumberGenerator.new().randi_range(5.0, 10.0) * 10000
	number_text.text = str(boss_score)
	#Si la sauvegarde ne précise pas le nombre de points de ce boss alors
	#Communiquer le chiffre a game_manager et le mettre dans la sauvegarde
	tween_text_animation()

func tween_text_animation():
	#Le code suivant vient en grande partie de la vidéo 
	#"How To Make Typewriter Effect In Godot" de roadsidegamestudios
	liste_texte[curseur_liste_texte].visible_ratio = 0.0
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(
		liste_texte[curseur_liste_texte],
		"visible_ratio",
		1.0, #Ca c'est la valeur max
		1.0 #Ca c'est le temps
	)
	if curseur_liste_texte < len(liste_texte)-1 : 
		#curseur_liste_texte ne peut pas être égale a len(liste_texte)
		tween.connect("finished", _on_tween_finished) 
	elif curseur_liste_texte == len(liste_texte)-1 :
		tween.connect("finished", _on_text_finished) 
#Ca ca vient de stackoverflow "https://stackoverflow.com/questions/76841950/how-to-wait-for-tweens-in-godot-4"

func _on_tween_finished():
	curseur_liste_texte = curseur_liste_texte + 1
	tween_text_animation()

func _on_text_finished():
	timer_between_text_and_loading.start()

func _on_timer_between_text_and_loading_timeout() -> void:
	print("Loading level")
	EventBus.emit_signal("load_level", NomsCommuns.Level_Names.ORB_CITY)

func test_level(key : NomsCommuns.Level_Names):
	if (key == NomsCommuns.Level_Names.ORB_CITY  ||
		key == NomsCommuns.Level_Names.MOUNTAIN_MINES ||
		key == NomsCommuns.Level_Names.ABANDONED_SAWMILL ||
		key == NomsCommuns.Level_Names.ELECTRICITY_TOWER ||
		key == NomsCommuns.Level_Names.FROZEN_JUNGLE ||
		key == NomsCommuns.Level_Names.STEEL_FOUNDRY) :
		return true
	else:
		return false

func _input(event: InputEvent) -> void:
	if !choix_est_fait : 
		#Pour empecher aux joueurs de faire des action après qu'il ait choisi un niveau
		if event.is_action_pressed("move_left"):
			if test_level(liste_levels[curseur_liste_levels]) :
				Boxes[liste_levels[curseur_liste_levels]].change_box_shader_state(true)
			#On s'assure que l'ancienne boite n'est pas en clignotement
			change_curseur_liste_levels(-1)
		if event.is_action_pressed("move_right"):
			if test_level(liste_levels[curseur_liste_levels]) :
				Boxes[liste_levels[curseur_liste_levels]].change_box_shader_state(true)
			#On s'assure que l'ancienne boite n'est pas en clignotement
			change_curseur_liste_levels(1)
		if event.is_action_pressed("jump"):
			choix_est_fait = true
			launch_screen_color_flickering()
			if test_level(liste_levels[curseur_liste_levels]) :
				for key in Boxes :
					if key != liste_levels[curseur_liste_levels] :
						Boxes[key].visible = false
					else:
						print("Test : is "+NomsCommuns.level_name_to_string(liste_levels[curseur_liste_levels]))
						Boxes[key].start_boss_animation()
			else:
				for key in Boxes :
					if key != NomsCommuns.Level_Names.MOUNTAIN_MINES :
						Boxes[key].visible = false
					else:
						print("Test : is Mountain Mines")
						Boxes[key].start_boss_animation()

func change_curseur_liste_levels(deplacement : int) :
	if curseur_liste_levels + deplacement >= len(liste_levels):
		curseur_liste_levels = 0
	elif curseur_liste_levels + deplacement < 0: #Donc si curseur == 0
		curseur_liste_levels = len(liste_levels)-1
	else :
		curseur_liste_levels = curseur_liste_levels + deplacement
	#print("Est actuellement sur "+NomsCommuns.level_name_to_string(liste_levels[curseur_liste_levels]))
	#print("curseur = "+str(curseur_liste_levels))
