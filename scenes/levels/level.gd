extends Node2D

class_name World

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")





func _on_player_shooted_laser(pos, tar_dir):
#	print("laser from level")
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
#	laser.rotation = tar_dir.angle() #rotation en radianes
	laser.rotation_degrees = rad_to_deg(tar_dir.angle()) + 90
	laser.direction = tar_dir
	$Projectiles.add_child(laser)
	$UI.update_laser_text()
	


func _on_player_throwed_granade(pos, tar_dir):
#	print("granade from level")
	var granade  = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = tar_dir * granade.speed
	$Projectiles.add_child(granade)
	$UI.update_granade_text()



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


#func _on_player_update_stats():
#	$UI.update_stats()
