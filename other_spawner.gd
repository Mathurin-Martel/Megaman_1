@tool
#class_name Spawner
extends Marker2D

enum RespawnType {
	ON_VISIBLE,  ## Respawn if the spawner comes back on screen
	ON_TIMER,    ## Respawn based on cooldown time, starts on spawn
	ON_DEAD      ## Respawn based on cooldown time, starts on dead
}

@export var packed_scene_ref : PackedScene : set = set_packed_scene_ref

@export_category("DEBUG Options")
@export var dont_spawn : bool = false

@export_category("Spawner Options")
## Set to false if enemy should only spawn once and never respawn.
## If set to true, enemy will respawn when spawner enters the visible screen
@export var can_respawn : bool = true :
	get: return _can_respawn
	set(value): _can_respawn = value

## Type of respawn to use if Can Respawn is set to true
@export var respawn_type : RespawnType = RespawnType.ON_VISIBLE

@export var respawn_cooldown_time   : float = 0.0  ## Cooldown time starts after chosen respawn
@export var randomize_cooldown_time : float = 0.0 ## If non zero, adds random up to value to cooldown time

var _can_respawn : bool = true

var _ready_to_respawn : bool = true
var _enemy_currently_on_screen : bool = false

#var _spawn_manager : SpawnManager = null

@onready var _spawn_ref : PackedScene

@onready var respawn_timer : Timer = $RespawnTimer
@onready var visibility_notifier : VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_spawn_manager = Global.Game_Manager.spawn_manager
	
	if packed_scene_ref:
		_spawn_ref = load(packed_scene_ref.get_path())

	# Connect signals for notigier and timer timeout
	visibility_notifier.screen_entered.connect(self._on_camera_entered)
	visibility_notifier.screen_exited.connect(self._on_camera_exited)
	respawn_timer.timeout.connect(self._on_respawn_timer_timeout)
	
	
## Checks if enemy is able to be spawned, and if so, spawns it
func _spawn_enemy() -> void:
	if dont_spawn:
		return
		
	if not _ready_to_respawn:
		return
	
	
	_ready_to_respawn = false
	_enemy_currently_on_screen = true
	
	#Creates the instance of the scene and adds it to the level
	_instantiate_and_add_to_level()
	
	# Start the timer as soon as spawned if desired
	if _can_respawn and (respawn_type == RespawnType.ON_TIMER) :
		#_prepare_for_respawn()
		pass


func set_packed_scene_ref(value: PackedScene) -> void:
	packed_scene_ref = value
	
	# Get an image of the enemy that will be spawning
	if Engine.is_editor_hint() and packed_scene_ref:
		var packed_scene   : PackedScene = load(packed_scene_ref.get_path())
		var scene_instance : Node = packed_scene.instantiate()
		
		var sprite_node : Sprite2D = Sprite2D.new()
		sprite_node.texture = load("res://Assets/Sprites/Characters/Dr. Light.png")
		
		# If there is a Sprite2D, just use that as the preview
		if scene_instance.has_node("Sprite2D"):
			var temp_sprite_ref : Sprite2D = scene_instance.get_node("Sprite2D")
			sprite_node.texture = temp_sprite_ref.texture
			sprite_node.position = temp_sprite_ref.position
		# Verify the packed scene has the node and the animation we are looking for
		else: if scene_instance.has_node("AnimatedSprite2D"):
			var animated_sprite : AnimatedSprite2D = scene_instance.get_node("AnimatedSprite2D")
			if animated_sprite.sprite_frames.has_animation("idle"):
				sprite_node.texture = animated_sprite.sprite_frames.get_frame_texture("idle", 0)

		add_child(sprite_node)
		scene_instance.queue_free()

# END if Engine.is_editor_hint() and packed_scene_ref:

func _instantiate_and_add_to_level()-> void:
	#_spawn_manager.spawn_enemy(_spawn_ref, global_position, global_rotation)
	var enemy_instance : Node = _spawn_ref.instantiate()
	
	enemy_instance.position = position
	enemy_instance.global_rotation = global_rotation
	get_parent().add_child(enemy_instance)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
