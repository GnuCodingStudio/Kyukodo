class_name Item
extends Node2D


var ref: ItemRef
@export var quantity: int = 1


#region built-in

func _ready() -> void:
	ref = _ref()
	assert(quantity > 0, "Item quantity cannot be negative or null")
	assert(ref != null, "Item must have an item ref")

#endregion built-in


#region abstract

func _ref() -> ItemRef: return null

#endregion abstract
