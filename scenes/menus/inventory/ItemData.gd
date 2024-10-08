class_name ItemData
extends Node


var code: String
var title: String
var quantity: int
var texture: Texture2D


func _init(code: String, title: String, quantity: int, texture: Texture2D) -> void:
	self.code = code
	self.title = title
	self.quantity = quantity
	self.texture = texture


func withAddedQuantity(quantity: int) -> ItemData:
	return ItemData.new(code, title, self.quantity + quantity, texture)
