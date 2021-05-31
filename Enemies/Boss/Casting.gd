extends Node2D

var cast_instances = 35

var cast = preload("res://Enemies/Boss/Cast.tscn")

func _ready():
	for i in range(cast_instances):
		var location = Vector2(int(rand_range(480, 1450)), int(rand_range(150, 970)))
		var node = cast.instance()
		node.position = location
		get_tree().get_root().add_child(node)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Suicide_timeout():
	self.queue_free()
	pass # Replace with function body.
