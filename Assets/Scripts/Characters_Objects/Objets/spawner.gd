@tool
extends Marker2D
class_name Spawner

enum Spawn_Type{
	ENNEMY,
	ITEM,
	ROCK
}

enum Ennemy_Type{
	SNIPER_JOE,
	NONE
}

var EnnemyPath={ #Seuls les spawner peuvent faire apparaitre des objects donc je garde leurs paths ici.
	Ennemy_Type.SNIPER_JOE:preload("res://Assets/Scenes/Ennemies/Mobs/sniper_joe.tscn")
}

var RockPath = preload("res://Assets/Scenes/Objets/Rock.tscn")

@onready var preview : Sprite2D = $Preview
@onready var visible_notifier : VisibleOnScreenNotifier2D = get_node("VisibleOnScreenNotifier2D")
@export var spawn_type : Spawn_Type = Spawn_Type.ENNEMY :
	set(value):
		spawn_type = value
		erase_informations_by_spawn_type()
@export var spawned_ennemy : Ennemy_Type = Ennemy_Type.NONE :
	set(value):
		if spawn_type == Spawn_Type.ENNEMY :
			spawned_ennemy=value
			if value!=Ennemy_Type.NONE:
				update_visual_and_notifier()
@export var spawned_item : NomsCommuns.Item_Names = NomsCommuns.Item_Names.NONE :
	set(value):
		if spawn_type == Spawn_Type.ITEM :
			spawned_item=value
			spawned_item_info=change_item_info_from_spawned_item()
			if value!=NomsCommuns.Item_Names.NONE:
				update_visual_and_notifier()
@export var spawned_item_info : NomsCommuns.Item_Info = NomsCommuns.Item_Info.NONE :
	set(value):
		spawned_item_info=change_item_info_from_spawned_item_info(value)
		update_visual_and_notifier()
var spawner_free : bool = true
var player : SuperMainCharacter = null

func _ready() -> void:
	update_visual_and_notifier()
	preview.visible = Engine.is_editor_hint()
	if !Engine.is_editor_hint() :
		EventBus.PlayerIsHere.connect(_get_player_infos)
	#Si je suis dans l'éditeur le preview est visible si je suis dans le jeu il est invisible

func erase_informations_by_spawn_type():
	if spawn_type == Spawn_Type.ENNEMY:
		spawned_item=NomsCommuns.Item_Names.NONE
		spawned_item_info=NomsCommuns.Item_Info.NONE
	elif spawn_type == Spawn_Type.ITEM:
		spawned_ennemy=Ennemy_Type.NONE
	elif spawn_type == Spawn_Type.ROCK:
		spawned_ennemy=Ennemy_Type.NONE
		spawned_item=NomsCommuns.Item_Names.NONE
		spawned_item_info=NomsCommuns.Item_Info.NONE
	else :
		print("Error: spawn_type is not valid")

func change_item_info_from_spawned_item()->NomsCommuns.Item_Info:
	if spawned_item==NomsCommuns.Item_Names.HEALTH_REFILL || spawned_item==NomsCommuns.Item_Names.ENERGY_REFILL :
		if spawned_item_info==NomsCommuns.Item_Info.NONE :
			#Si je change mon objet a Health/Energy Refill ca se met automatiquement sur Small
			return NomsCommuns.Item_Info.SMALL
		#C'était déja a Small ou Large donc je ne change rien quand je change mon objet a Health/Energy Refill
		else :
			return spawned_item_info
	else :
		#Je change a un objet qui n'a pas besoin de Small ou Large
		return NomsCommuns.Item_Info.NONE

func change_item_info_from_spawned_item_info(item_info : NomsCommuns.Item_Info)->NomsCommuns.Item_Info:
	if spawn_type == Spawn_Type.ITEM :
		if spawned_item == NomsCommuns.Item_Names.HEALTH_REFILL || spawned_item == NomsCommuns.Item_Names.ENERGY_REFILL :
			if item_info == NomsCommuns.Item_Info.SMALL || item_info == NomsCommuns.Item_Info.LARGE:
				return item_info
			else: 
				return NomsCommuns.Item_Info.NONE
		else:
			return NomsCommuns.Item_Info.NONE
	else : 
		return NomsCommuns.Item_Info.NONE

