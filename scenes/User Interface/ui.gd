extends CanvasLayer


@onready var laser_label = $BulletCounter/VBoxContainer/Label as Label
@onready var laser_icon = $BulletCounter/VBoxContainer/TextureRect as TextureRect
@onready var granade_label  = $GranadeCounter/VBoxContainer/Label as Label
@onready var granade_icon = $GranadeCounter/VBoxContainer/TextureRect as TextureRect
@onready var health_bar = $HealthBar/TextureProgressBar as TextureProgressBar

var green: Color = Color("3ffd76")
var red: Color = Color(0.9, 0, 0, 1)#"eb1139"

func _ready():
	Globals.connect("health_change", update_health_text)
	Globals.connect("ammo_change", update_stats)
	update_stats()

func update_stats():
	update_laser_text()
	update_granade_text()
	update_health_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color("laser", Globals.laser_amount)


func update_granade_text():
	granade_label.text = str(Globals.granade_amount)
	update_color("granade", Globals.granade_amount)
	
func update_health_text():
	health_bar.value = Globals.health
		

#func change_laser_ui_color(color:Color):
#	laser_label.modulate = color
#	laser_icon.modulate = color
#
#func change_granade_ui_color(color: Color):
#	granade_label.modulate = color
#	granade_icon.modulate = color

func calc_color(amount: int):
	if amount >0:
		return green
	else:
		return red
	
func update_color(element: String, amount: int):
	if element == "laser":
		laser_label.modulate = calc_color(amount)
		laser_icon.modulate = calc_color(amount)
	if element == "granade":
		granade_label.modulate = calc_color(amount)
		granade_icon.modulate = calc_color(amount)

#func _process(_delta):
##    laser_label.text = str(Globals.laser_amount)
##	granade_label.text = str(Globals.granade_amount)
#pass

