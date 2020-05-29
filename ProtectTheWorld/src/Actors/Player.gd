extends Actor

export (PackedScene) var bullet = preload("res://src/Actors/Bullet.tscn")
export (float) var rotation_speed = 1.0
export (float) var fire_cooldown = 1.0
export (int) var health = 5


func _ready():
	$Timer.wait_time = fire_cooldown


func _on_Detector_body_entered():
	queue_free()
	if get_tree().change_scene("res://src/Screens/MainScreen.tscn") != OK:
		print("An unexpected error occured when trying to switch to the next scene")
	return


func _physics_process(_delta):
	_velocity = move_player()
	_velocity = move_and_slide(_velocity)


func move_player() -> Vector2:
	var out : Vector2
	var dir : Vector2
	var mouse_position: = get_global_mouse_position()
	
	if Input.is_action_pressed('move&shoot'):
		if !(mouse_position.x <= position.x +15 and mouse_position.y <= position.y +15) or !(mouse_position.x >= position.x -15 and mouse_position.y >= position.y -15):
			$body.look_at(mouse_position)
			$body.rotation_degrees -= 90
			dir = (mouse_position - position).normalized()
			out = speed*dir
			out.x = clamp(out.x, -speed, speed)
			out.y = clamp(out.y, -speed, speed)
	
	return out
