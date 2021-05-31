extends Node2D


const draw_scene = preload("res://Scenes/SlashPower/Draw/Draw.tscn")
const energy_bar = preload("res://Scenes/SlashPower/EnergyBar/EnergyBar.tscn")

export var max_energy = 1000

var current_draw_scene: Node2D = null
var current_energy_bar: Control = null
var is_slashing = false
var player

func _ready():
	player = get_tree().get_nodes_in_group("PLAYER")
	if player:
		player = player[0]
		
		
func _draw():
	if OS.is_debug_build():
		if Input.is_key_pressed(KEY_SHIFT):
			var enemies = get_tree().get_nodes_in_group("ENEMY")
			for enemy in enemies:
				var enemy_rect = self.get_enemy_rect(enemy)
				draw_rect(enemy_rect, Color.blue, false)


func _input(event):
	if event is InputEventKey and (event as InputEventKey).scancode == KEY_SHIFT and !event.is_echo() and player and !player.dead:
		if OS.is_debug_build():
			self.update()
		event = event as InputEventKey
		if event.pressed and $Charges.use_charge():
			var enemies = get_tree().get_nodes_in_group("ENEMY")
			if player: player.pause()
			for enemy in enemies:
				enemy.pause()
			var new_energy_bar = energy_bar.instance()
			self.add_child(new_energy_bar)
			print(new_energy_bar)
			self.current_energy_bar = new_energy_bar
			print(self.current_energy_bar)
			
			self.current_draw_scene = draw_scene.instance()
			get_tree().get_root().add_child(self.current_draw_scene)
			self.is_slashing = true
			$Charges.toggle_charging()
		else:
			var enemies = get_tree().get_nodes_in_group("ENEMY")
			player.resume()
			for enemy in enemies:
				enemy.resume()
			if self.current_draw_scene:
				$Charges.toggle_charging()
				
				var path = self.current_draw_scene.path
				self.current_draw_scene.queue_free()
				self.current_energy_bar.queue_free()
				self.current_draw_scene = null
				self.current_energy_bar = null
				self.is_slashing = false
				for enemy in enemies:
					var enemy_rect = self.get_enemy_rect(enemy)
					for point in path:
						if enemy_rect.has_point(point):
							print("should die")
							enemy._die(1)
							enemy.resume()
							break
		


func get_enemy_rect(enemy):
	var enemy_extents = enemy.get_node("Hitbox/Hitbox Shape").get_shape().extents
	var start_position = enemy.position - (enemy_extents * enemy.scale)
	var size = enemy_extents * 2 * enemy.scale
	var enemy_rect = Rect2(start_position, size)
	return enemy_rect
