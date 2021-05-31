extends Control


export var max_size = 500
export var buffer = 25


func _ready():
	$ColorRect.rect_size.x = self.max_size - buffer
	self.add_to_group("ENERGY_BAR")


func resize(length, max_length):
	var new_size = self.max_size * length / max_length
	$ColorRect.rect_size.x = self.max_size - new_size - buffer
