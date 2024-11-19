class_name House
extends Node2D


var level: int = 1:
	set(value):
		level = value
		_on_level_changed(value)


#region logic

func _required_stone() -> int:
	match level:
		0: return 10
		1: return 30
		_: return 100


func _required_gold() -> int:
	match level:
		0: return 0
		1: return 25
		_: return 60


func _on_level_changed(level: int) -> void:
	%Level1.visible = level == 1
	%Level2.visible = level == 2
	%Level3.visible = level == 3

#endregion logic


#region signal

func on_house_click() -> void:
	var possessed_stone = InventoryStorage.count(ItemRefs.REF_STONE)
	var possessed_gold = InventoryStorage.count(ItemRefs.REF_GOLD)
	var can_upgrade = possessed_stone >= _required_stone() and possessed_gold >= _required_gold()

	%StoneQuantity.text = str(possessed_stone) + "/" + str(_required_stone())
	%GoldQuantity.text = str(possessed_gold) + "/" + str(_required_gold())
	%UpgradeButton.disabled = !can_upgrade
	%UpgradeButton.focus_mode = 1 if can_upgrade else 0
	%UpgradeContainer.visible = true


func _on_upgrade_pressed() -> void:
	InventoryStorage.decrease(ItemRefs.REF_STONE, _required_stone())
	InventoryStorage.decrease(ItemRefs.REF_GOLD, _required_gold())
	level = min(3, level + 1)
	%UpgradeContainer.visible = false


func _on_upgrade_container_mouse_exited() -> void:
	if not Rect2(%UpgradeContainer.get_global_rect()).has_point(get_global_mouse_position()):
		%UpgradeContainer.visible = false

#endregion signal
