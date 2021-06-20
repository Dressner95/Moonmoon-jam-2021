extends KinematicBody2D

onready var window_width = get_viewport().size.x
onready var window_height = get_viewport().size.y

var speed
var player
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var init_player_position
var init_position
var paused = false;
var dead = false;

func _ready():
	player = get_tree().get_nodes_in_group("PLAYER")
	player = player[0]
	init_player_position = player.position	
	pass

func pause():
	$AnimatedSprite.playing = false
	paused = true
	
func resume():
	if !dead:
		$AnimatedSprite.playing = true
	paused = false

func _die(damage):
	queue_free()
	pass

func _physics_process(delta):
	direction = init_player_position - init_position
	
	rotation = direction.angle()
	
	direction = direction.normalized() * speed
	
	if!paused:
		direction = move_and_slide(direction)
	
	if position.x > window_width or position.x < 0 or position.y > window_height or position.y < 0:
		queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
