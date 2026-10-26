extends SuperProjectile

func _ready() -> void:
	super._ready()
	animation_player.play("Ice")

func _process(_delta: float) -> void:
	if direction_bullet != -1 && direction_bullet != 1:
		print("Problème direction")
	else :
		velocity.x = direction_bullet * speed * speed_multiplier
		move_and_slide()
