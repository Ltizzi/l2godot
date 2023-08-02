extends Area2D

signal body_enter(body)
signal body_exit(body)


func _on_area_2d_body_entered(body):
	body_enter.emit(body)

func _on_area_2d_body_exited(body):
	body_exit.emit(body)
