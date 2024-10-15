extends Node2D


func _ready() -> void:
	for child in %Items.get_children():
		child.on_player_entered.connect(_on_player_collides_with_item)


# DEBUG
func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event.keycode == KEY_KP_ADD or event.keycode == KEY_EQUAL) and event.is_released():
		prints("adding item")
		InventoryStorage.add_item(ItemData.new(Items.REF_PUMPKIN, 3))


#region Signals
func _on_player_collides_with_item(item: Item, itemData: ItemData) -> void:
	InventoryStorage.add_item(itemData)
	item.queue_free()
#endregion Signals
