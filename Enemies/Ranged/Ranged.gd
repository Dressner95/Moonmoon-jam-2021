extends KinematicBody2D

onready var state_machine = $AnimationTree.get("parameters/playback")
onready var window_width = get_viewport().size.x
onready var window_height = get_viewport().size.y

export var movement_speed = 500
export var projection_speed = 600
var current

var dead = false
var position_to_fly = Vector2.ZERO
var velocity
var health = 1
var player
var paused

func _ready():
	$AnimationTree.active = true
	player = get_tree().get_nodes_in_group("PLAYER")
	player = player[0]
	pass # Replace with function body.

func _physics_process(delta):
	current = state_machine.get_current_node()
	
	if current == "run-loop":
		velocity = (position_to_fly - position).normalized() * movement_speed
		if velocity.x > 0:
			$Holder.scale.x = -1
		if velocity.x < 0:
			$Holder.scale.x = 1
		if !paused:
			velocity = move_and_slide(velocity)
		if position_to_fly.distance_to(position) < 10:
			state_machine.travel("run-stop")
			if player.position.x > position.x:
				$Holder.scale.x = -1
			else:
				$Holder.scale.x = 1

func pause():
	$AnimationTree.active = false
	paused = true
	
func resume():
	$AnimationTree.active = true
	paused = false

func shot_fired():
	var node = preload("res://Enemies/Bullet/Bullet.tscn").instance()
	
	node.speed = 650
	node.position = position
	node.init_position = position
	
	get_tree().get_root().add_child(node)
	
	state_machine.travel("run-start")
	
	position_to_fly.x = int(rand_range(480, 1450))
	position_to_fly.y = int(rand_range(150, 970))
	
	print("fired")
	

func _die(damage):
	health = health - damage
	if health <= 0:
		$AnimationTree.get("parameters/playback").travel("die")
		$"Enviro Collider".disabled = true
		$"Hitbox/Hitbox Shape".disabled = true
		dead = true
	pass


func _on_Hitbox_area_shape_entered(area_id, area, area_shape, local_shape):
	#if entered shape is from the power
	if area.is_in_group("character_weapon"):
		_die(1);



func _on_Damage_Timer_timeout():
	pass # Replace with function body.
