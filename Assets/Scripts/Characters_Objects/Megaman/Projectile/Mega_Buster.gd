extends SuperProjectile

func _ready() -> void:
	super._ready()
	print("Test visible notifier = "+str(visible_notifier))
	weapon_name="Mega Buster"

func _process(_delta: float) -> void:
	if direction_bullet != -1 && direction_bullet != 1:
		print("Probleme direction")
	else :
		velocity.x = direction_bullet * speed * speed_multiplier
		move_and_slide()
