extends World

@export var level_scene: PackedScene #= preload("res://scenes/levels/inside.tscn")


func _on_gate_player_entered_gate(body):
#	print("player has entered gate")
	print(body.name)
	print(body)
	if body.name == "Player":
		var tween = create_tween() #no hace falta el get_tree()
		tween.tween_property($Player, "speed", 0, 0.2)
		#get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
		get_tree().change_scene_to_packed(level_scene)
