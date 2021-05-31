extends Node2D


export var speed = -10
export var sprite_x: int
export var num_sprites = 4

var counter = 0
var looping_sprites = [$Node, $Node2]
onready var initial_position = self.position.x

# Called when the node enters the scene tree for the first time.
func _ready():
	self.sprite_x = $Node/Sprite.texture.get_height() * $Node/Sprite.scale.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_amount = 1 * speed * delta
	self.position.x += move_amount
	self.counter += move_amount
	
	if abs(counter) >= sprite_x * num_sprites:
		self.position.x = initial_position
		self.counter = 0
