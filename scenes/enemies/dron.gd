extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
@export var speed = 300

#func _ready():
#	pos = Vector2(300,200)
#	position = pos
	

func _process(_delta):
	
	var direction = Vector2.RIGHT
	velocity.x = direction.x  * speed	
	
	move_and_slide()
	
	if position.x > 1200:
		position = Vector2(0, randi_range(0,400))

func hit():
	print("damage")
