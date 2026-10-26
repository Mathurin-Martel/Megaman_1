extends SuperLoot
class_name EnergyRefill #C'est important pour le spawner
var taille:NomsCommuns.Item_Info

func _ready() -> void:
	super._ready()
	signal_name="energy_refill"
	#Choix loot donne forcément Small ou Large. Pas besoin de s'en préoccuper ici
	if taille==NomsCommuns.Item_Info.SMALL:
		loot_animation.play("small")
		signal_value=2
	elif taille==NomsCommuns.Item_Info.LARGE:
		loot_animation.play("large")
		signal_value=10
	else:
		print("Error lors de la création de l'item : Taille inconnue. Crée un Small a la place")
		loot_animation.play("small")
		signal_value=2
