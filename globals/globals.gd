extends Node

signal stats_change 

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stats_change.emit()
		
var granade_amount = 5:
	get:
		return granade_amount
	set(value):
		granade_amount = value
		stats_change.emit()
		
var health = 100:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)  #elige el valor minimo, la suma o 100, previene q el player tenga más de 100hp
		else:
			health = value
			player_hit_sound.play()
		stats_change.emit()
		
var player_position: Vector2

# await get_tree().create_timer(2).timeout hace un timer de 2 segundos y espera q termine

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://assets/audio/solid_impact.ogg")
	add_child(player_hit_sound)
