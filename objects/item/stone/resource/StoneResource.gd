class_name StoneResource
extends ItemResource


#region logic

func _collect() -> ItemData:
	var quantity_to_drop = _random_quantity_to_drop(growth.quantity)
	growth.on_collect()
	return ItemData.new(ItemRefs.REF_STONE, quantity_to_drop)

#endregion logic


#region private

func _on_quantity_change(quantity: int) -> void:
	super._on_quantity_change(quantity)
	%AnimatedSprite.play(str(quantity))


func _random_quantity_to_drop(quantity: int) -> int:
	match(quantity):
		1: return 1
		2: return 2 + randi_range(0, 2)
		_: return 0

#endregion private
