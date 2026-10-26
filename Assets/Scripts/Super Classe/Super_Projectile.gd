extends CharacterBody2D
class_name SuperProjectile

@onready var animation_player : AnimationPlayer = $Animation/AnimationPlayer
@onready var sprite2d : Sprite2D = $Animation/Sprite2D
@onready var area2d : Area2D = $Area2D
@onready var visible_notifier : VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@export var speed=100
@export var speed_multiplier=2

var direction_bullet : int
var weapon_name : String
var type : NomsCommuns.Weapon_Info = NomsCommuns.Weapon_Info.NONE

func _ready() -> void:
	visible_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	area2d.body_entered.connect(_on_body_entered)
	if direction_bullet==-1:
		sprite2d.flip_h=true
	else : 
		sprite2d.flip_h=false

func create(position_depart : Vector2, direction : int) -> Array:
	global_position=position_depart
	direction_bullet=direction
	return [self]

func set_g_position(new_position : Vector2): #set_global_position et set_position sont déja pris par Godot
	global_position=new_position

func set_type(given_type : NomsCommuns.Weapon_Info):
	type=given_type

func set_direction(direction : int):
	direction_bullet=direction

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body : Node2D):
	if body is SuperEnnemy:
		body.take_damage(weapon_name)
