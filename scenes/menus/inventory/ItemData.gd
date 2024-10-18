class_name ItemData
extends Node


var ref: ItemRef
var quantity: int


func _init(ref: ItemRef, quantity: int) -> void:
	self.ref = ref
	self.quantity = quantity


func withAddedQuantity(quantity: int) -> ItemData:
	return ItemData.new(self.ref, self.quantity + quantity)
