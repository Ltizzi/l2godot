extends CharacterBody2D

var hit_sound: AudioStreamPlayer2D

var active: bool = false
var player_near: bool = false

@export var speed: int = 400
@export var health: int = 100


func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_position
	hit_sound = AudioStreamPlayer2D.new()
	hit_sound.stream = load("res://assets/audio/organic_impact.mp3")
	add_child(hit_sound)


#func _process(delta):
#	if active:
#	#	velocity = 
#		move_and_slide()
		
func _physics_process(_delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI /2


func _on_aggro_area_body_entered(_body):
	active = true
	$AnimationPlayer.play("walk")

func _on_aggro_area_body_exited(_body):
	active = false
	$AnimationPlayer.stop()

func _on_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_position 


func _on_attack_area_body_entered(body):
	player_near = true
	if "hit" in body:
		$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(_body):
	player_near = false
	$AnimationPlayer.stop()
	if active:
		$AnimationPlayer.play("walk")
	

func attack():
	if player_near and health > 0:
		Globals.health-= 20
		
func hit():
	health-=10
	print("boom ",health)
	hit_sound.play()
	for i in range(1):		
		$Skeleton2D/Torso/Torso.material.set_shader_parameter("progress", 1) 
		await get_tree().create_timer(0.04).timeout
		$Skeleton2D/Torso/Torso.material.set_shader_parameter("progress", 0)
		await get_tree().create_timer(0.04).timeout
	if health <= 0:
		speed = 0
		queue_free()
		
func explossion_hit():
	health-=50
	print("boom ",health)
	hit_sound.play()
	if health <= 0:
		queue_free()
