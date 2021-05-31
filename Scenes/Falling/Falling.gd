extends Node2D

var fadein = false
var fadeout = false
var alpha = 0

func _ready():
	$AnimatedSprite.modulate.a = 0
	pass # Replace with function body.

func _physics_process(delta):
	if fadein:
		$AnimatedSprite.modulate.a = $AnimatedSprite.modulate.a + 0.01
		if $AnimatedSprite.modulate.a >= 1:
			fadein = false	
	
	if fadeout:
		$AnimatedSprite.modulate.a = $AnimatedSprite.modulate.a - 0.01
		if $AnimatedSprite.modulate.a <= 0:
			fadeout = false
			Global.next_scene()

func _on_Fade_in_timeout():
	fadein = true
	print("fading in")

func _on_Fade_out_timeout():
	fadeout = true
	print("fading out")
