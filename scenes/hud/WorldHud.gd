class_name WorldHud
extends CanvasLayer

@onready var inventory: InventoryUI = %Inventory
@onready var pause_menu: PauseMenu = %PauseMenu


func _on_inventory_visibility_changed() -> void:
	pause_menu.enabled = !inventory.visible


func _on_pause_menu_visibility_changed() -> void:
	inventory.enabled = !pause_menu.visible
