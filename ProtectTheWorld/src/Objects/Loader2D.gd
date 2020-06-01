extends Area2D

export (float) var reload_cooldown = 5.0

onready var animation: AnimationPlayer = get_node("Ammo_mag/AnimationPlayer")


func _ready():
	$ReloadTimer.wait_time = reload_cooldown


func _on_body_entered(_body):
	Chargeur.is_reloading = true
	$ReloadTimer.start()


func _on_body_exited(_body):
	Chargeur.is_reloading = false
	$ReloadTimer.stop()


func reload():
	Chargeur.b_full = Chargeur.current_mag < Chargeur.max_mag
	if Chargeur.b_full and Chargeur.is_reloading:
		Chargeur.current_mag += 1
		anim(Chargeur.current_mag)


func anim(x: int):
	if x == 1:
		animation.play("Affiche_1")
	elif x == 2:
		animation.play("Affiche_2")
	elif x == 3:
		animation.play("Affiche_3")
	elif x == 4:
		animation.play("Affiche_4")
	elif x == 5:
		animation.play("Affiche_5")


func _on_ReloadTimer_timeout():
	reload()
	if Chargeur.is_reloading:
		_on_body_entered(self)
