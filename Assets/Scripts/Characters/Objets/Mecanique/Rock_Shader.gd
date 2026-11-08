@tool
extends SuperSpriteShader

#Dans ce code Choix_Phase servira a déterminer les couleurs de base de l'objet (original_colors) 
#et les couleurs qui les remplacent (shader_colors)

enum Choix_Couleurs_Originales {
	BLEU_VERT_CLAIR,
	BLEU_VERT,
	BLEU,
	VERT_CLAIR,
	ROUGE,
	ROUGE_MARRON,
	JAUNE,
	JAUNE_ORANGE,
	ORANGE,
	ORANGE_FONCE,
	BLANC_JAUNI,
	BLANC_SUPREME,
	BLANC,
	GRIS,
	NOIR,
}

func _init() -> void:
	couleur_originales = {
		Choix_Couleurs_Originales.BLEU_VERT_CLAIR : Color(0.00,0.90,0.84,1.00),
		Choix_Couleurs_Originales.BLEU_VERT : Color(0.00,0.50,0.53,1.00),
		Choix_Couleurs_Originales.BLEU : Color(0.00,0.00,0.77,1.00),
		Choix_Couleurs_Originales.VERT_CLAIR : Color(0.34,0.97,0.59,1.00),
		Choix_Couleurs_Originales.ROUGE : Color(0.64,0.00,0.00,1.00),
		Choix_Couleurs_Originales.ROUGE_MARRON : Color(0.48,0.03,0.00,1.00),
		Choix_Couleurs_Originales.JAUNE : Color(0.98,0.89,0.62,1.00),
		Choix_Couleurs_Originales.JAUNE_ORANGE : Color(1.00,0.64,0.29,1.00),
		Choix_Couleurs_Originales.ORANGE : Color(0.98,0.59,0.21,1.00),
		Choix_Couleurs_Originales.ORANGE_FONCE : Color(0.90,0.38,0.09,1.00),
		Choix_Couleurs_Originales.BLANC_SUPREME : Color(1.00,1.00,1.00,1.00),
		Choix_Couleurs_Originales.BLANC : Color(0.98,0.98,0.98,1.00),
		Choix_Couleurs_Originales.BLANC_JAUNI : Color(1.00,0.90,0.70,1.00),
		Choix_Couleurs_Originales.GRIS : Color(0.48,0.51,0.51,1.00),
		Choix_Couleurs_Originales.NOIR : Color(0.00,0.00,0.00,1.00),
	}
	liste_couleurs_noms_pour_reset = { 
		NomsCommuns.Level_Names.ABANDONED_SAWMILL : { #Briques Vertes
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.VERT_CLAIR,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ROUGE
		},
		NomsCommuns.Level_Names.MOUNTAIN_MINES : { #Poussiere
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.JAUNE_ORANGE,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC_JAUNI,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ORANGE_FONCE
		},
		NomsCommuns.Level_Names.ELECTRICITY_TOWER : { #Ordinateur
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ORANGE,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
		},
		NomsCommuns.Level_Names.MAIN_ENTRANCE : { #Metal
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.GRIS,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC_SUPREME,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.BLEU
		},
		NomsCommuns.Level_Names.DRAINAGE_SEWERS : { #Briques bleue
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLEU_VERT,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLEU_VERT_CLAIR,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.ROUGE_MARRON
		},
		NomsCommuns.Level_Names.MANUFACTORY : { #Metal
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC_SUPREME,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.GRIS,
			Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.BLEU
		}
	}
	liste_couleur_utilises = {
		#Elle est d'abord rempli par les couleurs de base
		#Quand les joueurs personnaliseront les couleurs ce seront ces valeurs qui seont changés
		NomsCommuns.Level_Names.ABANDONED_SAWMILL : { #Briques Vertes
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.VERT_CLAIR],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ROUGE]
		},
		NomsCommuns.Level_Names.MOUNTAIN_MINES : { #Poussiere
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.JAUNE_ORANGE],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC_JAUNI],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ORANGE_FONCE]
		},
		NomsCommuns.Level_Names.ELECTRICITY_TOWER : { #Ordinateur
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
		},
		NomsCommuns.Level_Names.MAIN_ENTRANCE : { #Metal
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.GRIS],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC_SUPREME],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.BLEU]
		},
		NomsCommuns.Level_Names.DRAINAGE_SEWERS : { #Briques bleue
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLEU_VERT],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLEU_VERT_CLAIR],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.ROUGE_MARRON]
		},
		NomsCommuns.Level_Names.MANUFACTORY : { #Metal
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC_SUPREME],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.GRIS],
			Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.BLEU]
		}
	}

func set_colors(level_name : NomsCommuns.Level_Names):
	if level_name in liste_couleur_utilises.keys():
		print("set_colors level_name in")
		self.material.set_shader_parameter("shader_color_1", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("shader_color_2", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("shader_color_3", liste_couleur_utilises[level_name][Choix_Couleurs.COULEUR3])
	elif level_name in NomsCommuns.Level_Names.values():
		print("set_colors level_name out")
		self.material.set_shader_parameter("shader_color_1", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("shader_color_2", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("shader_color_3", liste_couleur_utilises[NomsCommuns.Level_Names.ABANDONED_SAWMILL][Choix_Couleurs.COULEUR3])
	else:
		print("Error: level_name isn't valid. It is "+str(level_name))

func personalise_one_color(level_name:NomsCommuns.Level_Names, couleur:Choix_Couleurs, new_color:Color):
	super.personalise_one_color_avec_color(level_name, couleur, new_color)

func reset_one(level_name:NomsCommuns.Level_Names, couleur:Choix_Couleurs):
	super.reset_one_color_avec_color(level_name, couleur)

func reset_all():
	super.reset_all_avec_color()
