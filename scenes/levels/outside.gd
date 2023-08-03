extends World

#@export var level_scene: PackedScene #= preload("res://scenes/levels/inside.tscn")


func _on_gate_player_entered_gate(body):
#	print("player has entered gate")
	print(body.name)
	print(body)
	if body.name == "Player":
		var tween = create_tween() #no hace falta el get_tree()
		tween.tween_property($Player, "speed", 0, 0.2)
		#get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
		TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
		#get_tree().change_scene_to_packed(level_scene)

func _on_house_body_enter(body):
	if "container" not in body:
		#cambia el occluder del personaje para solo la luz de la casa
		var occluder = body.get_node("LightOccluder2D")
		occluder.occluder_light_mask = 1
		
		#tween q hace zoom in cuando el player entra
		var tween: Tween = get_tree().create_tween() #no hace falta el get_tree()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8,0.8), 1).set_trans(Tween.TRANS_QUAD)
			
		#godot ejecuta las animaciones en orden
		#para ejecutarlas al mismo tiempo:
		#tween.set_parallel(true)
		#tween de prueba q modifica la transparencia del player a 0, ideal para stealth
		#tween.tween_property($Player, "module:a", 0, 2)
		#
		#tambien, luego de tween_property, se pueden seguir agregando métodos
		#por ej para agregar un valor inicial o modificar la transición o un delay
		
		


func _on_house_body_exit(body):
	#vuelve el estado normal de luz
	if body.name == "Player":
		var occluder = body.get_node("LightOccluder2D")
		occluder.occluder_light_mask = 2
		
		#tween q hace zoom out cuando el player sale
		var tween = get_tree().create_tween()
		tween.tween_property($Player/Camera2D, "zoom", Vector2(0.43, 0.43), 1).set_trans(Tween.TRANS_QUAD)

#
