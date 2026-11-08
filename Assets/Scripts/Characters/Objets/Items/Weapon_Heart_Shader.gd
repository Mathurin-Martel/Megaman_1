@tool
extends SuperSpriteShader

@onready var main_script = get_parent().get_parent()

enum Choix_Couleurs_Originales {
	ROUGE,
	ORANGE,
	JAUNE,
	BLEU,
	BLANC,
	NOIR
}

func _init() -> void:
	couleur_originales = {
		Choix_Couleurs_Originales.ROUGE : Color(0.89,0,0.34,1.00),
		Choix_Couleurs_Originales.ORANGE : Color(0.98,0.59,0.21,1.00),
		Choix_Couleurs_Originales.JAUNE : Color(0.98,0.89,0.62,1.00),
		Choix_Couleurs_Originales.BLEU : Color(0.23,0.73,0.98,1.00),
		Choix_Couleurs_Originales.BLANC : Color(0.98,0.98,0.98,1.00),
		Choix_Couleurs_Originales.NOIR : Color(0.00,0.00,0.00,1.00)
	}

	liste_couleurs_noms_pour_reset = { 
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.JAUNE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ROUGE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		},
		NomsCommuns.Weapon_Names.SUPER_ARM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ORANGE,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ROUGE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		},
		NomsCommuns.Weapon_Names.ICE_SLASHER : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLEU,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		},
		NomsCommuns.Weapon_Names.HYPER_BOMB : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.JAUNE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ORANGE,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ROUGE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		},
		NomsCommuns.Weapon_Names.FIRE_STORM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ROUGE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		},
		NomsCommuns.Weapon_Names.THUNDER_BEAM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ORANGE,
				Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.ROUGE,
				Choix_Couleurs.COULEUR3 : Choix_Couleurs_Originales.NOIR
			}
		}
	}

	liste_couleur_utilises = {
		#Elle est d'abord rempli par les couleurs de base
		#Quand les joueurs personnaliseront les couleurs ce seront ces valeurs qui seont changés
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.JAUNE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		},
		NomsCommuns.Weapon_Names.SUPER_ARM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		},
		NomsCommuns.Weapon_Names.ICE_SLASHER : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLEU],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		},
		NomsCommuns.Weapon_Names.HYPER_BOMB : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.JAUNE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		},
		NomsCommuns.Weapon_Names.FIRE_STORM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		},
		NomsCommuns.Weapon_Names.THUNDER_BEAM : {
			Choix_Phase.PHASE1 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			},
			Choix_Phase.PHASE2 : {
				Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
				Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
				Choix_Couleurs.COULEUR3 : couleur_originales[Choix_Couleurs_Originales.NOIR]
			}
		}
	}

func set_colors():
	if main_script.weapon_name in liste_couleur_utilises.keys():
		self.material.set_shader_parameter("shader_color_1_1", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE1][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("shader_color_1_2", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE1][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("shader_color_1_3", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE1][Choix_Couleurs.COULEUR3])
		self.material.set_shader_parameter("shader_color_2_1", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE2][Choix_Couleurs.COULEUR1])
		self.material.set_shader_parameter("shader_color_2_2", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE2][Choix_Couleurs.COULEUR2])
		self.material.set_shader_parameter("shader_color_2_3", liste_couleur_utilises[main_script.weapon_name][Choix_Phase.PHASE2][Choix_Couleurs.COULEUR3])
	else:
		print("Error: weapon_name isn't valid. It is "+str(main_script.weapon_name))

func personalise_one_color(weapon_name:NomsCommuns.Weapon_Names, phase:Choix_Phase, couleur:Choix_Couleurs, new_color:Color):
	super.personalise_one_color_avec_color_et_phase(weapon_name, phase, couleur, new_color)

func reset_one(weapon_name:NomsCommuns.Weapon_Names, phase:Choix_Phase, couleur:Choix_Couleurs):
	super.reset_one_color_avec_color_et_phase(weapon_name, phase, couleur)

func reset_all():
	super.reset_all_avec_color_et_phase()
