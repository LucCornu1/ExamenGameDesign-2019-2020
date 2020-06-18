extends Control

onready var pause_overlay: = get_node("PauseOverlay")

var paused: = false setget set_paused


func _on_HUD_pause():
	self.paused = not paused
	get_tree().set_input_as_handled()


func set_paused(value: bool):
	paused = value
	get_tree().paused = value
	pause_overlay.visible = value


func _on_Menu_button_up():
	self.paused = false


func _on_Pause_button_up():
	_on_HUD_pause()
