extends Enemy

export var recommended_speed = 150
export var recommended_range = 150
var custom_slowdown

func _init():
	self.attacks = ["attack1", "attack2"]
	movement_speed = recommended_speed
	attack_range = recommended_range
	health = 5
	pass
