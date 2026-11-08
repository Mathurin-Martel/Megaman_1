@tool 
extends SuperLoot

@onready var sprite2d: Sprite2D=$Animation/Sprite2D
@export var level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.ABANDONED_SAWMILL :
	set(value):
		level_name=value
		if is_inside_tree():
			sprite2d.set_colors(level_name)

func _ready() -> void:
	super._ready()
	signal_name="score_ball"
	sprite2d.set_colors(level_name)
