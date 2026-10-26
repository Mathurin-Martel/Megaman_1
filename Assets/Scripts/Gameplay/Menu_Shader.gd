@tool
extends TextureRect

enum Choix_Couleurs {
	COULEUR1,
	COULEUR2,
	COULEUR3
}

enum Choix_Couleurs_Originales {
	MARRON,
	LIGHT_VERT,
	VERT,
	DEEP_VERT,
	VERT_MARRON,
	VERT_BLEU,
	BLEU_VERT,
	DEEP_BLEU,
	LIGHT_ROUGE,
	ROUGE,
	ORANGE,
	JAUNE_ORANGE,
	BEIGE,
	BLANC,
	BLANC_OEUF,
	LIGHT_GRIS,
	GRIS,
	NOIR
}

var couleur_originales = {
	Choix_Couleurs_Originales.MARRON : Color(0.48,0.03,0.00,1.00),#GutsMan3/BombMan3/Wily4_1
	Choix_Couleurs_Originales.LIGHT_VERT : Color(0.50,0.81,0.06,1.00),#BombMan1/
	Choix_Couleurs_Originales.VERT : Color(0.00,0.58,0.00,1.00),#BombMan2/
	Choix_Couleurs_Originales.DEEP_VERT : Color(0.00,0.26,0.00,1.00),#IceMan2/
	Choix_Couleurs_Originales.VERT_MARRON : Color(0.53,0.43,0.00,1.00),#Wily2_2/
	Choix_Couleurs_Originales.VERT_BLEU : Color(0.34,0.97,0.59,1.00),#Wily2_1/
	Choix_Couleurs_Originales.BLEU_VERT : Color(0.00,0.50,0.53,1.00),#IceMan3/#Wily2_3/
	Choix_Couleurs_Originales.DEEP_BLEU : Color(0.00,0.00,0.65,1.00),#Wily1_3/
	Choix_Couleurs_Originales.LIGHT_ROUGE : Color(0.84,0.15,0.00,1.00),#Wily3_1/
	Choix_Couleurs_Originales.ROUGE : Color(0.64,0.00,0.00,1.00),#FireMan3
	Choix_Couleurs_Originales.ORANGE : Color(0.78,0.29,0.04,1.00),#GutsMan2/ElecMan3/Wily4_3
	Choix_Couleurs_Originales.JAUNE_ORANGE : Color(0.98,0.59,0.21,1.00),#ElecMan2/
	Choix_Couleurs_Originales.BEIGE : Color(0.98,0.45,0.37,1.00),#GutsMan1/Wily3_2
	Choix_Couleurs_Originales.BLANC : Color(0.98,0.98,0.98,1.00), #CutMan1/IceMan1/FireMan1/ElecMan1/Wily1_1
	Choix_Couleurs_Originales.BLANC_OEUF : Color(0.98,0.84,0.65,1.00),#Wily4_2
	Choix_Couleurs_Originales.LIGHT_GRIS : Color(0.73,0.73,0.73,1.00),#CutMan2//FireMan2
	Choix_Couleurs_Originales.GRIS : Color(0.45,0.45,0.45,1.00),#CutMan3/Wily1_2
	Choix_Couleurs_Originales.NOIR : Color(0.00,0.00,0.00,1.00)#Wily3_3
}

var liste_couleurs_noms_pour_reset = { 
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.LIGHT_GRIS,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.GRIS
	},
	NomsCommuns.Level_Names.MOUNTAIN_MINES : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BEIGE,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ORANGE,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.MARRON
	},
	NomsCommuns.Level_Names.FROZEN_JUNGLE : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.DEEP_VERT,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.BLEU_VERT
	},
	NomsCommuns.Level_Names.ORB_CITY : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.LIGHT_VERT,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.VERT,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.MARRON
	},
	NomsCommuns.Level_Names.STEEL_FOUNDRY : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.LIGHT_GRIS,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ROUGE
	},
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.JAUNE_ORANGE,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ORANGE
	},
	NomsCommuns.Level_Names.MAIN_ENTRANCE : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.GRIS,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.DEEP_BLEU
	},
	NomsCommuns.Level_Names.SKYWAY : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.VERT_BLEU,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.VERT_MARRON,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.BLEU_VERT
	},
	NomsCommuns.Level_Names.DRAINAGE_SEWERS : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.LIGHT_ROUGE,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BEIGE,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
	},
	NomsCommuns.Level_Names.MANUFACTORY : {
		Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.MARRON,
		Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC_OEUF,
		Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ORANGE
	}
}

var liste_couleur_utilises = {
	#Elle est d'abord rempli par les couleurs de base
	#Quand les joueurs personnaliseront les couleurs ce seront ces valeurs qui seont changés
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.LIGHT_GRIS],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.GRIS]
	},
	NomsCommuns.Level_Names.MOUNTAIN_MINES : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BEIGE],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.MARRON]
	},
	NomsCommuns.Level_Names.FROZEN_JUNGLE : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.DEEP_VERT],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.BLEU_VERT]
	},
	NomsCommuns.Level_Names.ORB_CITY : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.LIGHT_VERT],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.VERT],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.MARRON]
	},
	NomsCommuns.Level_Names.STEEL_FOUNDRY : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.LIGHT_GRIS],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ROUGE]
	},
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.JAUNE_ORANGE],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ORANGE]
	},
	NomsCommuns.Level_Names.MAIN_ENTRANCE : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.GRIS],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.DEEP_BLEU]
	},
	NomsCommuns.Level_Names.SKYWAY : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.VERT_BLEU],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.VERT_MARRON],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.BLEU_VERT]
	},
	NomsCommuns.Level_Names.DRAINAGE_SEWERS : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.LIGHT_ROUGE],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BEIGE],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
	},
	NomsCommuns.Level_Names.MANUFACTORY : {
		Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.MARRON],
		Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC_OEUF],
		Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ORANGE]
	}
}

func set_colors(level_name : NomsCommuns.Level_Names):
	if level_name in liste_couleur_utilises.keys():
		self.material.set_shader_parameter("color_1", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("color_2", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("color_3", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR3])
	elif level_name in NomsCommuns.Level_Names.values():
		self.material.set_shader_parameter("color_1", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("color_2", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("color_3", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR3])
	else:
		print("Error: level_name isn't valid. It is "+str(level_name))

func personalise_one_color(level_name:NomsCommuns.Level_Names, couleur:Choix_Couleurs, new_color:Color):
	if !(level_name in liste_couleur_utilises.keys()):
		print("Error: level_name isn't valid.")
	elif !(couleur in liste_couleur_utilises[level_name].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[level_name][couleur]=new_color

func reset_one(level_name:NomsCommuns.Level_Names, couleur:Choix_Couleurs):
	if !(level_name in liste_couleur_utilises.keys()):
		print("Error: level_name isn't valid.")
	elif !(couleur in liste_couleur_utilises[level_name].keys()):
		print("Error: couleur isn't valid.")
	else:
		liste_couleur_utilises[level_name][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[level_name][couleur]]
		pass

func reset_all():
	for level_name in liste_couleur_utilises.keys():
			for couleur in liste_couleur_utilises[level_name].keys():
				liste_couleur_utilises[level_name][couleur]=couleur_originales[liste_couleurs_noms_pour_reset[level_name][couleur]]
