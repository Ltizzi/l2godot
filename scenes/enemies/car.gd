extends PathFollow2D

var player_near: bool = false

@onready var line_1: Line2D = $Turret/RayCast2D/Line2D
@onready var line_2: Line2D = $Turret/RayCast2D2/Line2D

@onready var gunfire_1: Sprite2D = $Turret/GunShoot
@onready var gunfire_2: Sprite2D = $Turret/GunShoot2

func _ready():
	#line_2.add_point($Turret/RayCast2D2.target_position)
	pass

func _process(delta):
	progress_ratio += 0.01 * delta
	
	if player_near:
		$Turret.look_at(Globals.player_position)
		

func fire():
	if player_near:
		fire_animation()
		Globals.health -= 20
		
		
func fire_animation():
	gunfire_1.modulate.a = 1
	gunfire_2.modulate.a = 1
	#$Turret/GunShoot2.visible = true
	#await get_tree().create_timer(0.3).timeout
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gunfire_1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gunfire_2, "modulate:a", 0, randf_range(0.1, 0.5))
	#$Turret/GunShoot2.visible = false

func _on_aggro_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")

func _on_aggro_area_body_exited(_body):
	#$AnimationPlayer.stop()
	$AnimationPlayer.pause() #pausea la animacion para poder animar los lasers
	player_near = false
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line_1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line_2, "width", 0, randf_range(0.1, 0.5))
#	line_1.width = 0
#	line_2.width = 0
	await tween.finished
	$AnimationPlayer.stop() #detiene la animacion 
