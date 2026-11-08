extends Node

@onready var weapon_little_cooldown : Timer = $"Weapon Little Cooldown"
@onready var ladder_jump_cooldown : Timer = $"Ladder Jump Cooldown"

var on_weapon_little_cooldown=false
var on_ladder_jump_cooldown=false

func start_cooldown(selection:String):
	if selection == "Little Weapon Cooldown":
		on_weapon_little_cooldown=true
		weapon_little_cooldown.start()
	elif selection == "Ladder Jump Cooldown":
		on_ladder_jump_cooldown=true
		ladder_jump_cooldown.start()
	else:
		print("Error : selection isn't equal to anything")

func _on_weapon_little_cooldown_timeout() -> void:
	on_weapon_little_cooldown=false

func _on_ladder_jump_cooldown_timeout() -> void:
	on_ladder_jump_cooldown=false
