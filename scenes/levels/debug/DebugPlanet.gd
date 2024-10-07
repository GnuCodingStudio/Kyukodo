extends Node2D


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_KP_ADD and event.is_released():
		prints("adding item")
		InventoryStorage.add_item(ItemData.new("PUMPKIN", "Pumpkin", 1))
