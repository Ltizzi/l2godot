extends CharacterBody2D

var hit_sound: AudioStreamPlayer2D

signal player_shooted_laser(position, target_direction)
signal player_throwed_granade(position, target_direction)

#signal update_stats() #no es necesaria esta implementacion ya q se comunica directamente el item con la ui

@export var max_speed: int = 500
@export var speed: int = max_speed



var can_shoot_laser: bool = true
var can_throw_granade: bool = true
var just_pressed_primary_action = false
var just_pressed_secondary_action = false

var previous_health: int


func _ready():
	hit_sound = AudioStreamPlayer2D.new()
	hit_sound.stream = load("res://assets/audio/solid_impact.ogg")
	add_child(hit_sound)


func _process(_delta): #con _ no se usa delta
	if previous_health > Globals.health:
		hit_sound.play()
	previous_health = Globals.health
	#movement input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	Globals.player_position = global_position
	
	# rotation handler
	look_at(get_global_mouse_position())
	
	#laser shooting input
	var pressed_shoot_laser = Input.is_action_pressed("primary action")
	var pressed_throw_granade = Input.is_action_pressed("secondary action")
	var target_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	
	if pressed_shoot_laser and can_shoot_laser and Globals.laser_amount > 0:

		Globals.laser_amount -= 1
		#randomly selected a marked 2D for the laser start
		$Arma/LaserStartPosition/GPUParticles2D.emitting = true
		var laser_markers = $Arma/LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		just_pressed_primary_action = true
		can_shoot_laser = false
		$LaserCooldown.one_shot = true
		$LaserCooldown.start()		
		#emit the position we selected

		player_shooted_laser.emit(selected_laser.global_position, target_direction)
		
	if pressed_shoot_laser and !can_shoot_laser and just_pressed_primary_action: 
#		print("laser in cd...")
		just_pressed_primary_action = false
	
	#granade shooting input
	if pressed_throw_granade and can_throw_granade and Globals.granade_amount > 0:
	#	print('granade throwed')
		Globals.granade_amount -= 1
		var granade_launcher_marker = $Arma/GranadeLauncherPosition/Marker2D
		player_throwed_granade.emit(granade_launcher_marker.global_position, target_direction)
		just_pressed_secondary_action = true
		can_throw_granade = false
		$GranadeCooldown.one_shot = true
		$GranadeCooldown.start()
	
	if pressed_throw_granade and !can_throw_granade and just_pressed_secondary_action: 
#		print("granade in CD...")
		just_pressed_secondary_action = false

func _on_laser_cooldown_timer_timeout():	
	can_shoot_laser = true



func _on_granade_cooldown_timer_timeout():
	can_throw_granade = true
	


func hit():
	Globals.health-=10
	
	

func explossion_hit():
	Globals.health-=50


#func add_item(type: String) -> void:
#	if type == 'laser':
#		Globals.laser_amount += 5
#
#	if type == 'granade':
#		Globals.granade_amount += 1
#
##	if type == 'health':
##		print("+health")
#
#	update_stats.emit()
