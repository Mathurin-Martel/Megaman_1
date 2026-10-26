extends Node2D

var liste_checkpoints:Array

func get_checkpoint(checkpoint_number : int):
	liste_checkpoints.clear()
	for child in self.get_children():
		liste_checkpoints.append(child)
	return liste_checkpoints[checkpoint_number]
