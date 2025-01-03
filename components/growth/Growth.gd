class_name Growth
extends Node


## Seconds between growth tick
@export var tick_time: int = 3600
@export var initial_quantity: int = 0
@export var max_quantity: int = 1

@onready var timer: Timer = %Timer


signal _on_quantity_change(quantity: int)


var quantity := 0:
	set(value):
		quantity = value
		_on_quantity_change.emit(value)


#region built-in

func _ready() -> void:
	assert(get_parent() is ItemResource, "Growth must be child of ItemResource")
	quantity = initial_quantity
	if tick_time > 0:
		timer.start(tick_time)

#endregion built-in


#region logic

func on_collect() -> void:
	quantity = 0
	timer.start(tick_time)


func restore(quantity: int, time_left: int) -> void:
	self.quantity = quantity
	self.timer.stop()
	self.timer.start(time_left)


#endregion login


#region signal

func _on_timeout() -> void:
	quantity += 1
	timer.stop()
	if quantity < max_quantity:
		timer.start(tick_time)

#endregion signal
