@tool #Pour spawner.gd
extends Node

var chemin_loot ={ #Les chances que j'ai trouvée sur Internet sont sur 128
	NomsCommuns.Item_Names.SCORE_BALL : preload("res://Assets/Scenes/Objets/Score_Ball.tscn"),
	NomsCommuns.Item_Names.HEALTH_REFILL : preload("res://Assets/Scenes/Objets/Health_Refill.tscn"),
	NomsCommuns.Item_Names.ENERGY_REFILL : preload("res://Assets/Scenes/Objets/Energy_Refill.tscn"),
	NomsCommuns.Item_Names.ONE_UP : preload("res://Assets/Scenes/Objets/One_UP.tscn"),
	NomsCommuns.Item_Names.WEAPON_HEART_PLUS : preload("res://Assets/Scenes/Objets/Weapon_Heart+.tscn"),
}

func create(position, type_loot:NomsCommuns.Item_Names, infos_additionnelles:Array[NomsCommuns.Item_Info]) -> SuperLoot:
	var loot : SuperLoot
	
	#Partie Vérification
	if verification_arguments(type_loot, infos_additionnelles):
		loot = chemin_loot[NomsCommuns.Item_Names.SCORE_BALL].instantiate()
		loot.global_position = position
		return loot
	
	loot = chemin_loot[type_loot].instantiate()
	
	if type_loot==NomsCommuns.Item_Names.HEALTH_REFILL || type_loot==NomsCommuns.Item_Names.ENERGY_REFILL:
		#J'ai vérifié plus tot dans verification_arguments(type_loot, infos_additionnelles)
		loot.taille=infos_additionnelles[0]
	elif type_loot==NomsCommuns.Item_Names.WEAPON_HEART_PLUS:
			loot.weapon_name=infos_additionnelles[0]

	#Partie commune
	loot.global_position = position
	return loot

func verification_arguments(type_loot:NomsCommuns.Item_Names, infos_additionnelles:Array[NomsCommuns.Item_Info])->bool:
	if !chemin_loot.has(type_loot):
		print("Error: Le nom n'est pas valide. Retourne une Score Ball")
		return false
		
	if type_loot==NomsCommuns.Item_Names.HEALTH_REFILL || type_loot==NomsCommuns.Item_Names.ENERGY_REFILL:
		if infos_additionnelles.size()!=1:
			print("Error: infos_additionnelles should have 1 arguments. Retourne une Score Ball")
			return false
		else:
			if (infos_additionnelles[0]!=NomsCommuns.Item_Info.SMALL 
				&& infos_additionnelles[0]!=NomsCommuns.Item_Info.LARGE):
				print("Error: infos_additionnelles should be SMALL or LARGE. Retourne une Score Ball")
				return false
	elif type_loot==NomsCommuns.Item_Names.WEAPON_HEART_PLUS:
		if infos_additionnelles.size()!=1:
			print("Error: infos_additionnelles should 1 argument. Retourne une Score Ball")
			return false
		else:
			if (infos_additionnelles[0] in NomsCommuns.Weapon_Names.values() && 
				infos_additionnelles[0] != NomsCommuns.Weapon_Names.MEGA_BUSTER):
				print("Error: infos_additionnelles[1] isn't a valid argument. Retourne une Score Ball")
				return false
	else:
		if infos_additionnelles.size()!=0:
			print("Error: infos_additionnelles should have zero arguments. Retourne une Score Ball")
			return false
	
	return true

func get_chemin_loot():
	return chemin_loot
