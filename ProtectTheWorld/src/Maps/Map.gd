extends Node2D
class_name Map


func _on_Player_shoot(bullet: PackedScene, _position: Vector2, _direction: Vector2):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)


func _on_Ennemi_shoot(bullet: PackedScene, _position: Vector2, _direction: Vector2):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
