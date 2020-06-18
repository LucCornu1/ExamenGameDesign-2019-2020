extends CanvasLayer

signal pause

onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _on_Player_damage_taken(value: int):
	$Margin/Container/HealthBar.value = value


func _physics_process(_delta):
	if Stuff.shield_on:
		animation.play("shield_taken")


func _on_Pause_button_up():
	emit_signal("pause")
