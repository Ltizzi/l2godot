extends Area2D

@export var speed: int = 1000

var direction: Vector2 = Vector2.UP

func _ready():
	var timer = get_tree().create_timer(2.0).timeout
	timer.connect(_on_timer_timeout)


func _process(delta):
	position += direction * speed * delta	
	#weird "paint tool laser"
#	position += (get_global_mouse_position() -position).normalized() * speed * delta 
	
	
func _on_body_entered(body):
	position = position
	if "hit" in body: #body.has_method("hit")
		body.hit()
	destroy_animation()
	

func _on_timer_timeout():
	destroy_animation()

func destroy_animation():
	$AnimationPlayer.play("destroyed")	
	
func draw_particles():
	speed = 0
	$GPUParticles2D.emitting = true
	
func destroy():
	queue_free()
