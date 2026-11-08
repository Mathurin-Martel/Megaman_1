@tool
extends SuperSpriteShader

enum Choix_Couleurs_Originales {
	ROUGE,
	BLEU,
	ORANGE,
	BEIGE,
	BLANC,
	NOIR
}

func _init() -> void:
	couleur_originales = {
		Choix_Couleurs_Originales.ROUGE : Color(0.89,0,0.34,1.00),
		Choix_Couleurs_Originales.BLEU : Color(0.00,0.43,0.92,1.00),
		Choix_Couleurs_Originales.ORANGE : Color(0.98,0.59,0.21,1.00),
		Choix_Couleurs_Originales.BEIGE : Color(0.98,0.45,0.37,1.00),
	}
	liste_couleurs_noms_pour_reset = { 
		NomsCommuns.Level_Names.ABANDONED_SAWMILL : Choix_Couleurs_Originales.ROUGE,
		NomsCommuns.Level_Names.MOUNTAIN_MINES : Choix_Couleurs_Originales.ORANGE,
		NomsCommuns.Level_Names.FROZEN_JUNGLE : Choix_Couleurs_Originales.BEIGE,
		NomsCommuns.Level_Names.ORB_CITY : Choix_Couleurs_Originales.BLEU,
		NomsCommuns.Level_Names.STEEL_FOUNDRY : Choix_Couleurs_Originales.BLEU,
		NomsCommuns.Level_Names.ELECTRICITY_TOWER : Choix_Couleurs_Originales.BEIGE,
		NomsCommuns.Level_Names.MAIN_ENTRANCE : Choix_Couleurs_Originales.ROUGE,
		NomsCommuns.Level_Names.SKYWAY : Choix_Couleurs_Originales.BLEU,
		NomsCommuns.Level_Names.DRAINAGE_SEWERS : Choix_Couleurs_Originales.ROUGE,
	}	
	liste_couleur_utilises = {
		#Elle est d'abord rempli par les couleurs de base
		#Quand les joueurs personnaliseront les couleurs ce seront ces valeurs qui seont changés
		NomsCommuns.Level_Names.ABANDONED_SAWMILL : couleur_originales[Choix_Couleurs_Originales.ROUGE],
		NomsCommuns.Level_Names.MOUNTAIN_MINES : couleur_originales[Choix_Couleurs_Originales.ORANGE],
		NomsCommuns.Level_Names.FROZEN_JUNGLE : couleur_originales[Choix_Couleurs_Originales.BEIGE],
		NomsCommuns.Level_Names.ORB_CITY : couleur_originales[Choix_Couleurs_Originales.BLEU],
		NomsCommuns.Level_Names.STEEL_FOUNDRY : couleur_originales[Choix_Couleurs_Originales.BLEU],
		NomsCommuns.Level_Names.ELECTRICITY_TOWER : couleur_originales[Choix_Couleurs_Originales.BEIGE],
		NomsCommuns.Level_Names.MAIN_ENTRANCE : couleur_originales[Choix_Couleurs_Originales.ROUGE],
		NomsCommuns.Level_Names.SKYWAY : couleur_originales[Choix_Couleurs_Originales.BLEU],
		NomsCommuns.Level_Names.DRAINAGE_SEWERS : couleur_originales[Choix_Couleurs_Originales.ROUGE],
	}

func set_colors(level_name : NomsCommuns.Level_Names):
	if level_name in liste_couleur_utilises.keys():
		self.material.set_shader_parameter("shader_color", liste_couleur_utilises[level_name])
	elif level_name in NomsCommuns.Level_Names.values():
		self.material.set_shader_parameter("shader_color", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL])
	else:
		print("Error: level_name isn't valid. It is "+str(level_name))

func personalise_one_color(level_name:NomsCommuns.Level_Names, new_color:Color):
	super.personalise_one_color_only_name(level_name, new_color)

func reset_one(level_name:NomsCommuns.Level_Names):
	super.reset_one_color_only_name(level_name)

func reset_all():
	super.reset_all_only_name()
