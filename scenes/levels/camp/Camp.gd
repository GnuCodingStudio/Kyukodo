extends Node2D


@onready var houses: Node = %Houses


func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	for idx in houses.get_child_count():
		var level = progression.houses_levels[idx] if idx < progression.houses_levels.size() else 0
		(houses.get_child(idx) as House).level = level


func _on_return_to_planete_pressed() -> void:
	SceneTransition.change_scene("res://scenes/levels/debug/DebugPlanet.tscn", _save)


func _save() -> void:
	var progression = ProgressionService.data
	progression.houses_levels = _get_houses_levels()
	progression.items = InventoryStorage.get_items()
	ProgressionService.save(progression)


func _get_houses_levels() -> Array[int]:
	var levels: Array[int]
	levels.assign(houses.get_children().map(_get_house_level))
	return levels


func _get_house_level(house: Node) -> int:
	return (house as House).level
