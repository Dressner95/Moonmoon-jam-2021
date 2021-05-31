extends Node2D


export var fade_away = false;
export var fade_speed = 5;


func _ready():
	var enemies = get_tree().get_nodes_in_group("ENEMY")
	if len(enemies) > 0:
		Global.num_enemies_left = len(enemies)


func _process(delta):
	if Global.num_enemies_left == 0:
		self.level_finished()
		
	if self.fade_away and self.modulate.a != 0:
		self.modulate.a = clamp(self.modulate.a - 0.1 * fade_speed * delta, 0, 1)
		if self.modulate.a == 0:
			$NextLevelArea/CollisionShape2D.disabled = false
	elif not self.fade_away and self.modulate.a == 0.0:
		self.modulate.a = 1.0
		$NextLevelArea/CollisionShape2D.disabled = true


func level_finished():
	self.fade_away = true


func _on_NextLevelArea_area_entered(area):
	if area.get_owner().is_in_group("PLAYER"):
		Global.next_scene()
