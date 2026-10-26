extends SuperProjectile

func _ready() -> void:
	super._ready()
	if type==NomsCommuns.Weapon_Info.HORIZONTAL_THUNDER_BEAM:
		animation_player.play("Elec Horizontal")
	elif type==NomsCommuns.Weapon_Info.VERTICAL_THUNDER_BEAM:
		animation_player.play("Elec Vertical")
	else:
		print("Error: In Ready : Type is neither Vertical or Horizontal")

func _process(_delta: float) -> void:
	if direction_bullet != -1 && direction_bullet != 1:
		print("Probleme direction")
	else :
		if type==NomsCommuns.Weapon_Info.HORIZONTAL_THUNDER_BEAM:
			velocity.x = direction_bullet * speed * speed_multiplier
		elif type==NomsCommuns.Weapon_Info.VERTICAL_THUNDER_BEAM:
			velocity.y = direction_bullet * speed * speed_multiplier
		else:
			print("Error: In Process :Type is neither Vertical or Horizontal")
		move_and_slide()

func create(position_depart : Vector2, direction : int) -> Array:
	self.global_position = position_depart
	self.type = NomsCommuns.Weapon_Info.HORIZONTAL_THUNDER_BEAM
	self.direction_bullet = direction
	var thunder_beam = load("res://Assets/Scenes/Megaman/Projectile/Thunder_Beam.tscn")
	var projectile_haut : SuperProjectile = thunder_beam.instantiate()
	projectile_haut.set_g_position(position_depart)
	projectile_haut.set_type(NomsCommuns.Weapon_Info.VERTICAL_THUNDER_BEAM)
	projectile_haut.set_direction(-1)
	var projectile_bas : SuperProjectile = thunder_beam.instantiate()
	projectile_haut.set_g_position(position_depart)
	projectile_bas.set_type(NomsCommuns.Weapon_Info.VERTICAL_THUNDER_BEAM)
	projectile_bas.set_direction(1)
	return [self, projectile_haut, projectile_bas]

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(str(body))
