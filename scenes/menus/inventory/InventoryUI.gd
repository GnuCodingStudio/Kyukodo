class_name InventoryUI
extends Control


## BUILT-IN ##

func _ready() -> void:
	InventoryStorage.inventory_changed.connect(_inventory_changed)


func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_released("inventory_open_close"):
		visible = !visible


## SIGNAL ##

func _inventory_changed() -> void:
	pass
