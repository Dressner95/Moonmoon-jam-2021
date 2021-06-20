extends KinematicBody2D

class_name Enemy

onready var state_machine = $AnimationTree.get("parameters/playback")
var current;

var attacks = []

var player
var player_position = Vector2.ZERO
var velocity
var attacking = false
var dead = false
var distance_to_player= 100000
var health = 1;
var paused = false

var movement_speed = 200
var attack_range = 50

func _ready():
	$AnimationTree.active = true
	$"Holder/Weapon Hitbox/Weapon Shape".disabled = true
	player = get_tree().get_nodes_in_group("PLAYER")
	player = player[0]
	
	pass # Replace with function body.

func _physics_process(delta):
	current = state_machine.get_current_node()
	print(current)
	player_position = player.position
	velocity = Vector2.ZERO
	
	if dead:
		$AnimationTree.get("parameters/playback").travel("die")
		pass
	else:
		if current == "idle":
			current = "run"
			state_machine.travel("run")
		if current == "run":
			velocity = player_position - position
			distance_to_player = position.distance_to(player_position)
			print(!attacking)
		
		if distance_to_player < attack_range and !attacking and !dead:
			if player.position.x > position.x:
				$Holder.scale.x = 1
			else:
				$Holder.scale.x = -1
			state_machine.travel(attacks[randi() % len(attacks)])

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
		
		if !paused:
			velocity = move_and_slide(velocity)

func pause():
	$AnimationTree.active = false
	paused = true
	
func resume():
	if !dead:
		$AnimationTree.active = true
		attacking = false
		$"Holder/Weapon Hitbox/Weapon Shape".disabled = true
	paused = false

func _die(damage):
	health = health - damage
	$".".modulate = Color.red
	$"Damage Timer".start()
	if health <= 0 and !dead:
		$AnimationTree.get("parameters/playback").stop()
		#$AnimationTree.get("parameters/playback").travel("die")
		#$"Enviro Collider".disabled = true
		$"Enviro Collider".queue_free()
		$"Hitbox/Hitbox Shape".disabled = true
		$"Holder/Weapon Hitbox/Weapon Shape".disabled = true
		attacking = false
		dead = true
		Global.num_enemies_left -= 1

func reset_attack():
	attacking = false
	
func _on_Hitbox_area_shape_entered(area_id, area, area_shape, local_shape):
	#if entered shape is from the power
	if area.is_in_group("character_weapon"):
		_die(1);
		
func _on_Damage_Timer_timeout():
	$".".modulate = Color.white
	pass # Replace with function body.


