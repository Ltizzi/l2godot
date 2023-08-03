extends Area2D

var rotation_speed: int = 4
var types = ['laser','laser','laser', 'granade', 'health', 'health']
var type = types[randi() % types.size()]

var direction: Vector2

var distance: int = randi_range(150,250)

func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color("d59859")
		$PointLight2D.modulate = Color("d59859")
	if type == "granade":
		$Sprite2D.modulate = Color("b80e08")
		$PointLight2D.modulate = Color("b80e08")
	if type == "health":
		$Sprite2D.modulate = Color("0fea03")
		$PointLight2D.modulate = Color("0fea03")
		
	var target_position =  position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.3)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).from(Vector2(0,0))
	
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	var healed = false
	#body.add_item(type)
	if body.name == "Player":
		
		
		if type == "health" and Globals.health < 100:
			Globals.health += 10
			healed = true
			
		if type == "laser" and Globals.laser_amount < 40:
			Globals.laser_amount += 5
		
		if type == "granade" and Globals.granade_amount < 10:
			Globals.granade_amount +=1
		
		if type != "health" or healed:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self, "scale", Vector2(2, 3), 0.3)
			tween.tween_property(self, "modulate", Color(0,0,0,0), 0.6)
			await get_tree().create_timer(0.61).timeout
			queue_free()
		
