tool
extends Button

var arrow = load("res://assets/UI/crossair_red.png")
var beam = load("res://assets/UI/cursor_pointerFlat_shadow.png")

export(String, FILE) var next_Scene_Path: = ""


func _on_PlayButton_button_up():
# warning-ignore:return_value_discarded
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
	get_tree().change_scene(next_Scene_Path)


func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_Scene_Path == "" else ""
