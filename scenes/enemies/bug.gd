extends CharacterBody2D

var active: bool = false
var speed: int = 300
var player_near: bool = false

var health: int = 50


@onready var initial_position = position
var going_back: bool = false
var is_arrive: bool = false

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_position)
	if going_back and not active:	
		direction = (initial_position - position).normalized()
		velocity = direction * speed
		$AnimatedSprite2D.play("walk")
		look_at(initial_position)
		move_and_slide()
	#var llego = abs(position.x) < abs(initial_position.x) and abs(position.y) < abs(initial_position.y)
	var llego = abs(position.x) - abs(initial_position.x) < 10 and  abs(position.y) - abs(initial_position.y) < 10 
	if llego and not active:
		$AnimatedSprite2D.stop()
		going_back = false
		is_arrive = true
		health = 50
	
func hit():
	active = true
	health -= 10
	$Node2D/HitParticles.emitting = true
	for i in range(1):		
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1) 
		await get_tree().create_timer(0.04).timeout
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
		await get_tree().create_timer(0.04).timeout
	$Node2D/HitParticles.emitting = true
	if health <= 0:
		$AnimatedSprite2D.visible = false
		#$Node2D/HitParticles.emitting = true
		await get_tree().create_timer(0.5).timeout
		queue_free()

func explossion_hit():
	health -= 50
	active = true
	if health <= 0:
		queue_free()

func _on_notice_area_body_entered(_body):
	active = true
	going_back = false
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()
	going_back = true;


		

func _on_attack_area_body_entered(_body):
	print("attacking")
	player_near = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body):
	player_near = false


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Globals.health -= 10
		$AttackCooldown.start()


func _on_attack_cooldown_timeout():
	if player_near:
		$AnimatedSprite2D.play("attack")
