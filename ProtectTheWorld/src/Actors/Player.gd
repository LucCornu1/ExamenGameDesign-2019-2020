extends Actor

signal shoot

export (PackedScene) var bullet = preload("res://src/Actors/Bullet.tscn")
export (float) var fire_cooldown = 1.0
export (int) var health = 5
export (bool) var can_shoot = true

onready var animation: AnimationPlayer = get_node("AnimationPlayer")


func _ready():
	$Timer.wait_time = fire_cooldown


func shoot():
	if can_shoot:
		can_shoot = false
		$Timer.start()
		var dir = Vector2(1, 0).rotated($body.global_rotation)
		var temp: float = dir.y
		dir.y = dir.x
		dir.x = -temp
		emit_signal('shoot', bullet, $body/Position2D.global_position, dir)


func _physics_process(_delta):
	_velocity = move_player()
	_velocity = move_and_slide(_velocity)


func move_player() -> Vector2:
	var out : Vector2
	var dir : Vector2
	var mouse_position: = get_global_mouse_position()
	
	if Input.is_action_pressed("move&shoot"):
		if !(mouse_position.x <= position.x +15 and mouse_position.y <= position.y +15) or !(mouse_position.x >= position.x -15 and mouse_position.y >= position.y -15):
			$body.look_at(mouse_position)
			$body.rotation_degrees -= 90
			dir = (mouse_position - position).normalized()
			out = speed*dir
			out.x = clamp(out.x, -speed, speed)
			out.y = clamp(out.y, -speed, speed)
		shoot()
	
	if Input.is_action_just_pressed("move_down"):
		take_damage(1)
	
	return out


func _on_Timer_timeout():
	can_shoot = true


func take_damage(damage: int):
	health -= damage
	animation.play("Damage_Taken")
	if health <= 0:
		death()


func death():
	animation.play("Death")
	yield(animation, "animation_finished")
	queue_free()
