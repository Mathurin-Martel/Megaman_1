extends SuperEnnemy

@onready var sprite : Sprite2D=$"Animation/Sprite2D"
@onready var inviciblity_box_left=$"Invicibility Box/Invicibility Box"
@onready var inviciblity_box_right=$"Invicibility Box/Invicibility Box Right"

@export var danger_range :int = 50
@export var shooting_range :int = 0

var is_shooting : bool = false

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	super._process(delta)
	# Add the gravity.
	if !dead:
		if not is_on_floor():
			velocity += get_gravity() * delta
		else: # Donc qu'il est au sol
			where_is_player() #On demande ou se trouve MegaMan
			velocity.x=0 #Le personnage est au sol alors on met sa vélocité a 0. Il ne se déplace qu'en sautant
			if abs(player.global_position.x-global_position.x)<=danger_range:
				jump()
			else:
				if abs(player.global_position.y-global_position.y)<=shooting_range:
					shoot()
		animations_SniperJoe()
		move_and_slide()

func animations_SniperJoe():
	if is_on_floor():
		if direction_player==-1:
			sprite.flip_h=false
		else:
			sprite.flip_h=true
		if !is_shooting:
			specific_animations.play("idle")
		else:
			specific_animations.play("shooting")
	else:
		if direction_player==-1:
			specific_animations.play("jump left")
		else:
			specific_animations.play("jump right")

func jump():
	velocity.y = jump_power
	velocity.x=speed * -direction_player
	activate_deactivate_invincibility_boxes()

func shoot():
	#print("shoot")
	is_shooting=true
	deactivate_both_boxes()

func activate_deactivate_invincibility_boxes():
	if direction_player==-1:
		inviciblity_box_left.disabled=false
		inviciblity_box_left.visible=true
		
		inviciblity_box_right.disabled=true
		inviciblity_box_right.visible=false
	else:
		inviciblity_box_left.disabled=true
		inviciblity_box_left.visible=false
		
		inviciblity_box_right.disabled=false
		inviciblity_box_right.visible=true

func deactivate_both_boxes():
	inviciblity_box_left.disabled=false
	inviciblity_box_left.visible=false
	inviciblity_box_right.disabled=false
	inviciblity_box_right.visible=false
