extends RigidBody2D

@export var speed: int = 1500

var boom = false

var is_light_turn_in = true

var explossion_radius: int = 500


func _ready():
	
	$PointLight2D.energy = 0
	
#func _process(_delta):
#	if boom:
#		pass

func explode():
	$AnimationPlayer.play("Explosion")
	boom = true
	var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entities")
	for target in targets:
		var in_range = target.global_position.distance_to(global_position) < explossion_radius
		if "explossion_hit" in target and in_range:
			target.explossion_hit()
		if "hit" in target and in_range and target.is_in_group("Container"):
			target.hit()


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
