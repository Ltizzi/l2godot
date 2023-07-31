extends RigidBody2D

@export var speed: int = 1500

var boom = true

var is_light_turn_in = true

func _ready():
	
	$PointLight2D.energy = 0
	
		

func explode():
	$AnimationPlayer.play("Explosion")


func change_energy():
	if is_light_turn_in:
		$PointLight2D.energy = 0
		is_light_turn_in = false
	else:
		$PointLight2D.energy = 10
		is_light_turn_in = true

func _on_timer_timeout():
	$PointLight2D.energy = 0
	explode()
