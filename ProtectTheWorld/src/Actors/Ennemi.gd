extends Actor

#signal shoot

export (PackedScene) var bullet = preload("res://src/Actors/Bullet.tscn")
export (float) var fire_cooldown = 1.0
export (int) var health = 2
export (bool) var can_shoot = true
export (float) var rotation_speed = 1.1

onready var animation: AnimationPlayer = get_node("AnimationPlayer")

var target = null
var dead: bool = false


func _ready():
	$Timer.wait_time = fire_cooldown


func take_damage(damage: int):
	if health > 0:
		health -= damage
		animation.play("Damage_Taken")
	else:
		death()


func death():
	dead = true
	animation.play("Death")
	$hitbox.set_deferred("disabled", true)
	yield(animation, "animation_finished")
	queue_free()


func _physics_process(delta):
	if target and !dead:
		var target_dir: Vector2 = (target.global_position - global_position).normalized()
		var current_dir: Vector2 = Vector2(1, 0).rotated($body.global_rotation)
		var temp: float = target_dir.y
		target_dir.y = -target_dir.x
		target_dir.x = temp
		$body.global_rotation = current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle()


func _on_Detector_body_entered(body):
	if body.name == "Player":
		target = body


func _on_Detector_body_exited(body):
	if body == target:
		target = null
