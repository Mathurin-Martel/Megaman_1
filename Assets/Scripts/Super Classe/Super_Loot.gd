extends CharacterBody2D
class_name SuperLoot

signal free_spawner

#Note pour plus tard. Pour les objets changeant de couleur selon le niveau ou le boss faire une super class CameleonItem héritant de SuperLoot
@onready var loot_animation : AnimationPlayer = $Animation/LootAnimations
var signal_name : String
var signal_value = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_body_entered(body:Node2D):
	if body is MegaMan:
		if signal_value==null:
			EventBus.emit_signal(signal_name)
		else:
			EventBus.emit_signal(signal_name, signal_value)
		emit_signal("free_spawner")
		queue_free()
	
func _on_screen_exited():
	emit_signal("free_spawner")
	#Le signal ne sert a rien si c'est du loot d'ennemi mais il sert s'il vient d'un spawner
	queue_free()
