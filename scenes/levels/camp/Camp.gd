extends Node2D


@onready var houses: Node = %Houses

#region built-in

func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	ObjectivesManager.restore(progression.finished_objectives)
	for idx in houses.get_child_count():
		var house = houses.get_child(idx) as House
		_init_house(idx, house, progression)
		_connect_objectives(house)

#endregion built-in


#region signal

func _on_return_to_planete_pressed() -> void:
	SceneTransition.change_scene("res://scenes/levels/debug/DebugPlanet.tscn", _save)

#endregion signal


#region private

func _connect_objectives(house: House) -> void:
	ObjectivesManager.connect_house(house)


func _get_house_level(house: Node) -> int:
	return (house as House).level


func _get_houses_levels() -> Array[int]:
	var levels: Array[int]
	levels.assign(houses.get_children().map(_get_house_level))
	return levels


func _init_house(idx: int, house: House, progression: Progression) -> void:
	var level = progression.houses_levels[idx] if idx < progression.houses_levels.size() else 0
	house.level = level


func _save() -> void:
	var progression = ProgressionService.data
	progression.houses_levels = _get_houses_levels()
	progression.items = InventoryStorage.get_items()
	progression.finished_objectives = ObjectivesManager.get_finished_objectives()
	ProgressionService.save(progression)

#endregion private
