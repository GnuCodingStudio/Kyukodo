extends Node2D


# DEBUG
func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event.keycode == KEY_KP_ADD or event.keycode == KEY_EQUAL) and event.is_released():
		prints("adding item")
		InventoryStorage.add_item(ItemData.new(Items.REF_PUMPKIN, 3))
