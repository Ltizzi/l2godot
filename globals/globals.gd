extends Node

signal health_change 
signal ammo_change

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		ammo_change.emit()
		
var granade_amount = 5:
	get:
		return granade_amount
	set(value):
		granade_amount = value
		ammo_change.emit()
		
var health = 60:
	get:
		return health
	set(value):
		health = value
		health_change.emit()
