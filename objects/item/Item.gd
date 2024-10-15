class_name Item
extends Node2D


var ref: ItemRef
@export var quantity: int = 1


signal on_player_entered(item: Item, itemData: ItemData)


func _ready() -> void:
	ref = _ref()
	assert(quantity > 0, "Item quantity cannot be negative or null")
	assert(ref != null, "Item must have an item ref")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		on_player_entered.emit(self, ItemData.new(ref, quantity))


func _ref() -> ItemRef: 	return null
