extends Node2D


func _input(event):
	if not event.is_echo() and event is InputEventKey:
		Global.next_scene()
