extends Node2D

class_name World

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_open)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect('laser', _on_scout_laser)
	for entity in get_tree().get_nodes_in_group("Entity"):
		print(entity)



func _on_player_shooted_laser(pos, tar_dir):
	create_laser(pos, tar_dir) #logica transferida a create_laser
	$UI.update_laser_text()
	


func _on_player_throwed_granade(pos, tar_dir):
#	print("granade from level")
	var granade  = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = tar_dir * granade.speed
	$Projectiles.add_child(granade)
	$UI.update_granade_text()


#func _on_player_update_stats():
#	$UI.update_stats()


func _on_container_open(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	$Items.call_deferred('add_child', item)
	
	
func _on_scout_laser(pos, dir):
	create_laser(pos, dir)
	
func create_laser(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
#	laser.rotation = tar_dir.angle() #rotation en radianes
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)

	
