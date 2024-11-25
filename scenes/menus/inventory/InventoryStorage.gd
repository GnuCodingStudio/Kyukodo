extends Node

var items: Array[ItemData] = []

signal inventory_changed


func _ready() -> void:
	items.resize(30)


func add_item(new_item: ItemData):
	var found = false

	for i in items.size():
		var slot = items[i]
		if slot != null && slot.ref.code == new_item.ref.code:
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
		if items[i] != null and items[i].ref == item.ref:
			items[i] = null
	inventory_changed.emit()


func count(itemRef: ItemRef) -> int:
	var mathing_items = items.filter(func (item): return item != null and item.ref == itemRef)
	if mathing_items.is_empty():
		return 0

	return mathing_items[0].quantity


func decrease(itemRef: ItemRef, quantity: int) -> void:
	for i in items.size():
		if items[i] != null and items[i].ref == itemRef:
			items[i].quantity -= quantity
			if items[i].quantity <= 0:
				items[i] = null


func restore(items: Array[ItemData]) -> void:
	for item in items:
		add_item(item)
