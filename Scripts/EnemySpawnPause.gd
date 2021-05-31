extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = get_tree().get_nodes_in_group("ENEMY")
	for enemy in enemies:
		enemy.pause()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	for enemy in enemies:
		enemy.resume()
	pass # Replace with function body.
