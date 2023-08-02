extends Area2D

var rotation_speed: int = 4
var types = ['laser','laser','laser', 'granade', 'health']
var type = types[randi() % types.size()]

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
	
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	var healed = false
	#body.add_item(type)
	
	if type == "health" and Globals.health < 100:
		Globals.health += 10
		healed = true
		
	if type == "laser" and Globals.laser_amount < 40:
		Globals.laser_amount += 5
	
	if type == "granade" and Globals.granade_amount < 10:
		Globals.granade_amount +=1
	
	if type != "health" or healed:
		queue_free()
		
