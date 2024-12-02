extends Node


var _items: Array[ItemData] = []


signal inventory_changed


func _ready() -> void:
	_reset()


func add_item(new_item: ItemData):
	var found = false

	for i in _items.size():
		var slot = _items[i]
		if slot != null && slot.ref.code == new_item.ref.code:
			found = true
			var updated_item = slot.withAddedQuantity(new_item.quantity)
			_items[i] = updated_item
			break

	if not found:
		for i in _items.size():
			if _items[i] == null:
				found = true
				_items[i] = new_item
				break

	if not found:
		_items.append(new_item)

	inventory_changed.emit()


func drop_item(item: ItemData) -> void:
	for i in _items.size():
		if _items[i] != null and _items[i].ref == item.ref:
			_items[i] = null
	inventory_changed.emit()


func get_items() -> Array[ItemData]:
	return _items.filter(_filter_not_null)


func count(itemRef: ItemRef) -> int:
	var mathing_items = _items.filter(func (item): return item != null and item.ref == itemRef)
	if mathing_items.is_empty():
		return 0

	return mathing_items[0].quantity


func decrease(itemRef: ItemRef, quantity: int) -> void:
	for i in _items.size():
		if _items[i] != null and _items[i].ref == itemRef:
			_items[i].quantity -= quantity
			if _items[i].quantity <= 0:
				_items[i] = null
	inventory_changed.emit()


func restore(items: Array[ItemData]) -> void:
	_reset()
	for item in items:
		add_item(item)
	inventory_changed.emit()


func _reset() -> void:
	_items = []
	_items.resize(30)


func _filter_not_null(item: ItemData) -> bool:
	return item != null
