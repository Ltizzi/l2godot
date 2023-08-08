extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
@export var speed: int = 400

var active: bool = false

@export var health: int = 50

var exploded: bool = false

func _ready():
	$Explosion.hide()


func _process(delta):
	
	if active:	
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var colission = move_and_collide(velocity * delta)
		if !exploded:
			look_at(Globals.player_position)
			speed += 10
			if colission:
				speed = 0
				$AnimationPlayer.play("explossion")
				exploded = true
				var id = colission.get_collider_id()
				var instance_object = instance_from_id(id)
				print(instance_object)
				if "explossion_hit" in instance_object:
					instance_object.explossion_hit()

func hit():
	print("damage")
	health -= 10
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
	if health <= 0:
		speed = 0
		$AnimationPlayer.play("explossion")
		exploded = true

func _on_aggro_area_body_entered(_body):
	active = true
