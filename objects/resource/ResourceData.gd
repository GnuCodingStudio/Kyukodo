class_name ResourceData
extends Node


var quantity: int
var time_left: int


func _init(quantity: int, time_left: int) -> void:
	self.quantity = quantity
	self.time_left = time_left
