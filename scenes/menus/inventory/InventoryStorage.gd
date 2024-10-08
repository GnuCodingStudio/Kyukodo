extends Node

var items: Array[ItemData] = []

signal inventory_changed


func _ready() -> void:
	items.resize(30)


func add_item(new_item: ItemData):
	var found = false

	for i in items.size():
		var slot = items[i]
		if slot != null && slot.code == new_item.code:
			found = true
			var updated_item = slot.withAddedQuantity(new_item.quantity)
			items[i] = updated_item
			break

	if not found:
		for i in items.size():
			if items[i] == null:
				found = true
				items[i] = new_item
				break

	if not found:
		items.append(new_item)

	inventory_changed.emit()


func drop_item(item: ItemData) -> void:
	for i in items.size():
		if items[i] != null and items[i].code == item.code:
			items[i] = null
	inventory_changed.emit()
