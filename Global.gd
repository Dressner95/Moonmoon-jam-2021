extends Node

const FALLING_SCENE = preload("res://Scenes/Falling/Falling.tscn")
const FOREST_SCENE = preload("res://Scenes/Levels/Forest/Forest.tscn")
const LEVEL_1 = preload("res://Scenes/Levels/Level1/Level1.tscn")
const LEVEL_2 = preload("res://Scenes/Levels/Level2/Level2.tscn")
const LEVEL_3 = preload("res://Scenes/Levels/Level3/Level3.tscn")
const LEVEL_4 = preload("res://Scenes/Levels/Level4/Level4.tscn")
const LEVEL_5 = preload("res://Scenes/Levels/Level5/Level5.tscn")
const LEVEL_6 = preload("res://Scenes/Levels/Level6/Level6.tscn")
const LEVEL_8 = preload("res://Scenes/Levels/Level8/Level8.tscn")
const LEVEL_9 = preload("res://Scenes/Levels/Level9/Level9.tscn")
const WINNER = preload("res://Scenes/Win.tscn")

const scenes_order = [FOREST_SCENE, 
FALLING_SCENE,
LEVEL_1, 
FALLING_SCENE,
LEVEL_2,
FALLING_SCENE,
LEVEL_3,
FALLING_SCENE ,
LEVEL_4,
FALLING_SCENE,
LEVEL_5,
FALLING_SCENE,
LEVEL_6,
LEVEL_6,
FALLING_SCENE,
LEVEL_8,
FALLING_SCENE,
LEVEL_9,
WINNER
]

var scenes = scenes_order.duplicate(true)

var num_enemies_left: int


func next_scene():
	
	var new_scene = self.scenes.pop_front()
	print(new_scene)
	if new_scene != null:
		get_tree().change_scene_to(new_scene)
		
func reset():
	scenes = scenes_order.duplicate(true)
	self.next_scene()
