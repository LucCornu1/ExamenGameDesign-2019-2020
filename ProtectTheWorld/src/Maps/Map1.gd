extends Node2D


func _ready():
	set_camera_options()


func set_camera_options():
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y
	
	$Player/Camera2D.zoom.x = 1.0
	$Player/Camera2D.zoom.y = 1.0


func _on_Player_shoot(bullet: PackedScene, _position: Vector2, _direction: Vector2):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
