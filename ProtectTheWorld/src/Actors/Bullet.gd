extends Actor

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_position = get_global_mouse_position()
	_velocity = (new_position - position)
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_velocity.x = clamp(_velocity.x, -500.0, 500.0)
	_velocity.y = clamp(_velocity.y, -500.0, 500.0)
	_velocity = move_and_slide(_velocity)
	return
