extends Control

var arrow = load("res://assets/UI/cursor_pointerFlat_shadow.png")


func _ready():
	Input.set_custom_mouse_cursor(arrow)
