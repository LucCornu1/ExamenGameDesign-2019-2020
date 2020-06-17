tool
extends Button

export(String, FILE) var next_Scene_Path: = ""

func _on_PlayButton_button_up():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_Scene_Path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_Scene_Path == "" else ""
