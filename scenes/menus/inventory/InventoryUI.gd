class_name InventoryUI
extends Control


@onready var items_grid: GridContainer = %ItemsGrid

const ITEM_UI = preload("res://scenes/menus/inventory/ItemUI.tscn")


## BUILT-IN ##

func _ready() -> void:
	InventoryStorage.inventory_changed.connect(_inventory_changed)
	_inventory_changed()


func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_released("inventory_open_close"):
		visible = !visible
		get_tree().paused = visible


## SIGNAL ##

func _inventory_changed() -> void:
	for child in items_grid.get_children():
		items_grid.remove_child(child)

	for item in InventoryStorage.items:
		var itemUI = ITEM_UI.instantiate()
		items_grid.add_child(itemUI)
		itemUI.set_item(item)
		itemUI.item_drop.connect(_on_item_drop)


func _on_item_drop(item: ItemData) -> void:
	InventoryStorage.drop_item(item)
