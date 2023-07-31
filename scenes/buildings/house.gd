extends Area2D

signal body_enter(body)
signal body_exit(body)


func _on_area_2d_body_entered(body):
	print("body entered the house")
	body_enter.emit(body)

func _on_area_2d_body_exited(body):
	print("body exited the house")
	body_exit.emit(body)
