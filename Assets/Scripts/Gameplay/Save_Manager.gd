extends Resource

var savefile_path : String
var saved_variables = {
	NomsCommuns.Type_Donnees_Sauvegarde.PLAYABLE_CHARACTER : {
		NomsCommuns.Playable_Characters.MEGAMAN : {}
		#Rajouter la même ligne pour rajouter des personnages
	},
	NomsCommuns.Type_Donnees_Sauvegarde.WORLD : {}
}

func _init() -> void:
	EventBus.envoi_donnees_sauvegarde.connect(recevoir_donnees_sauvegarde)
	EventBus.envoi_donnees_sauvegarde_character.connect(recevoir_donnees_sauvegarde)

func choose_savefile(savefile_choisi : String):
	savefile_path = "res://SaveFiles/"+savefile_choisi

func recevoir_donnees_sauvegarde(dictionnaire : NomsCommuns.Type_Donnees_Sauvegarde, donnees:Dictionary): 
	#Trouver un moyen de séparer les données du monde (Niveau fini, etc...) des données du personnage
	#Oui dans Megaman il me suffirait de regarder quelle arme il possède mais :
	#1) Comment faire pour les niveaux de Wily?
	#2) Ca me fera moins de trucs a changer pour les prochains jeux
	#Exemple : Séparer les données de la quête principale de celles des quêtes secondaires
	for key in donnees.keys() :
		saved_variables[dictionnaire][key]=donnees[key]

func recevoir_donnees_sauvegarde_character(dictionnaire : NomsCommuns.Type_Donnees_Sauvegarde, character : NomsCommuns.Playable_Characters, donnees:Dictionary): 
	for key in donnees.keys() :
		saved_variables[dictionnaire][character][key]=donnees[key]

func ecriture_savefile():
	ResourceSaver.save(self, savefile_path)

func lecture_savefile():
	if ResourceLoader.exists(savefile_path):
		return load(savefile_path)
	else:
		print("N'a pas trouvé le savefile")
		return null
