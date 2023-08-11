extends CharacterBody2D

var hit_sound: AudioStreamPlayer2D

var pos: Vector2 = Vector2.ZERO
@export var speed: int = 400

var active: bool = false

@export var health: int = 10

var exploded: bool = false

func _ready():
	$Explosion.hide()
	hit_sound = AudioStreamPlayer2D.new()
	hit_sound.stream = load("res://assets/audio/solid_impact.ogg")
	add_child(hit_sound)


func _process(delta):
	
	if active:	
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var colission = move_and_collide(velocity * delta)
		if !exploded:
			look_at(Globals.player_position)
			speed += 30
			if colission:
				speed = 0
				$AnimationPlayer.play("explossion")
				exploded = true
				var id = colission.get_collider_id()
				var instance_object = instance_from_id(id)
				if "explossion_hit" in instance_object:
					instance_object.explossion_hit()
			

func hit():
	print("damage")
	health -= 10
	hit_sound.play()
	for i in range(1):
		$Sprite2D.material.set_shader_parameter("progress", 1.0)
		await get_tree().create_timer(0.04).timeout
		$Sprite2D.material.set_shader_parameter("progress", 0)
		await get_tree().create_timer(0.04).timeout
	if health <= 0:
		speed = 0				
		$AnimationPlayer.play("explossion")
		exploded = true
	
func explossion_hit():
	health -= 50
	hit_sound.play()
	if health <= 0:
		speed = 0
		$AnimationPlayer.play("explossion")
		exploded = true

func _on_aggro_area_body_entered(_body):
	active = true
