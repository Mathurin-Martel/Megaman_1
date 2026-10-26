@tool 
extends SuperLoot

@onready var sprite2d: Sprite2D=$Animation/Sprite2D
@export var weapon_name : NomsCommuns.Weapon_Names = NomsCommuns.Weapon_Names.ROLLING_CUTTER :
	set(value):
		if check_weapon_name(value):
			weapon_name=value
			if not is_inside_tree():
				return
			sprite2d.set_colors()

func _ready() -> void:
	super._ready()
	signal_name="get_weapon"
	#Choix loot donne forcément Small ou Large. Pas besoin de s'en préoccuper ici
	if !(weapon_name==NomsCommuns.Weapon_Names.MAGNET_BEAM):
		loot_animation.play("Weapon Heart")
		signal_value=2
	else:
		loot_animation.play("Magnet Beam")
		signal_value=10
	sprite2d.set_colors()

func check_weapon_name(new_weapon_name:NomsCommuns.Weapon_Names):
	if (new_weapon_name in NomsCommuns.Weapon_Names.values() && 
		(new_weapon_name != NomsCommuns.Weapon_Names.MEGA_BUSTER &&
		new_weapon_name != NomsCommuns.Weapon_Names.MAGNET_BEAM)) :
		return true
	return false
