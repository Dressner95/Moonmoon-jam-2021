extends Enemy

export var recommended_speed = 350
export var recommended_range = 45
var custom_slowdown

func _init():
	self.attacks = ["attack2", "attack3"]
	movement_speed = recommended_speed
	attack_range = recommended_range
	pass
