extends KinematicBody2D

onready var state_machine = $AnimationTree.get("parameters/playback")
onready var weapon_hitbox = $"Holder/Weapon Hitbox"
export (int) var movement_speed = 200
export (int) var animation_speed = 200
export (float) var attacking_slowdown = 0.2
export (float) var rolling_speedup = 1.5

var gameover_scene = preload("res://Scenes/GameOver.tscn")

onready var window_width = get_viewport().size.x
onready var window_height = get_viewport().size.y

onready var _animation_tree = $AnimationTree

var attacks = ["attack1", "attack2"]

var dead = false;

#Must be set so I can can still dick around in debug but it works normally
func _ready():
	_animation_tree.active = true
	$"Holder/Weapon Hitbox/Weapon Shape".disabled = true
	$"Hitbox/Hitbox Shape".disabled = false

var x_sprite_pixel_buffer = 15;
var y_upper_sprite_pixel_buffer = 100;
var y_lower_sprite_pixel_buffer = 30;

var current;
var attacking = false;
var rolling = false;
var rolling_vector = Vector2()
var velocity = Vector2()
var paused = false

var direction = "right"

func get_input():
	
	
	current = state_machine.get_current_node()
	
	velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("left_click") and !dead  and !paused:
		if !attacking and !rolling:
			state_machine.travel(attacks[randi() % 2])
			attacking = true
		return

	if Input.is_action_pressed("right") and !dead and !paused:
		velocity.x += 1
		if !attacking and !rolling:
			#$Sprite.flip_h = false
			$Holder.scale.x = 1;
			if direction == "left":
				direction = "right"
	elif Input.is_action_pressed("left") and !dead and !paused:
		velocity.x -= 1
		if !attacking and !rolling:
			#$Sprite.flip_h = true
			$Holder.scale.x = -1;
			if direction == "right":
				direction = "left"
	if Input.is_action_pressed("down") and !dead and !paused:
		velocity.y += 1
	elif Input.is_action_pressed("up") and !dead and !paused:
		velocity.y -= 1
		
	if rolling:
		velocity = rolling_vector
	else:
		velocity = velocity.normalized() * movement_speed
	
	if Input.is_action_just_pressed("ui_accept") and !dead and !paused:
		if !rolling:
			rolling = true
			print("rolling")
			state_machine.travel("dash2")
			rolling_vector = velocity
			return
	
	if velocity.length() != 0 and !attacking and !dead and !paused and !rolling: 
		state_machine.travel("run")
	if velocity.length() == 0 and !attacking and !dead and !paused and !rolling:
		state_machine.travel("idle")
		#To set Time Scaleing
		#$AnimationTree.set("parameters/idle/TimeScale/scale", 2.0)
		

func reset_attack():
	attacking = false

func reset_roll():
	rolling = false;
	$"Enviro Collider".disabled = false
	
func pause():
	state_machine.travel("flash")
	paused = true
	
func resume():
	paused = false
	
func correct_position():
#	if $Sprite.flip_h == false:
#		if $Weapon.position.x < 0:
#			$Weapon.position.x *= -1
#
#	if $Sprite.flip_h == true:
#		if $Weapon.position.x > 0:
#			$Weapon.position.x *= -1
#
	pass

func _physics_process(_delta):
	get_input()
	
	#print(direction)
	
	current = state_machine.get_current_node()
	
	if attacking and !dead and !paused:
		velocity = move_and_slide(velocity * attacking_slowdown)
	elif rolling and !dead and !paused:
		velocity = move_and_slide(velocity * rolling_speedup)
	elif !dead and !paused:
		velocity = move_and_slide(velocity)
	
	
	$".".position.x = clamp($".".position.x, 400 + x_sprite_pixel_buffer , 1525 - x_sprite_pixel_buffer);
	$".".position.y = clamp($".".position.y, 0 + y_upper_sprite_pixel_buffer , 1030 - y_lower_sprite_pixel_buffer);
	
func die():
	dead = true
	get_tree().change_scene_to(gameover_scene)
	#state_machine.travel("death-holder")
	pass

func _on_Hitbox_area_shape_entered(area_id, area, area_shape, local_shape):
	if area.is_in_group("enemy_weapon"):
		die()
	
	pass # Replace with function body.
