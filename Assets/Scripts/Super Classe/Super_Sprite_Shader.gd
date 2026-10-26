extends Sprite2D
class_name  SuperSpriteShader

enum Choix_Phase {
	PHASE1,
	PHASE2,
}

enum Choix_Couleurs {
	COULEUR1,
	COULEUR2,
	COULEUR3
}

var couleur_originales : Dictionary

var liste_couleurs_noms_pour_reset : Dictionary

var liste_couleur_utilises : Dictionary

func personalise_one_color_only_name(color_name, new_color:Color): 
	#On ne précise pas color_name parce qu'on ne connait pas son type. 
	#Ca pourrait être Weapon_Name, Level_Name ou autre
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	else:
		liste_couleur_utilises[color_name]=new_color

func personalise_one_color_avec_color(color_name, couleur:Choix_Couleurs, new_color:Color): 
	#On ne précise pas color_name parce qu'on ne connait pas son type. 
	#Ca pourrait être Weapon_Name, Level_Name ou autre
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	elif !(couleur in liste_couleur_utilises[color_name].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[color_name][couleur]=new_color

func personalise_one_color_avec_color_et_phase(color_name, phase : Choix_Phase, couleur:Choix_Couleurs, new_color:Color): 
	#On ne précise pas color_name parce qu'on ne connait pas son type. 
	#Ca pourrait être Weapon_Name, Level_Name ou autre
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	elif !(phase in liste_couleur_utilises[color_name].keys()):
		print("Error: phase isn't valid.")
	elif !(couleur in liste_couleur_utilises[color_name][phase].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[color_name][phase][couleur]=new_color

func reset_one_color_only_name(color_name):
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	else:
		liste_couleur_utilises[color_name]=couleur_originales[liste_couleurs_noms_pour_reset[color_name]]

func reset_one_color_avec_color(color_name, couleur:Choix_Couleurs):
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	elif !(couleur in liste_couleur_utilises[color_name].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[color_name][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[color_name][couleur]]

func reset_one_color_avec_color_et_phase(color_name, phase : Choix_Phase, couleur : Choix_Couleurs):
	if !(color_name in liste_couleur_utilises.keys()):
		print("Error: color_name isn't valid.")
	elif !(phase in liste_couleur_utilises[color_name].keys()):
		print("Error: phase isn't valid.")
	elif !(couleur in liste_couleur_utilises[color_name][phase].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[color_name][phase][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[color_name][phase][couleur]]

func reset_all_only_name():
	for color_name in liste_couleur_utilises.keys():
		liste_couleur_utilises[color_name]=couleur_originales[liste_couleurs_noms_pour_reset[color_name]]

func reset_all_avec_color():
	for color_name in liste_couleur_utilises.keys():
		for couleur in liste_couleur_utilises[color_name].keys():
			liste_couleur_utilises[color_name][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[color_name][couleur]]

func reset_all_avec_color_et_phase():
	for color_name in liste_couleur_utilises.keys():
		for phase in liste_couleur_utilises[color_name].keys():
			for couleur in liste_couleur_utilises[color_name][phase].keys():
				liste_couleur_utilises[color_name][phase][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[color_name][phase][couleur]]
