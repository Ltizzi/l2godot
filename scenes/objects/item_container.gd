extends StaticBody2D

class_name  ItemContainer

var container_hit_sound : AudioStreamPlayer2D

signal open(pos, direction)


var container = true
var opened: bool = false

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

func _ready():
	container_hit_sound = AudioStreamPlayer2D.new()
	container_hit_sound.stream = load("res://assets/audio/container_hit.mp3")
	add_child(container_hit_sound)

func hit():
	container_hit_sound.play()
	print("object")
