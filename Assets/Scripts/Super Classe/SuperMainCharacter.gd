@abstract
extends CharacterBody2D
class_name SuperMainCharacter

var max_health : int = 28
var current_health : int :
	set(value):
		current_health = value
		EventBus.emit_signal("set_health_bar", current_health)
var invincible : bool = false
var energy_max_level : int = 28
var energy_levels : Dictionary
var liste_armes : Array
var liste_armes_obtenus : Dictionary
var curseur_liste_armes : int = 0

# Ici je met les valeurs variables.
@export_category("Mouvement")
@export var speed = 100.0
@export var speed_multiplier = 1
@export var jump_power = -200 # A peu près la puissance pour sauter au dessus d'une tile
@export var jump_multiplier=2
@export var ladder_speed = 100.0

enum Sound_Names{
	SHOOT
}

func _ready() -> void:
	current_health=max_health
	EventBus.change_weapon.connect(_change_weapon)
	EventBus.emit_signal("PlayerIsHere", self)

func change_health(change_to_health : int):
	current_health = min(current_health + change_to_health, max_health)
	if current_health<=0:
			die()

func heal_damage(heal_value:int):
	change_health(heal_value)

func take_damage(damage:int):
	change_health(-damage)

func die():
		current_health=0
		print("MegaMan is dead")
		#Mettre l'animation de mort en faisant popper l'effet et queue_free megaman.
		#Il faudra peut être aussi freeze la caméra

func change_weapon():
	if !(true in liste_armes_obtenus.values()):
		print("Error: Aucune arme n'a été obtenu. C'est impossible.")
		return
	avance_curseur_liste_armes()
	#On avance de 1 puis on boucle pour trouver un true
	while liste_armes_obtenus[curseur_liste_armes] == false: 
	#Je sais on peut mettre !liste_armes[curseur_liste_armes] mais ca c'est plus lisible
		avance_curseur_liste_armes()
	if liste_armes[curseur_liste_armes] in energy_levels.keys():
		EventBus.emit_signal("set_energy_bar", energy_levels[curseur_liste_armes], liste_armes[curseur_liste_armes])

func _change_weapon(arme_choisi : NomsCommuns.Weapon_Names):
	if !(arme_choisi in NomsCommuns.Weapon_Names.values()):
		print("Error : arme_choisi n'est pas dans la liste.")
	var ancien_curseur = curseur_liste_armes
	while liste_armes[curseur_liste_armes] != arme_choisi :
		avance_curseur_liste_armes()
		if curseur_liste_armes == ancien_curseur:
			break
	if liste_armes[curseur_liste_armes] in energy_levels.keys():
		EventBus.emit_signal("set_energy_bar", energy_levels[curseur_liste_armes], liste_armes[curseur_liste_armes])

func avance_curseur_liste_armes():
	if curseur_liste_armes>=liste_armes.size()-1:
		curseur_liste_armes=0
	else:
		curseur_liste_armes=curseur_liste_armes+1

func change_energy(change_to_energy : int):
	#Les variables sont là pour plus de visibilité
	var energy_level = energy_levels[liste_armes[curseur_liste_armes]]
	energy_levels[liste_armes[curseur_liste_armes]] = max(min(energy_level + change_to_energy, energy_max_level),0)
	energy_level = energy_levels[liste_armes[curseur_liste_armes]] #Je remet a jour
	#Changer par une
	#print("Current Energy:"+str(energy_level))
	var energy_concerne = liste_armes[curseur_liste_armes]
	EventBus.emit_signal("set_energy_bar", energy_level, energy_concerne)

func refill_energy(energy_refilled : int):
	change_energy(energy_refilled)

func deplete_energy(energy_depleted : int):
	change_energy(-energy_depleted)

func teleport_to_location(new_location):
	#camera.position_smoothing_enabled = false
	position = new_location
	#await get_tree().physics_frame
	#camera.position_smoothing_enabled = true"""

func get_collision_layer_number(body: CollisionObject2D)->int: 
	#Ne sert plus a rien mais je mets ca la si jamais
	for i in range(1,33): #Parce que les layers vont de 1 a 33
		if body.get_collision_layer_value(i):
			return i
	return -1 #Donc qu'il n'a pas trouvée
