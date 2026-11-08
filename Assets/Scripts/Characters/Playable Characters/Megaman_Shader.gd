extends SuperSpriteShader

enum Choix_Couleurs_Originales {
	VERT,
	BLEU,
	ROUGE,
	ORANGE,
	LIGHT_JAUNE,
	JAUNE,
	BLANC,
	GRIS
}

func _init() -> void:
	couleur_originales = {
		Choix_Couleurs_Originales.VERT : Color(0.00,0.58,0.00,1.00),
		Choix_Couleurs_Originales.BLEU : Color(0.12,0.21,0.92,1.00),
		Choix_Couleurs_Originales.ROUGE : Color(0.84,0.15,0.00,1.00),
		Choix_Couleurs_Originales.ORANGE : Color(0.78,0.29,0.04,1.00),
		Choix_Couleurs_Originales.LIGHT_JAUNE : Color(0.98,0.89,0.62,1.00),
		Choix_Couleurs_Originales.JAUNE : Color(0.94,0.73,0.23,1.00),
		Choix_Couleurs_Originales.BLANC : Color(0.98,0.98,0.98,1.00),
		Choix_Couleurs_Originales.GRIS : Color(0.45,0.45,0.45,1.00)
	}
	liste_couleurs_noms_pour_reset = { 
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.GRIS,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC
		},
		NomsCommuns.Weapon_Names.SUPER_ARM: {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ORANGE,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC
		},
		NomsCommuns.Weapon_Names.ICE_SLASHER : {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.BLEU,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC
		},
		NomsCommuns.Weapon_Names.HYPER_BOMB : {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.VERT,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.BLANC
		},
		NomsCommuns.Weapon_Names.FIRE_STORM : {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.ROUGE,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.JAUNE
		},
		NomsCommuns.Weapon_Names.THUNDER_BEAM : {
			Choix_Couleurs.COULEUR1 : Choix_Couleurs_Originales.GRIS,
			Choix_Couleurs.COULEUR2 : Choix_Couleurs_Originales.LIGHT_JAUNE
		}
	}
	liste_couleur_utilises = {
		#Elle est d'abord rempli par les couleurs de base
		#Quand les joueurs personnaliseront les couleurs ce seront ces valeurs qui seont changés
		NomsCommuns.Weapon_Names.ROLLING_CUTTER : {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.GRIS],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC]
		},
		NomsCommuns.Weapon_Names.SUPER_ARM: {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ORANGE],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC]
		},
		NomsCommuns.Weapon_Names.ICE_SLASHER : {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.BLEU],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC]
		},
		NomsCommuns.Weapon_Names.HYPER_BOMB : {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.VERT],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.BLANC]
		},
		NomsCommuns.Weapon_Names.FIRE_STORM : {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.ROUGE],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.JAUNE]
		},
		NomsCommuns.Weapon_Names.THUNDER_BEAM : {
			Choix_Couleurs.COULEUR1 : couleur_originales[Choix_Couleurs_Originales.GRIS],
			Choix_Couleurs.COULEUR2 : couleur_originales[Choix_Couleurs_Originales.LIGHT_JAUNE]
		}
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_colors(weapon_name:NomsCommuns.Weapon_Names):
	if weapon_name==NomsCommuns.Weapon_Names.MEGA_BUSTER || weapon_name==NomsCommuns.Weapon_Names.MAGNET_BEAM:
		material.set_shader_parameter("using_shader", false)
	elif weapon_name in NomsCommuns.Weapon_Names.values():
		material.set_shader_parameter("shader_color_1", liste_couleur_utilises[weapon_name][Choix_Couleurs.COULEUR1])
		material.set_shader_parameter("shader_color_2", liste_couleur_utilises[weapon_name][Choix_Couleurs.COULEUR2])
		material.set_shader_parameter("using_shader", true)
	else:
		print("Error: weapon_name n'est pas valide. It's "+str(NomsCommuns.weapon_names_to_string(weapon_name)))
		return

func personalise_one_color(weapon_name:NomsCommuns.Weapon_Names, couleur:Choix_Couleurs, new_color:Color):
	super.personalise_one_color_avec_color(weapon_name, couleur, new_color)

func reset_one(weapon_name:NomsCommuns.Weapon_Names, couleur:Choix_Couleurs):
	super.reset_one_color_avec_color(weapon_name, couleur)

func reset_all():
	super.reset_all_avec_color()
