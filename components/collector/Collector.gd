class_name Collector
extends Node2D

var _area: Area2D
var _targeted_resource: ItemResource


#region built-in

func _ready() -> void:
	assert(get_parent() is Area2D, "Parent of Collector must be an Area2D")

	_area = get_parent() as Area2D


func _process(delta: float) -> void:
	_target_nearest_resource()
	_detect_resource_collection()

#endregion built-in

#region logic

func _is_collectable_resource(body: Node2D) -> bool:
	if body is ItemResource:
		return body.is_collectable()
	return false


func _sort_by_distance(a: Node2D, b: Node2D) -> bool:
	var distance_to_a = a.global_position.distance_to(self.global_position)
	var distance_to_b = b.global_position.distance_to(self.global_position)
	return (distance_to_a < distance_to_b)

#endregion logic

#region private

func _target_nearest_resource() -> void:
	var resources = _area.get_overlapping_bodies().filter(_is_collectable_resource)
	resources.sort_custom(_sort_by_distance)

	if _targeted_resource != null:
		_targeted_resource.hide_as_collectable()

	if resources.size() > 0:
		_targeted_resource = resources[0]
		_targeted_resource.show_as_collectable()
	else:
		_targeted_resource = null


func _detect_resource_collection() -> void:
	if Input.is_action_just_pressed("action_collect") and _targeted_resource != null:
		var item_data = _targeted_resource.collect()
		InventoryStorage.add_item(item_data)

#endregion private
