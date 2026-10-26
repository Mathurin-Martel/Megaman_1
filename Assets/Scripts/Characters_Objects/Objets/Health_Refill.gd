extends SuperLoot
class_name HealthRefill #C'est important pour le spawn
var taille:NomsCommuns.Item_Info

func _ready() -> void:
	super._ready()
	signal_name="health_restored"
	#Choix loot donne forcément Small ou Large. Pas besoin de s'en préoccuper ici
	if taille==NomsCommuns.Item_Info.SMALL:
		loot_animation.play("small")
		signal_value=2
	elif taille==NomsCommuns.Item_Info.LARGE:
		loot_animation.play("large")
		signal_value=10
	else:
		loot_animation.play("small")
		signal_value=2
		print("Error: Wrong size. Retourne un Small.")
