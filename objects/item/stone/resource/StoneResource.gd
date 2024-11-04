class_name StoneResource
extends ItemResource


@onready var growth_timer: Timer = %GrowthTimer


const MAX_QUANTITY := 2

var _quantity := 0:
	set(value):
		_quantity = value
		_on_quantity_change(value)


#region built-in

func _ready() -> void:
	super._ready()
	_quantity = MAX_QUANTITY
	growth_timer.start()

#endregion built-in


#region logic

func collect() -> ItemData:
	var quantity_to_drop = _random_quantity_to_drop(_quantity)
	_quantity = 0
	growth_timer.start()
	return ItemData.new(ItemRefs.REF_STONE, quantity_to_drop)


func is_collectable() -> bool:
	return _quantity > 0

#endregion logic


#region private

func _on_growth_timer_tick() -> void:
	_quantity += 1
	if _quantity >= MAX_QUANTITY:
		growth_timer.stop()


func _on_quantity_change(quantity: int) -> void:
	animated_sprite.play(str(quantity))


func _random_quantity_to_drop(quantity: int) -> int:
	match(quantity):
		1: return 1
		2: return 2 + randi_range(0, 2)
		_: return 0

#endregion private
