extends Control


export var recharge_time = 1

onready var charges = [$Charge]


func use_charge() -> bool:
	var charge_used = false
	for charge in self.charges:
		if charge.active:
			charge.use()
			charge_used = true
			break
	
	self.charges.sort()
	return charge_used


func get_charge() -> bool:
	var prev_charge = null
	for charge in self.charges:
		if charge.active and prev_charge:
			prev_charge.active = true
			return true
		
		prev_charge = charge
	
	if not prev_charge.active:
		prev_charge.active = true
		return true

	return false


func toggle_charging():
	for charge in charges:
		charge.toggle_pause()


func sort_charges():
	var charge_amounts = []
	for charge in self.charges:
		charge_amounts.append(charge.charge)
	charge_amounts.sort()
	
	for i in range(len(self.charges)):
		self.charges[i].charge = charge_amounts[i]


static func sort_decending(a, b):
	if a > b:
		return true
	return false
