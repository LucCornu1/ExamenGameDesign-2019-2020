extends Actor

signal shoot

export (PackedScene) var bullet = preload("res://src/Actors/Bullet_ennemi.tscn")
export (float) var fire_cooldown = 0.4
export (int) var health = 3
export (bool) var can_shoot = true
export (float) var rotation_speed = 4

onready var animation: AnimationPlayer = get_node("AnimationPlayer")

var target = null
var dead: bool = false


func _ready():
	$Timer.wait_time = fire_cooldown


func take_damage(damage: int):
	health -= damage
	if health > 0:
		animation.play("Damage_Taken")
	else:
		death()


func death():
	dead = true
	animation.play("Death")
	$hitbox.set_deferred("disabled", true)
	yield(animation, "animation_finished")
	queue_free()


func shoot(dir: Vector2):
	if can_shoot:
		can_shoot = false
		$Timer.start()
		var temp: float = dir.y
		dir.y = dir.x
		dir.x = -temp
		emit_signal('shoot', bullet, $body/Position2D.global_position, dir)


func _on_Timer_timeout():
	can_shoot = true


func _physics_process(delta):
	if target and !dead:
		var target_dir: Vector2 = (target.global_position - global_position).normalized() *2
		var current_dir: Vector2 = Vector2(1, 0).rotated($body.global_rotation)
		var temp: float = target_dir.y
		target_dir.y = -target_dir.x
		target_dir.x = temp
		$body.global_rotation = current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle()
		
		shoot(current_dir)


func _on_Detector_body_entered(body):
	if body.name == "Player":
		animation.play("Warning_on")
		target = body
		if body.has_method("slow"):
			body.slow(true)


func _on_Detector_body_exited(body):
	if body == target:
		animation.play("Warning_off")
		target = null
		if body.has_method("slow"):
			body.slow(false)
