extends Enemy

var recommended_speed = 300
var recommended_range = 100
var custom_slowdown

var casting_scene = preload("res://Enemies/Boss/Casting.tscn")

func _init():
	self.attacks = ["attack"]
	self.health = 10
	
	movement_speed = recommended_speed
	attack_range = recommended_range
	
	pass

func _physics_process(delta):
	if health < 4:
		self.attacks = ["attack", "cast"]
		attack_range = 150
		

func cast():
	var node = casting_scene.instance()
	get_tree().get_root().add_child(node)



