class_name StoneResource
extends ItemResource

@onready var growth: Growth = %Growth


#region logic

func collect() -> ItemData:
	var quantity_to_drop = _random_quantity_to_drop(growth.quantity)
	growth.on_collect()
	return ItemData.new(ItemRefs.REF_STONE, quantity_to_drop)


func is_collectable() -> bool:
	return growth.quantity > 0

#endregion logic


#region private

func _on_quantity_change(quantity: int) -> void:
	%AnimatedSprite.play(str(quantity))


func _random_quantity_to_drop(quantity: int) -> int:
	match(quantity):
		1: return 1
		2: return 2 + randi_range(0, 2)
		_: return 0

#endregion private