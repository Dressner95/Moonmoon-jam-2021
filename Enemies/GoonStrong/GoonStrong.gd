extends Enemy

export var recommended_speed = 235
export var recommended_range = 75
export var recommended_health = 1
var custom_slowdown

func _init():
	self.attacks = ["attack1", "attack2", "attack4"]
	movement_speed = recommended_speed
	attack_range = recommended_range
	health = 3
	pass
