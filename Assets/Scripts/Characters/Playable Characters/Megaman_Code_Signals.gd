extends Node
@warning_ignore_start("unused_signal")
#Ici je met tout le code relatif aux signaux du script megaman.gd

#Comme Code Signal est un sous node de MegaMan je me permet de me référer directement a lui
@onready var megaman : MegaMan = get_parent()

signal on_move_up
signal on_move_down
signal off_move_up_or_down

#Partie Echelle
var on_ladder=false;
var climbing_ladder=false
var on_ladder_high_entrance=false
var on_ladder_low_entrance=false
var ladder_x=null

#Partie Rock
var liste_rocks : Dictionary = {}

func code_signals_connect():
	#Partie Item
	EventBus.health_restored.connect(_heal_megaman)
	EventBus.energy_refill.connect(_energy_refill)
	#Partie Echelle
	EventBus.entered_ladder.connect(_on_entered_ladder)
	EventBus.exited_ladder.connect(_on_exited_ladder)
	EventBus.entered_ladder_high_entrance.connect(_on_entered_ladder_high_entrance)
	EventBus.exited_ladder_high_entrance.connect(_on_exited_ladder_high_entrance)
	EventBus.entered_ladder_low_entrance.connect(_on_entered_ladder_low_entrance)
	EventBus.exited_ladder_low_entrance.connect(_on_exited_ladder_low_entrance)
	EventBus.on_rock.connect(_on_rock)
	EventBus.off_rock.connect(_off_rock)

func _heal_megaman(restored_health:int):
	megaman.heal_damage(restored_health)

func _energy_refill(refilled_energy:int):
	megaman.refill_energy(refilled_energy)

func _on_entered_ladder(position_x: float):
	on_ladder=true
	ladder_x=position_x

func _on_exited_ladder():
	climbing_ladder=false
	if !on_ladder_high_entrance:
		on_ladder=false
		ladder_x=null

func _on_entered_ladder_high_entrance(position_x: float):
	on_ladder_high_entrance=true
	on_ladder=true
	ladder_x=position_x

func _on_exited_ladder_high_entrance():
	on_ladder_high_entrance=false
	if !climbing_ladder:
		on_ladder=false
		ladder_x=null

func _on_entered_ladder_low_entrance():
	on_ladder_low_entrance=true

func _on_exited_ladder_low_entrance():
	on_ladder_low_entrance=false

func _on_rock(rock_id : int, rock_position : Vector2):
	liste_rocks[rock_id] = rock_position
	#print("after on_rock : liste_rocks = "+str(liste_rocks))

func _off_rock(rock_id : int):
	liste_rocks.erase(rock_id)
	#print("after off_rock : liste_rocks = "+str(liste_rocks))

@warning_ignore_restore("unused_signal")
