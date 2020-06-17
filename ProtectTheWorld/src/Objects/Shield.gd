extends Node2D

onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _on_body_entered(body):
	if body.name == "Player" and !Stuff.shield_on:
		Stuff.shield_on = true
		animation.play("FadeOut")
		yield(animation, "animation_finished")
		queue_free()
