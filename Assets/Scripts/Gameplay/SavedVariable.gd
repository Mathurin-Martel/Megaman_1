extends RefCounted
class_name SavedVariable

var valeur #On ne type pas. Valeur peut être un int, un bool, un string, etc...

# Called when the node enters the scene tree for the first time.
func _init(nouvelle_valeur) -> void:
	valeur = nouvelle_valeur

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(nouvelle_valeur) -> void:
	valeur = nouvelle_valeur

func get_valeur():
	return valeur
