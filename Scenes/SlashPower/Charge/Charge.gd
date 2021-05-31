extends ColorRect


const FULL_COLOR = Color.white
const CHARGING_COLOR = Color.gray
const MAX_CHARGE = 100

var active = false
var paused = false
var charge = 100

var recharge_rate = 30


func _ready():
	self.add_to_group("charge")


func _process(delta):
	if self.charge != self.MAX_CHARGE:
		self.color = self.CHARGING_COLOR
		self.active = false
	else: 
		self.color = self.FULL_COLOR
		self.active = true
	
	if self.paused: return
	
	self.charge = clamp(self.charge + self.recharge_rate * delta * 0.5, 0, self.MAX_CHARGE)
	self.rect_scale.x = self.charge / self.MAX_CHARGE


func use():
	self.charge = 0


func toggle_pause():
	self.paused = not self.paused
