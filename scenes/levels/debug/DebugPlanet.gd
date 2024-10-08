extends Node2D


var pumpkin = ItemData.new(
	"PUMPKIN",
	"Pumpkin",
	1,
	preload("res://objects/pumpkin/pumpkin.png")
)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event.keycode == KEY_KP_ADD or event.keycode == KEY_EQUAL) and event.is_released():
		prints("adding item")
		InventoryStorage.add_item(pumpkin)
