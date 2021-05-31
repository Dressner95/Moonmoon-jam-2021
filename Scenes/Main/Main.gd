extends Node2D


const TITLE_SCENE = preload("res://Scenes/Title Screen/TitleScene.tscn")
const FOREST_SCENE = preload("res://Scenes/Levels/Forest/Forest.tscn")
const PIT_SCENE = preload("res://Scenes/Levels/Pit/Pit.tscn")

var scenes = [TITLE_SCENE, FOREST_SCENE, PIT_SCENE]

var current_scene: Node


func _ready():
	self.current_scene = scenes.pop_front().instance()
	self.add_child(self.current_scene)


func _input(event):
	if event is InputEventKey:
		if (event as InputEventKey).scancode == KEY_SPACE and not event.pressed:
			var next_scene = self.scenes.pop_front()
			if next_scene != null:
				self.current_scene.queue_free()
				self.current_scene = next_scene.instance()
				get_tree().get_root().add_child(self.current_scene)
