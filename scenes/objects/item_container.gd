extends StaticBody2D

class_name  ItemContainer


signal open(pos, direction)


var container = true
var opened: bool = false

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

func hit():
	print("object")
