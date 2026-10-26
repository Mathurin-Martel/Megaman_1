extends Node

var chemin_projectile : Dictionary[NomsCommuns.Weapon_Names, PackedScene]= {
	NomsCommuns.Weapon_Names.MEGA_BUSTER : preload("res://Assets/Scenes/Megaman/Projectile/Mega_Buster.tscn"),
	NomsCommuns.Weapon_Names.ROLLING_CUTTER : preload("res://Assets/Scenes/Megaman/Projectile/Rolling_Cutter.tscn"),
	# On ne met pas NomsCommuns.Weapon_Names.SUPER_ARM parce qu'on va envoyer un signal a la place
	NomsCommuns.Weapon_Names.ICE_SLASHER : preload("res://Assets/Scenes/Megaman/Projectile/Ice_Slasher.tscn"),
	NomsCommuns.Weapon_Names.FIRE_STORM : preload("res://Assets/Scenes/Megaman/Projectile/Fire_Storm.tscn"),
	NomsCommuns.Weapon_Names.THUNDER_BEAM : preload("res://Assets/Scenes/Megaman/Projectile/Thunder_Beam.tscn"),
	NomsCommuns.Weapon_Names.HYPER_BOMB : preload("res://Assets/Scenes/Megaman/Projectile/Mega_Buster.tscn"),
	NomsCommuns.Weapon_Names.MAGNET_BEAM : preload("res://Assets/Scenes/Megaman/Projectile/Mega_Buster.tscn")
}

func create(position_depart, direction_bullet: int, type_bullet:NomsCommuns.Weapon_Names) -> Array: 
	#Ca ne peut pas être Array[SuperProjectile] a cause de Fire Storm Ball
	var liste_projectiles:Array
	var projectile : SuperProjectile
	if !chemin_projectile.has(type_bullet):
		projectile = chemin_projectile[NomsCommuns.Weapon_Names.MEGA_BUSTER].instantiate()
		print("Error: Le nom de la forme n'est pas valide. Retourne un Mega Buster")
	else:
		projectile = chemin_projectile[type_bullet].instantiate()
	liste_projectiles.append_array(projectile.create(position_depart, direction_bullet))
	
	#Partie commune
	for x in liste_projectiles.size() : 
		liste_projectiles[x].global_position=position_depart
		#Pour certains projectiles comme la boule ca sera réglé dans leur process
	return liste_projectiles

func create_super_arm_rocks(direction_bullet: int):
	EventBus.emit_signal("launch_super_arm", direction_bullet)
