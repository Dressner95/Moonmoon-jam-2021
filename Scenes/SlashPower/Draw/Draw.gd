extends Node2D


const MAX_POINT_DISTANCE = 10

export var thickness = 2
export var line_color: Color = Color.white

var path = []
var max_length = 1000
var current_length = 0
var ended = false

var energy_bar


func _physics_process(_delta):
	if self.ended: return
	var energy_bar_list = get_tree().get_nodes_in_group("ENERGY_BAR")
	var energy_bar
	
	if len(energy_bar_list) > 0:
		energy_bar = energy_bar_list[0]
	
	if not energy_bar:
		return
	
	if Input.is_mouse_button_pressed(1):
#		var mouse_pos = get_viewport().get_mouse_position()
		var mouse_pos = get_global_mouse_position()
		
		if len(path) > 0 and mouse_pos == path[len(path) - 1]:
			return
		else:
			if self.add_length(mouse_pos):
				energy_bar.resize(self.current_length, self.max_length)
				self.update()
			else:
				ended = true


func _draw():
	var prev_mouse_pos = null
	for pos in self.path:
		if prev_mouse_pos != null:
			self.draw_line(prev_mouse_pos, pos, self.line_color, self.thickness, true)
		
		prev_mouse_pos = pos


func add_length(mouse_pos) -> bool:
	if len(self.path) < 1:
		path.append(mouse_pos)
		return true
	
	var prev_pos = self.path[len(self.path) - 1]
	var new_length = get_distance(mouse_pos, prev_pos)
	
	if self.current_length + new_length <= self.max_length:
		self.current_length += new_length
		self.path.append_array(divide_line(prev_pos, mouse_pos))
		return true
	else:
		return false


func remove():
	queue_free()


static func get_distance(point_a, point_b):
	var distance = sqrt(pow((point_a.x - point_b.x), 2) + pow((point_a.y - point_b.y), 2))
	return distance


static func divide_line(prev_pos, mouse_pos):
	if get_distance(prev_pos, mouse_pos) < MAX_POINT_DISTANCE:
		return [mouse_pos]
	
	var point_a = null
	var point_b = null
	
	if prev_pos.x < mouse_pos.x:
		point_a = prev_pos
		point_b = mouse_pos
	else:
		point_a = mouse_pos
		point_b = prev_pos
	
	var extra_points = []
	
	for x in range(point_a.x, point_b.x, MAX_POINT_DISTANCE):
		var new_point = get_new_point(point_a, point_b, x)
		extra_points.append(new_point)
	
	extra_points.append(mouse_pos)
	return extra_points
	

static func new_x(point_a, point_b, x):
	if point_a.x > point_b.x:
		return x + MAX_POINT_DISTANCE
	return x - MAX_POINT_DISTANCE


static func get_new_point(point_a, point_b, new_x):
	var new_y = (((point_b.y - point_a.y) / (point_b.x - point_a.x)) * (new_x - point_b.x)) + point_b.y
	return Vector2(new_x, new_y)
