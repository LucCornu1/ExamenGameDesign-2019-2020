extends Area2D

export (float) var speed = 600.0
export (int) var damage = 1
export (float) var lifetime = 2.0

var velocity: Vector2 = Vector2()


func start(_position: Vector2, _direction: Vector2):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	$Lifetime.start()
	velocity = _direction * speed


func _process(delta):
	position += velocity * delta


func explode():
	queue_free()


func _on_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)


func _on_Lifetime_timeout():
	explode()
