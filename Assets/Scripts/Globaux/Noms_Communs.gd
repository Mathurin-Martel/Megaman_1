@tool #Pour pouvoir utiliser ses fonctions en mode tool
extends Node

enum Weapon_Names{
	MEGA_BUSTER,
	ROLLING_CUTTER,
	SUPER_ARM,
	ICE_SLASHER,
	HYPER_BOMB,
	FIRE_STORM,
	THUNDER_BEAM,
	MAGNET_BEAM
}

enum Weapon_Info{
	HORIZONTAL_THUNDER_BEAM,
	VERTICAL_THUNDER_BEAM,
	FIRE_STORM_BLAST,
	FIRE_STORM_BALL,
	NONE
}

func weapon_names_to_string(choix_a_traduire:Weapon_Names) -> String:
	match choix_a_traduire:
		Weapon_Names.MEGA_BUSTER:
			return "Mega Buster"
		Weapon_Names.ROLLING_CUTTER:
			return "Rolling Cutter"
		Weapon_Names.SUPER_ARM:
			return "Super Arm"
		Weapon_Names.ICE_SLASHER:
			return "Ice Slasher"
		Weapon_Names.FIRE_STORM:
			return "Fire Storm"
		Weapon_Names.THUNDER_BEAM:
			return "Thunder Beam"
		Weapon_Names.HYPER_BOMB:
			return "Hyper Bomb"
		Weapon_Names.MAGNET_BEAM:
			return "Magnet Beam"
	return "Error : Weapon Name not valid. It's "+str(choix_a_traduire)

func weapon_info_to_string(choix_a_traduire:Weapon_Info) -> String:
	match choix_a_traduire:
		Weapon_Info.HORIZONTAL_THUNDER_BEAM:
			return "Horizontal Thunder Beam"
		Weapon_Info.VERTICAL_THUNDER_BEAM:
			return "Vertical Thunder Beam"
		Weapon_Info.FIRE_STORM_BLAST:
			return "Fire Storm Blast"
		Weapon_Info.FIRE_STORM_BALL:
			return "Fire Storm Ball"
	return "Error : Weapon Info not valid. It's "+str(choix_a_traduire)

enum Item_Names{
	SCORE_BALL,
	HEALTH_REFILL,
	ENERGY_REFILL,
	ONE_UP,
	WEAPON_HEART_PLUS,
	NONE
}

enum Item_Info{
	SMALL,
	LARGE,
	NONE
}

func item_names_to_string(choix_a_traduire:Item_Names) -> String:
	match choix_a_traduire:
		Item_Names.SCORE_BALL:
			return "Score Ball"
		Item_Names.HEALTH_REFILL:
			return "Health Refill"
		Item_Names.ENERGY_REFILL:
			return "Energy Refill"
		Item_Names.ONE_UP:
			return "1-UP"
		Item_Names.WEAPON_HEART_PLUS:
			return "Weapon Heart Plus"
		Item_Names.NONE:
			return "Item_Names None"
	return "Error : Item Name not valid. It's "+str(choix_a_traduire)

func item_info_to_string(choix_a_traduire:Item_Info) -> String:
	match choix_a_traduire:
		Item_Info.SMALL:
			return "Small"
		Item_Info.LARGE:
			return "Large"
		Item_Info.NONE:
			return "Item_Info None"
	return "Error : Item Info not valid. It's "+str(choix_a_traduire)

enum Level_Names{
	RESIDENTIAL_METROPOLIS, # Niveau d'intro dans Powered UP. Si jamais je veux faire un hub, ce sera celui-la.
	ABANDONED_SAWMILL, # Niveau de Cut Man
	MOUNTAIN_MINES, # Niveau de Guts Man
	FROZEN_JUNGLE, # Niveau de Ice Man
	ORB_CITY, # Niveau de Bomb Man
	STEEL_FOUNDRY, # Niveau de Fire Man
	ELECTRICITY_TOWER, # Niveau de Elec Man
	MAIN_ENTRANCE, # Premier niveau de Wily
	SKYWAY, # Second niveau de Wily
	DRAINAGE_SEWERS, # Troisième niveau de Wily
	MANUFACTORY # Quatrième niveau de Wily
}

func level_name_to_string(choix_a_traduire:Level_Names) -> String:
	match choix_a_traduire:
		Level_Names.RESIDENTIAL_METROPOLIS:
			return "Residential Metropolis"
		Level_Names.ABANDONED_SAWMILL:
			return "Abandoned Sawmill"
		Level_Names.MOUNTAIN_MINES:
			return "Mountain Mines"
		Level_Names.FROZEN_JUNGLE:
			return "Frozen Jungle"
		Level_Names.ORB_CITY:
			return "Orb City"
		Level_Names.STEEL_FOUNDRY:
			return "Steel Foundry"
		Level_Names.ELECTRICITY_TOWER:
			return "Electricity Tower"
		Level_Names.MAIN_ENTRANCE:
			return "Main Entrance"
		Level_Names.SKYWAY:
			return "Skyway"
		Level_Names.DRAINAGE_SEWERS:
			return "Drainage Sewers"
		Level_Names.MANUFACTORY:
			return "Manufactory"
	return "Error : Level_name not valid. It's "+str(choix_a_traduire)
