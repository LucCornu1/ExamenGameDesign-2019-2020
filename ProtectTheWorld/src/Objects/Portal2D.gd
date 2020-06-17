tool
extends Area2D

export var next_scene: PackedScene
export var alt_scene: PackedScene


func _on_body_entered(_body):
	teleport()


func _get_configuration_warning():
	return "next_scene property can't be empty" if not next_scene else ""


func teleport():
# warning-ignore:return_value_discarded
	if Stuff.shield_on:
		get_tree().change_scene_to(next_scene)
	elif alt_scene != null:
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(alt_scene)
