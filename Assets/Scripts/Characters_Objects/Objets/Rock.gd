@tool
extends StaticBody2D

signal free_spawner

enum Rock_Type{
	BRIQUES,
	METAL,
	ORDINATEUR,
	POUSSIERE
}

enum Brique_Type{
	JAUNE,
	VERT,
	BLEU
}

enum Rock_State{
	ON_GROUND,
	TAKEN,
	THROWN
}

@onready var animation_player : AnimationPlayer = $Animation/AnimationPlayer
@onready var sprite2D : Sprite2D = $Animation/Sprite2D
@onready var area2D : Area2D = $Area2D
var liste_animations = {
	NomsCommuns.Level_Names.ABANDONED_SAWMILL : "Briques",
	NomsCommuns.Level_Names.MOUNTAIN_MINES : "Poussiere",
	NomsCommuns.Level_Names.ELECTRICITY_TOWER : "Ordinateur",
	NomsCommuns.Level_Names.MAIN_ENTRANCE : "Metal",
	NomsCommuns.Level_Names.DRAINAGE_SEWERS : "Briques",
	NomsCommuns.Level_Names.MANUFACTORY : "Metal"
}
@export var level_name : NomsCommuns.Level_Names = NomsCommuns.Level_Names.MOUNTAIN_MINES :
	set(value):
		print("level_name set_value")
		level_name = value
		if is_inside_tree():
			print("Test is_inside_tree")
			sprite2D.set_colors(level_name)
			set_rock_type()
@export var horizontal_speed : int = 300
@export var vertical_speed : int = 100
var rock_marker : Marker2D
var rocks_blueprint = preload("res://Assets/Scenes/Megaman/Projectile/Mini_Rock.tscn")
var moving_body : CharacterBody2D = null
var rock_state : Rock_State = Rock_State.ON_GROUND
var corps_en_contact=[]
var direction_rock : int = 0

func _ready() -> void:
	sprite2D.set_colors(level_name)
	set_rock_type()
	#Peut être mettre la déclaration get_level_name() ici.
	if !Engine.is_editor_hint() :
		EventBus.take_rock.connect(_take_rock)
		EventBus.launch_rocks.connect(_launch_rocks)
		EventBus.set_rock_shining.connect(_set_rock_shining)

func _process(delta: float) -> void:
	if rock_state == Rock_State.THROWN :
		if !corps_en_contact.is_empty():
			var first_rock = rocks_blueprint.instantiate()
			var liste_projectiles = first_rock.create(self.global_position, direction_rock)
			for x in liste_projectiles.size():
				liste_projectiles[x].set_level_name(level_name)
				GameManager.get_current_level().add_child(liste_projectiles[x])
			moving_body.queue_free()
			print("Crée petit projectiles")
		else :
			print("moving_body.get_gravity() = "+str(moving_body.get_gravity()))
			moving_body.velocity.y = moving_body.velocity.y + moving_body.get_gravity().y * delta
			moving_body.move_and_slide()

func set_level_name(current_level_name : NomsCommuns.Level_Names):
	level_name = current_level_name

func set_rock_type():
	if level_name in liste_animations.keys() :
		print("Test set_rock_type : level_name = "+str(NomsCommuns.level_name_to_string(level_name)))
		animation_player.play(liste_animations[level_name])
	else:
		animation_player.play(liste_animations[NomsCommuns.Level_Names.ABANDONED_SAWMILL])

func _take_rock(rock_id : int):
	if rock_id == get_instance_id():
		rock_state = Rock_State.TAKEN
		self.reparent(rock_marker)
		self.position.x = 0.0
		self.position.y = -32.0
		self.set_collision_layer_value(9,false)

func _launch_rocks(direction : int):
	if rock_state == Rock_State.TAKEN :
		rock_state = Rock_State.THROWN
		direction_rock = direction
		moving_body = CharacterBody2D.new()
		moving_body.global_position.x = self.global_position.x + (20 * direction_rock)
		moving_body.global_position.x = self.global_position.x + 8
		GameManager.get_current_level().add_child(moving_body)
		self.reparent(moving_body)
		moving_body.velocity = Vector2(horizontal_speed * direction_rock,-vertical_speed)
		moving_body.move_and_slide()

func _set_rock_shining(node_id : int):
	#Le joueur envoie l'id du rocher le plus proche de lui. Si l'id correspond le rocher scintille. 
	#Sinon il arrete de scintiller
	if self.get_instance_id() == node_id :
		animation_player.play("Shining")
	else : 
		set_rock_type()

func _on_body_entered(body: Node2D) -> void:
	if body is MegaMan :
		EventBus.emit_signal("on_rock", get_instance_id(), self.global_position)
		rock_marker = body.get_rock_marker()
	else :
		if body is SuperEnnemy || body is TileMapLayer :
			corps_en_contact.append(body.get_instance_id())
			#print(("corps_en_contact = "+str(corps_en_contact)))

func _on_body_exited(body: Node2D) -> void:
	if body is MegaMan :
		EventBus.emit_signal("off_rock", get_instance_id())
		#Megaman n'envoie pas de signal en sortant. On gère le non-scintillement ici.
		set_rock_type()
	else :
		if body is SuperEnnemy || body is TileMapLayer :
			corps_en_contact.erase(body.get_instance_id())
			#print(("corps_en_contact = "+str(corps_en_contact)))

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if rock_state == Rock_State.THROWN :
		moving_body.queue_free()
	else:
		queue_free()
	emit_signal("free_spawner")
