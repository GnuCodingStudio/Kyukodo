extends Node2D


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_KP_ADD and event.is_released() :
		InventoryStorage.add_item(ItemData.new("APPLE", "Apple", 1))
