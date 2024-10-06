class_name ItemData
extends Node


var code: String
var title: String
var quantity: int


func _init(code: String, title: String, quantity: int) -> void:
	self.code = code
	self.title = title
	self.quantity = quantity
