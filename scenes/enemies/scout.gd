extends CharacterBody2D

var player_nearby: bool = false

var can_laser: bool = true
var can_left_gun_shoot = true
var can_right_gun_shoot = false

signal laser(pos, dir)

func _process(_delta):
	
#	var laser_positions = $LaserSpawnPositions.get_children()
#	var selected_laser_pos = laser_positions[randi() % laser_positions.size()]

	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var pos: Vector2 = alternate_gun()
			var dir: Vector2 = (Globals.player_position - position ).normalized()
			laser.emit(pos, dir)
			can_laser = false
			$LaserCooldown.start()
			
func alternate_gun():

	var laser_positions = $LaserSpawnPositions.get_children()
	
	if can_left_gun_shoot:
		can_left_gun_shoot = false
		can_right_gun_shoot = true
		return laser_positions[0].global_position
	else:
		can_right_gun_shoot = false
		can_left_gun_shoot = true
		return laser_positions[1].global_position
		


func _on_attack_range_body_entered(_body):
	player_nearby = true


func _on_attack_range_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
