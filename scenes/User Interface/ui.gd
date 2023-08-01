extends CanvasLayer


@onready var laser_label = $BulletCounter/VBoxContainer/Label as Label
@onready var granade_label  = $GranadeCounter/VBoxContainer/Label as Label


func _ready():
	update_laser_text()
	update_granade_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	

func update_granade_text():
	granade_label.text = str(Globals.granade_amount)

#func _process(_delta):
#    laser_label.text = str(Globals.laser_amount)
#	granade_label.text = str(Globals.granade_amount)


