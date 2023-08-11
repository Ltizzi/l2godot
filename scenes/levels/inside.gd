extends World

#var outside_level_scene: PackedScene = preload("res://scenes/levels/outside.tscn")



func _on_area_2d_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 1).set_trans(Tween.TRANS_QUAD)
	


func _on_body_entered_inside_level(body):
	#	print("player has entered gate")
	print(body.name)
	print(body)
	if body.name == "Player":
		var tween = create_tween() #no hace falta el get_tree()
		tween.tween_property($Player, "speed", 0, 0.2)
		#get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
		TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
		#get_tree().change_scene_to_packed(outside_level_scene)

