@tool
extends Control
class_name HUD

@onready var Menu: TextureRect=$Menu/Background
@onready var NombreDeVies: RichTextLabel=$"Menu/1-UPCount/NombresDeVies"
@onready var game_health_progress_bar : TextureProgressBar = $"Game/HealthProgressBar"
@onready var game_energy_progress_bar : TextureProgressBar = $"Game/EnergyProgressBar"
@onready var progress_bar_list={
	NomsCommuns.Weapon_Names.ROLLING_CUTTER:$"Menu/EnergyBars/RollingCutterEnergyBar",
	NomsCommuns.Weapon_Names.SUPER_ARM:$"Menu/EnergyBars/SuperArmEnergyBar",
	NomsCommuns.Weapon_Names.ICE_SLASHER:$"Menu/EnergyBars/IceSlasherEnergyBar",
	NomsCommuns.Weapon_Names.HYPER_BOMB:$"Menu/EnergyBars/HyperBombEnergyBar",
	NomsCommuns.Weapon_Names.FIRE_STORM:$"Menu/EnergyBars/FireStormEnergyBar",
	NomsCommuns.Weapon_Names.THUNDER_BEAM:$"Menu/EnergyBars/ThunderBeamEnergyBar",
	NomsCommuns.Weapon_Names.MAGNET_BEAM:$"Menu/EnergyBars/MagnetBeamEnergyBar"
}
@export var level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.ABANDONED_SAWMILL :
	set(value):
		level_name=value
		if is_inside_tree():
			Menu.set_colors(level_name)

func _ready() -> void:
	EventBus.open_menu.connect(_open_menu)
	EventBus.set_health_bar.connect(_set_health_bar)
	EventBus.set_energy_bar.connect(_set_energy_bar)
	EventBus.set_nombre_de_vie_menu.connect(_set_nombre_de_vie_menu)
	Menu.set_colors(NomsCommuns.Level_Names.ORB_CITY)

func _open_menu():
	pass

func _set_health_bar(current_health:int):
	game_health_progress_bar.value = current_health * game_health_progress_bar.step

func _set_energy_bar(current_energy_level:int, energy_bar_concerne:NomsCommuns.Weapon_Names):
	progress_bar_list[energy_bar_concerne].value = current_energy_level*progress_bar_list[energy_bar_concerne].step
	game_energy_progress_bar.value=progress_bar_list[energy_bar_concerne].value

func _set_nombre_de_vie_menu(current_lives:int): #nombre_de_vie : int
	NombreDeVies.text=str(3)
