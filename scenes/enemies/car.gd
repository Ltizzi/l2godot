extends PathFollow2D

var player_near: bool = false

@onready var line_1: Line2D = $Turret/RayCast2D/Line2D
@onready var line_2: Line2D = $Turret/RayCast2D2/Line2D

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
	$Turret/GunShoot.visible = true
	await get_tree().create_timer(0.3).timeout
	$Turret/GunShoot.visible = false

func _on_aggro_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("laser_load")

func _on_aggro_area_body_exited(_body):
	$AnimationPlayer.stop()
	player_near = false
	line_1.width = 0
	line_2.width = 0
