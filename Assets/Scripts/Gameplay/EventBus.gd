extends Node
@warning_ignore_start("unused_signal")

signal freeze_megaman

#Le signal pour tous les ennemis/objets qui ont besoin de connaitre MegaMan
signal PlayerIsHere(player_infos : CharacterBody2D)

#Les signaux pour SuperMainCharacter
signal change_weapon(arme_choisi : NomsCommuns.Weapon_Names)

#Les signaux pour le menu
signal open_menu
#Ces deux signaux sont la parce que je veux stocker les valeurs uniquement dans megaman.gd
signal set_health_bar(current_health : int)
signal set_energy_bar(current_energy_level:int, energy_bar_concerne:NomsCommuns.Weapon_Names)
signal set_nombre_de_vie_menu(current_lives:int)

#Tous les signaux des items se trouvent ici
signal health_restored (restored_health : int)
signal energy_refill (refilled_energy : int)
signal get_weapon (weapon_name : int)

#Pour code_signals.gd
signal entered_ladder(x : float)
signal exited_ladder
signal entered_ladder_high_entrance(x : float)
signal exited_ladder_high_entrance
signal entered_ladder_low_entrance
signal exited_ladder_low_entrance
signal on_rock(rock_id : int, rock_position : Vector2)
signal off_rock(rock_id : int)

#Pour le Super Arm
signal take_rock(rock_id : int)
signal launch_rocks(direction : int)
signal set_rock_shining(rock_id : int)

#Pour animation_megaman.gd
signal entered_ladder_end_platform
signal exited_ladder_end_platform

#Pour camera.gd
signal transition_camera_x_unrestricted(x_marker1:Marker2D, x_marker2:Marker2D)
signal transition_camera_x_restricted(x_marker:Marker2D)
signal transition_camera_y_unrestricted(y_marker1:Marker2D, y_marker2:Marker2D)
signal transition_camera_y_restricted(y_marker:Marker2D)

signal animation_porte_fini
# Utiliser dans les codes EventBus.emit_signal(health_changed,hp)
# ou
# EventBus.emit_signal(item_collected)
@warning_ignore_restore("unused_signal")
