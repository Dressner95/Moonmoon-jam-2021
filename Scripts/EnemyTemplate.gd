extends KinematicBody2D



onready var state_machine = $AnimationTree.get("parameters/playback")
var current;

var attacks = ["attack1", "attack2", "attack4"]

var player
var player_position = Vector2.ZERO
var velocity
var attacking = false
var dead = false
var distance_to_player= 100000

export (int) var movement_speed = 200
export (int) var attack_range = 50

func _ready():
	player = get_tree().get_nodes_in_group("PLAYER")
	player = player[0]
	pass # Replace with function body.

func _physics_process(delta):
	current = state_machine.get_current_node()	
	player_position = player.position
	velocity = Vector2.ZERO
	
	if dead:
		pass
	else:
		if current == "idle" or current == "run":
			velocity = player_position - position
			distance_to_player = position.distance_to(player_position)
			
		
		if distance_to_player < attack_range and !attacking:
			state_machine.travel(attacks[randi() % 3])
			attacking = true
		
		if velocity.length() != 0 and !attacking:
			state_machine.travel("run")
		if velocity.length() == 0 and !attacking:
			state_machine.travel("idle")
		
		velocity = velocity.normalized() * movement_speed
		
		if velocity.x > 0 and !attacking:
			#moving right
			$Holder.scale.x = 1
		elif !attacking:
			#moving left
			$Holder.scale.x = -1
		
		velocity = move_and_slide(velocity)

func _die():
	$AnimationTree.get("parameters/playback").travel("die")
	$"Enviro Collider".disabled = true
	$"Hitbox/Hitbox Shape".disabled = true
	$"Holder/Weapon Hitbox/Weapon Shape".disabled = true
	dead = true

func reset_attack():
	attacking = false
	
func _on_Hitbox_area_shape_entered(area_id, area, area_shape, local_shape):
	#if entered shape is from the power
	if area.is_in_group("character_weapon"):
		_die();

