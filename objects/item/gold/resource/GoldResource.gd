class_name GoldResource
extends ItemResource


#region logic

func collect() -> ItemData:
	var quantity_to_drop = _random_quantity_to_drop(growth.quantity)
	growth.on_collect()
	return ItemData.new(ItemRefs.REF_GOLD, quantity_to_drop)


func is_collectable() -> bool:
	return growth.quantity > 0

#endregion logic


#region private

func _on_quantity_change(quantity: int) -> void:
	%AnimatedSprite.play(str(quantity))


func _random_quantity_to_drop(quantity: int) -> int:
	match(quantity):
		1: return 1
		2: return 2
		_: return 0

#endregion private
