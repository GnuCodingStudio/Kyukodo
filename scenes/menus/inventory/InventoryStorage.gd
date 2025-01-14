extends Node


var _items: Array[ItemData] = []


signal inventory_changed
signal item_collected(item: ItemData)


func _ready() -> void:
	_reset()


func add_item(new_item: ItemData):
	_add_item(new_item, true)


func _add_item(new_item: ItemData, notify: bool):
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

	if notify:
		item_collected.emit(new_item)
		inventory_changed.emit()


func drop_item(item: ItemData) -> void:
	for i in _items.size():
		if _items[i] != null and _items[i].ref == item.ref:
			_items[i] = null
	inventory_changed.emit()


func get_items() -> Array[ItemData]:
	return _items.filter(_filter_not_null)


func count_by_ref(itemRef: ItemRef) -> int:
	return _count(func (item): return item != null and item.ref == itemRef)


func count_by_code(code: String) -> int:
	return _count(func (item): return item != null and item.ref.code == code)


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
		_add_item(item, false)
	inventory_changed.emit()


#region private

func _count(callable: Callable) -> int:
	var mathing_items = _items.filter(callable)
	if mathing_items.is_empty():
		return 0

	return mathing_items[0].quantity


func _filter_not_null(item: ItemData) -> bool:
	return item != null


func _reset() -> void:
	_items = []
	_items.resize(30)

#endregion private
