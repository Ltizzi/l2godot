extends Node

signal stats_change 


var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stats_change.emit()
		
var granade_amount = 5:
	get:
		return granade_amount
	set(value):
		granade_amount = value
		stats_change.emit()
		
var health = 60:
	get:
		return health
	set(value):
		health = value
		stats_change.emit()