func update_visual_and_notifier():
	if not is_inside_tree():
		return
	preview.show()
	var spawned_object
	var animation_player
	if spawn_type == Spawn_Type.ENNEMY && spawned_ennemy != Ennemy_Type.NONE:
		spawned_object = EnnemyPath[spawned_ennemy].instantiate()
		animation_player = spawned_object.get_node("Animation/SpecificAnimations")
		animation_player.play("RESET")
	elif spawn_type == Spawn_Type.ITEM && spawned_item != NomsCommuns.Item_Names.NONE: 
		var chemin_loot=ChoixLoot.get_chemin_loot()
		spawned_object = chemin_loot[spawned_item].instantiate()
		animation_player = spawned_object.get_node("Animation/LootAnimations")
		if spawned_object is HealthRefill || spawned_object is EnergyRefill :
			if spawned_item_info==NomsCommuns.Item_Info.SMALL :
				animation_player.play("small")
			elif spawned_item_info==NomsCommuns.Item_Info.LARGE :
				animation_player.play("large")
			else:
				print("Error: spawned_item_info isn't valid. It's equal to : "+str(spawned_item_info))
	elif spawn_type == Spawn_Type.ROCK :
		spawned_object = RockPath.instantiate()
		animation_player = spawned_object.get_node("Animation/AnimationPlayer")
		animation_player.play("RESET")
	else:
		print("Error : spawn_type isn't valid")
		return
	animation_player.advance(0)
	var sprite = spawned_object.get_node("Animation/Sprite2D")
	preview.texture = sprite.texture
	preview.region_enabled = sprite.region_enabled
	preview.region_rect = sprite.region_rect
	change_visible_notifier_shape(sprite.region_rect.size.x, sprite.region_rect.size.y)
	spawned_object.queue_free()
#Rajouter le changement de shape de la hitbox

func change_visible_notifier_shape(new_w, new_h):
	var x = new_w / -2
	var y = new_h / -2
	visible_notifier.rect = Rect2(x, y, new_w, new_h)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if spawner_free:
		if spawn_type == Spawn_Type.ENNEMY :
			spawn_ennemy()
		elif spawn_type == Spawn_Type.ITEM :
			spawn_item()
		elif spawn_type == Spawn_Type.ROCK :
			spawn_rock()
		else:
			print("Error : Can't spawn anything. Spawn_type isn't valid.")

func spawn_ennemy():
	#On a déja vérifié dans la fonction précédente que spawned_ennemy n'était pas égale a NONE
	if spawned_ennemy!=null :
		var ennemy = EnnemyPath[spawned_ennemy].instantiate()
		if ennemy!=null:
			ennemy.free_spawner.connect(_free_spawner)
			ennemy.set_player_infos(player)
			add_child(ennemy) #Gardez le add_child ici sinon il va décaler l'ennemi quand il spawnera
			ennemy.global_position = global_position
			spawner_free=false
		else:
			print("Error: ennemy==null")
	else:
		print("Error: spawned_ennemy==null")

func spawn_item():
	if spawned_item!=null :
		#print(spawned_item)
		var chemin_loot=ChoixLoot.get_chemin_loot()
		var item = chemin_loot[spawned_item].instantiate()
		#print("Test item:"+str(item))
		if item!=null:
			item.free_spawner.connect(_free_spawner)
			add_child(item) #Gardez le add_child ici sinon il va décaler l'ennemi quand il spawnera
			item.global_position = global_position
			#print("a spawné l'item")
		else:
			print("Error: item==null")
	else:
		pass
		print("Error: spawned_item==null")

func spawn_rock():
	var rock=RockPath.instantiate()
	rock.free_spawner.connect(_free_spawner)
	rock.set_level_name(GameManager.get_level_name())
	add_child(rock) #Gardez le add_child ici sinon il va décaler l'ennemi quand il spawnera
	rock.global_position = global_position
	spawner_free=false

func _free_spawner():
	spawner_free=true

func _get_player_infos(player_infos : SuperMainCharacter):
	player = player_infos
